import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking/features/event/domain/entities/event_entity.dart';

class EventModel {
  final String eventId;
  final String title;
  final String description;
  final String image;
  final String category;
  final double price;
  final DateTime date;
  final String location;
  final double latitude;
  final double longitude;
  final String organizerId;
  final int totalSeats;
  final int availableSeats;
  final DateTime createdAt;

  EventModel({
    required this.eventId,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.price,
    required this.date,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.organizerId,
    required this.totalSeats,
    required this.availableSeats,
    required this.createdAt,
  });

  factory EventModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return EventModel(
      eventId: document.id,
      title: data['title'],
      description: data['description'],
      image: data['image'],
      category: data['category'],
      price: (data['price'] as num).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'],
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      organizerId: data['organizerId'],
      totalSeats: data['totalSeats'],
      availableSeats: data['availableSeats'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'category': category,
      'price': price,
      'date': Timestamp.fromDate(date),
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'organizerId': organizerId,
      'totalSeats': totalSeats,
      'availableSeats': availableSeats,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  EventEntity toEntity() {
    return EventEntity(
      eventId: eventId,
      title: title,
      description: description,
      image: image,
      category: category,
      price: price,
      date: date,
      location: location,
      latitude: latitude,
      longitude: longitude,
      organizerId: organizerId,
      totalSeats: totalSeats,
      availableSeats: availableSeats,
      createdAt: createdAt,
    );
  }
}
