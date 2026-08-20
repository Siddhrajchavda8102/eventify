import 'package:event_booking/features/booking/domain/repository/booking_repo.dart';

class CancelBookingUsecase {
  final BookingRepo bookingRepo;

  CancelBookingUsecase({required this.bookingRepo});

  Future<void> cancelBooking(String id) async => bookingRepo.cancelBooking(id);
}
