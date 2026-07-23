import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> login({required String email, required String password});

  Future<void> logout();

  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firebaseFirestore);

  Never _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        throw AuthException('Email already exists.');

      case 'weak-password':
        throw AuthException('Password is too weak.');

      case 'invalid-email':
        throw AuthException('Invalid email address.');

      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        throw AuthException('Invalid email or password.');

      case 'too-many-requests':
        throw AuthException('Too many attempts. Please try again later.');

      default:
        throw AuthException(e.message ?? 'Authentication failed.');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    final document = await _firebaseFirestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!document.exists) {
      throw ServerException('User profile not found.');
    }

    return UserModel.fromFirestore(document);
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw AuthException('Invalid email or password.');
      }

      final document = await _firebaseFirestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      return UserModel.fromFirestore(document);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch user profile.');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw AuthException('registration failed.');
      }

      final user = UserModel(
        uid: firebaseUser.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      await _firebaseFirestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toFirestore());

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException('Email already exists.');

        case 'weak-password':
          throw AuthException('Password is too weak.');

        case 'invalid-email':
          throw AuthException('Invalid email address.');

        default:
          throw AuthException(e.message ?? 'Authentication failed.');
      }
    }
  }
}
