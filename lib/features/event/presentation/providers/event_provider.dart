import 'dart:collection';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/core/network/helpers/base_api_result.dart';
import 'package:event_booking/core/network/helpers/base_notifier.dart';
import 'package:event_booking/features/event/domain/entities/event_entity.dart';
import 'package:event_booking/features/event/domain/usecases/get_event_usecase.dart';
import 'package:event_booking/features/event/domain/usecases/get_events_usecase.dart';

enum EventCategory {
  all(label: "All"),
  technology(label: "Technology"),
  music(label: "Music"),
  sports(label: "Sports"),
  business(label: "Business"),
  food(label: "Food"),
  workshop(label: "Workshop"),
  gaming(label: "Gaming");

  final String label;
  const EventCategory({required this.label});
}

class EventProvider extends BaseNotifier {
  final GetEventsUsecase getEventsUsecase;
  final GetEventUsecase getEventUsecase;

  EventProvider({
    required this.getEventsUsecase,
    required this.getEventUsecase,
  });

  BaseApiResult<List<EventEntity>> eventListResult = BaseApiResult();
  BaseApiResult<EventEntity> eventEntityResult = BaseApiResult();

  List<EventEntity> get events =>
      UnmodifiableListView(eventListResult.data ?? []);

  List<EventEntity> filteredEvents = [];
  String searchQuery = '';

  EventCategory selectedCategory = EventCategory.all;
  List<String> get categories =>
      EventCategory.values.map((e) => e.label).toList();

  Future<void> getEvents() async {
    try {
      setIsLoading(eventListResult);

      final list = await getEventsUsecase.call();
      filteredEvents = list;

      setIsCompleted(eventListResult, list);
    } on AppException catch (e) {
      setIsError(eventListResult, e.message);
    } catch (e) {
      setIsError(eventListResult, e.toString());
    }
  }

  Future<void> getEvent(String id) async {
    try {
      setIsLoading(eventEntityResult);

      final eventData = await getEventUsecase.call(id);

      setIsCompleted(eventEntityResult, eventData);
    } on AppException catch (e) {
      setIsError(eventEntityResult, e.message);
    } catch (e) {
      setIsError(eventEntityResult, e.toString());
    }
  }

  void onSelectCategory(EventCategory category) {
    selectedCategory = category;

    filterEvent(isNotify: false);
    notifyListeners();
  }

  void searchEvents(String query) {
    filterEvent(isNotify: false);
    query = query.toLowerCase();
    if (query.isEmpty) {
      notifyListeners();
      return;
    }

    filteredEvents = filteredEvents.where((event) {
      if (event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query) ||
          event.price.toString().contains(query)) {
        return true;
      }
      return false;
    }).toList();

    notifyListeners();
  }

  void filterEvent({bool isNotify = true}) {
    if (selectedCategory == EventCategory.all) {
      filteredEvents = eventListResult.data ?? [];
      notifyListeners();
      return;
    }

    filteredEvents =
        eventListResult.data
            ?.where(
              (event) =>
                  selectedCategory.name.toLowerCase() ==
                  event.category.toLowerCase(),
            )
            .toList() ??
        [];

    if (isNotify) {
      notifyListeners();
    }
  }
}
