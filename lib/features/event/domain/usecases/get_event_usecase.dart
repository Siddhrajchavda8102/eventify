import 'package:event_booking/features/event/domain/entities/event_entity.dart';
import 'package:event_booking/features/event/domain/repository/event_repository.dart';

class GetEventUsecase {
  final EventRepository eventRepository;

  GetEventUsecase({required this.eventRepository});

  Future<EventEntity> call(String id) async {
    return await eventRepository.getEvent(id);
  }
}
