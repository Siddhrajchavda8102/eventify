import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/features/event/data/models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getEvents();

  Future<EventModel> getEvent(String id);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final FirebaseFirestore firestore;

  EventRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<EventModel>> getEvents() async {
    try {
      final snapShot = await firestore.collection('events').get();

      return snapShot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch events.');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<EventModel> getEvent(String id) async {
    try {
      final event = await firestore.collection('events').doc(id).get();

      return EventModel.fromFirestore(event);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch event');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
