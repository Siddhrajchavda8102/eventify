import 'package:event_booking/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> login({required String email, required String password});

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();
}
