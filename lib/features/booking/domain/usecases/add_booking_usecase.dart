import 'package:event_booking/features/booking/data/models/booking_model.dart';
import 'package:event_booking/features/booking/domain/repository/booking_repo.dart';

class AddBookingUsecase {
  final BookingRepo bookingRepo;

  AddBookingUsecase({required this.bookingRepo});

  Future<void> call(BookingModel bookingModel) async {
    return await bookingRepo.addBooking(bookingModel);
  }
}
