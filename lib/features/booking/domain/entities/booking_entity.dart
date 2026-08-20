class BookingEntity {
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

  BookingEntity({
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
}

enum BookingStatus { booked, cancelled, completed, refunded }
