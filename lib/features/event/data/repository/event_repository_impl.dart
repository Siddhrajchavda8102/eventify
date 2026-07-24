import 'package:event_booking/features/event/data/datasource/event_remote_datasource.dart';
import 'package:event_booking/features/event/domain/entities/event_entity.dart';
import 'package:event_booking/features/event/domain/repository/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource eventRemoteDataSource;

  EventRepositoryImpl({required this.eventRemoteDataSource});

  @override
  Future<List<EventEntity>> getEvents() async {
    try {
      final eventModelList = await eventRemoteDataSource.getEvents();

      return eventModelList.map((event) => event.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EventEntity> getEvent(String id) async {
    try {
      final eventModel = await eventRemoteDataSource.getEvent(id);

      return eventModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
