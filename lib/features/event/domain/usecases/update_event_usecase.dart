import 'package:event_booking/features/event/domain/repository/event_repository.dart';

class UpdateEventUseCase {
  final EventRepository eventRepository;

  UpdateEventUseCase({required this.eventRepository});

  Future<void> call(String id, int quantity) async {
    try {
      await eventRepository.updateEvent(id, quantity);
    } catch (e) {
      rethrow;
    }
  }
}
