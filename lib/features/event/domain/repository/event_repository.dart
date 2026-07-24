import 'package:event_booking/features/event/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<List<EventEntity>> getEvents();

  Future<EventEntity> getEvent(String id);
}
