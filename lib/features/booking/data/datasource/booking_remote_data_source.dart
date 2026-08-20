import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/features/booking/data/models/booking_model.dart';
import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';

abstract class BookingRemoteDataSource {
  Future<void> addBooking(BookingModel bookingModel);

  Future<List<BookingModel>> getBookingsByUserId(String userId);

  Future<void> cancelBooking(String id);

  Future<BookingModel> getBookingModelFromId(String bookingId);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final FirebaseFirestore firestore;

  BookingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addBooking(BookingModel bookingModel) async {
    try {
      final docRef = firestore.collection('bookings').doc();

      await docRef.set(
        bookingModel
            .copyWith(bookingId: docRef.id)
            .toFirestore(isNeedBookingId: true),
      );
    } on FirebaseException catch (e) {
      throw ServerException('Failed to add booking: ${e.message}');
    } catch (e) {
      throw UnknownException(
        'An unknown error occurred while adding booking: $e',
      );
    }
  }

  @override
  Future<List<BookingModel>> getBookingsByUserId(String userId) async {
    try {
      final snapshot = await firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => BookingModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        'Failed to fetch bookings for user $userId: ${e.message}',
      );
    } catch (e) {
      throw UnknownException(
        'An unknown error occurred while fetching bookings for user $userId: $e',
      );
    }
  }

  @override
  Future<void> cancelBooking(String id) async {
    try {
      final docRef = firestore.collection('bookings').doc(id);

      await docRef.update({'status': BookingStatus.cancelled.name});

      // await firestore.runTransaction((transaction) async {
      //   final bookingRef = firestore.collection('bookings').doc(id);

      //   final snapshot = await transaction.get(bookingRef);

      //   final bookedSeats = snapshot['quantity'] as int;
      // });
    } on FirebaseException catch (e) {
      throw ServerException('Failed to cancel booking: ${e.message}');
    } catch (e) {
      throw UnknownException(
        'An unknown error occurred while canceling booking: $e',
      );
    }
  }

  @override
  Future<BookingModel> getBookingModelFromId(String bookingId) async {
    try {
      final docRef = firestore.collection('bookings').doc(bookingId);

      final snapshot = await docRef.get();

      return BookingModel.fromFirestore(snapshot);
    } on FirebaseException catch (e) {
      throw ServerException('Failed to get booking model: ${e.message}');
    } catch (e) {
      throw UnknownException(
        'An unknown error occurred while getting booking model: $e',
      );
    }
  }
}
