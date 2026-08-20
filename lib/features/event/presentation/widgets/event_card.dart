import 'package:event_booking/features/event/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final EventEntity event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            event.image,
            height: 190,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                height: 190,
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.image, size: 60)),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: theme.textTheme.titleLarge),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    const SizedBox(width: 5),
                    Expanded(child: Text(event.location)),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18),
                    const SizedBox(width: 5),
                    Text(DateFormat('dd MMM yyyy').format(event.date)),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.event_seat, size: 18),
                    const SizedBox(width: 5),
                    Text("${event.availableSeats}/${event.totalSeats} Seats"),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Text(
                      "₹${event.price.toStringAsFixed(0)}",
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    // ElevatedButton(onPressed: () {}, child: const Text("Book")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
