import 'package:event_booking/features/booking/data/models/booking_model.dart';
import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';

abstract class BookingRepo {
  Future<void> addBooking(BookingModel bookingModel);

  Future<List<BookingEntity>> getBookingsByUserId(String userId);

  Future<void> cancelBooking(String id);

  Future<BookingEntity> getBookingModelFromId(String bookingId);
}
