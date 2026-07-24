import 'package:event_booking/features/event/domain/entities/event_entity.dart';
import 'package:event_booking/features/event/domain/repository/event_repository.dart';

class GetEventsUsecase {
  final EventRepository repository;

  GetEventsUsecase({required this.repository});

  Future<List<EventEntity>> call() {
    return repository.getEvents();
  }
}
