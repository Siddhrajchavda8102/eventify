import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';
import 'package:event_booking/features/booking/domain/repository/booking_repo.dart';

class GetBookingsUsecase {
  final BookingRepo bookingRepo;

  GetBookingsUsecase({required this.bookingRepo});

  Future<List<BookingEntity>> call(String userId) async {
    return bookingRepo.getBookingsByUserId(userId);
  }
}
