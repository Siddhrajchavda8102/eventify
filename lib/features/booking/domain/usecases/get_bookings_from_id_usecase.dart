import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';
import 'package:event_booking/features/booking/domain/repository/booking_repo.dart';

class GetBookingsFromIdUsecase {
  final BookingRepo bookingRepo;

  GetBookingsFromIdUsecase({required this.bookingRepo});

  Future<BookingEntity> call(String bookingId) async =>
      bookingRepo.getBookingModelFromId(bookingId);
}
