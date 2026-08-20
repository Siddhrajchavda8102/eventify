import 'package:event_booking/features/booking/data/datasource/booking_remote_data_source.dart';
import 'package:event_booking/features/booking/data/models/booking_model.dart';
import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';
import 'package:event_booking/features/booking/domain/repository/booking_repo.dart';

class BookingRepoImpl implements BookingRepo {
  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRepoImpl({required this.bookingRemoteDataSource});

  @override
  Future<void> addBooking(BookingModel bookingModel) async {
    try {
      return await bookingRemoteDataSource.addBooking(bookingModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BookingEntity>> getBookingsByUserId(String userId) async {
    try {
      final list = await bookingRemoteDataSource.getBookingsByUserId(userId);

      return list.map((bookingModel) => bookingModel.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelBooking(String id) async {
    try {
      return await bookingRemoteDataSource.cancelBooking(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BookingEntity> getBookingModelFromId(String bookingId) async {
    try {
      final bookingModel = await bookingRemoteDataSource.getBookingModelFromId(
        bookingId,
      );

      return bookingModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
