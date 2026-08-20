import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/core/network/helpers/base_api_result.dart';
import 'package:event_booking/core/network/helpers/base_notifier.dart';
import 'package:event_booking/core/utils/app_session.dart';
import 'package:event_booking/features/booking/data/models/booking_model.dart';
import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';
import 'package:event_booking/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:event_booking/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:event_booking/features/booking/domain/usecases/get_bookings_from_id_usecase.dart';
import 'package:event_booking/features/booking/domain/usecases/get_bookings_usecase.dart';
import 'package:event_booking/features/event/domain/entities/event_entity.dart';
import 'package:flutter/foundation.dart';

class BookingProvider extends BaseNotifier {
  final AddBookingUsecase addBookingUsecase;
  final GetBookingsUsecase getBookingsUsecase;
  final CancelBookingUsecase cancelBookingUsecase;
  final GetBookingsFromIdUsecase getBookingsFromIdUsecase;

  BookingProvider({
    required this.addBookingUsecase,
    required this.getBookingsUsecase,
    required this.cancelBookingUsecase,
    required this.getBookingsFromIdUsecase,
  });

  BaseApiResult<void> addBookingResult = BaseApiResult();
  BaseApiResult<List<BookingEntity>> getBookingListResult = BaseApiResult();
  BaseApiResult<void> cancelBookingResult = BaseApiResult();
  BaseApiResult<BookingEntity> getBookingFromIdResult = BaseApiResult();

  List<BookingEntity> get getBookingList => getBookingListResult.data ?? [];

  int _selectedQuantity = 0;
  int get selectedQuantity => _selectedQuantity;

  void setSelectedQuantity(int quantity) {
    _selectedQuantity = quantity;
    notifyListeners();
  }

  Future<void> addBooking({
    required BookingModel bookingModel,
    VoidCallback? onSuccess,
    ValueChanged<String>? onError,
  }) async {
    try {
      setIsLoading(addBookingResult);

      await addBookingUsecase.call(bookingModel);

      setIsCompleted(addBookingResult, null);
      onSuccess?.call();
    } on AppException catch (e) {
      setIsError(addBookingResult, e.message);
      onError?.call(e.message);
    } catch (e) {
      setIsError(addBookingResult, e.toString());
      onError?.call(e.toString());
    }
  }

  Future<void> getBookingFromId({
    required String id,
    VoidCallback? onSuccess,
    ValueChanged<String>? onError,
  }) async {
    try {
      setIsLoading(getBookingFromIdResult);

      final data = await getBookingsFromIdUsecase.call(id);

      setIsCompleted(getBookingFromIdResult, data);
    } on AppException catch (e) {
      setIsError(getBookingFromIdResult, e.message);
      onError?.call(e.message);
    } catch (e) {
      setIsError(getBookingFromIdResult, e.toString());
      onError?.call(e.toString());
    }
  }

  Future<void> getBookingsByUserId({
    VoidCallback? onSuccess,
    ValueChanged<String>? onError,
  }) async {
    try {
      setIsLoading(getBookingListResult);

      final list = await getBookingsUsecase.call(
        AppSession.currentUser?.uid ?? '',
      );

      setIsCompleted(getBookingListResult, list);
    } on AppException catch (e) {
      setIsError(getBookingListResult, e.message);
      onError?.call(e.message);
    } catch (e) {
      setIsError(getBookingListResult, e.toString());
      onError?.call(e.toString());
    }
  }

  Future<void> cancelBooking({
    required String id,
    VoidCallback? onSuccess,
    ValueChanged<String>? onError,
  }) async {
    try {
      setIsLoading(cancelBookingResult);

      await cancelBookingUsecase.cancelBooking(id);

      setIsCompleted(cancelBookingResult, null);
      onSuccess?.call();
    } on AppException catch (e) {
      setIsError(cancelBookingResult, e.message);
      onError?.call(e.message);
    } catch (e) {
      setIsError(cancelBookingResult, e.toString());
      onError?.call(e.toString());
    }
  }

  BookingModel getBookingModelFromEventId(
    EventEntity? event, {
    required String userId,
    required int quantity,
    required double totalPrice,
  }) {
    if (event == null) {
      throw ArgumentError('Event cannot be null');
    }

    return BookingModel(
      bookingId: '',
      userId: userId,
      eventId: event.eventId,
      eventTitle: event.title,
      eventImage: event.image,
      eventLocation: event.location,
      eventDate: event.date,
      quantity: quantity,
      totalPrice: totalPrice,
      status: BookingStatus.booked,
      bookedAt: DateTime.now(),
    );
  }
}
