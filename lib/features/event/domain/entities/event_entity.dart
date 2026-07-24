class EventEntity {
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

  const EventEntity({
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
}
