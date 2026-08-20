import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;

  final String userId;
  final String eventId;
  final String eventTitle;
  final String eventImage;
  final String eventLocation;
  final DateTime eventDate;

  final int quantity;
  final double totalPrice;

  final BookingStatus status;
  final DateTime bookedAt;

  BookingModel({
    required this.bookingId,
    required this.userId,
    required this.eventId,
    required this.eventTitle,
    required this.eventImage,
    required this.eventLocation,
    required this.eventDate,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.bookedAt,
  });

  Map<String, dynamic> toFirestore({bool isNeedBookingId = false}) {
    return <String, dynamic>{
      if (isNeedBookingId) "bookingId": bookingId,
      "userId": userId,
      "eventId": eventId,
      "eventTitle": eventTitle,
      "eventImage": eventImage,
      "eventLocation": eventLocation,
      "eventDate": Timestamp.fromDate(eventDate),
      "quantity": quantity,
      "totalPrice": totalPrice,
      "status": status.name,
      "bookedAt": Timestamp.fromDate(bookedAt),
    };
  }

  factory BookingModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return BookingModel(
      bookingId: document.id,
      userId: data['userId'],
      eventId: data['eventId'],
      eventTitle: data['eventTitle'],
      eventImage: data['eventImage'],
      eventLocation: data['eventLocation'],
      eventDate: (data['eventDate'] as Timestamp).toDate(),
      quantity: data['quantity'],
      totalPrice: (data['totalPrice'] as num).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => BookingStatus.booked,
      ),
      bookedAt: (data['bookedAt'] as Timestamp).toDate(),
    );
  }

  BookingEntity toEntity() {
    return BookingEntity(
      bookingId: bookingId,
      userId: userId,
      eventId: eventId,
      eventTitle: eventTitle,
      eventImage: eventImage,
      eventLocation: eventLocation,
      eventDate: eventDate,
      quantity: quantity,
      totalPrice: totalPrice,
      status: status,
      bookedAt: bookedAt,
    );
  }

  BookingModel copyWith({
    String? bookingId,
    String? userId,
    String? eventId,
    String? eventTitle,
    String? eventImage,
    String? eventLocation,
    DateTime? eventDate,
    int? quantity,
    double? totalPrice,
    BookingStatus? status,
    DateTime? bookedAt,
  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      eventTitle: eventTitle ?? this.eventTitle,
      eventImage: eventImage ?? this.eventImage,
      eventLocation: eventLocation ?? this.eventLocation,
      eventDate: eventDate ?? this.eventDate,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      bookedAt: bookedAt ?? this.bookedAt,
    );
  }
}
