import 'package:event_booking/features/event/presentation/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  // final EventEntity event;
  final String eventId;

  const EventDetailsPage({super.key, required this.eventId});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<EventProvider>().getEvent(widget.eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventProvider>();

    final event = provider.eventEntityResult.data;

    return Scaffold(
      appBar: AppBar(title: const Text("Event Details")),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Book Event
            },
            child: const Text("Book Now"),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (provider.eventEntityResult.isLoading) {
            return CircularProgressIndicator();
          }

          if (event == null) {
            return Center(child: Text('No Event Details Found'));
          }

          final date = DateFormat('dd MMM yyyy').format(event.date);
          final time = DateFormat('hh:mm a').format(event.date);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(event.image, fit: BoxFit.cover),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text(event.category)),
                          Chip(label: Text("₹${event.price}")),
                        ],
                      ),

                      const SizedBox(height: 20),

                      _InfoTile(
                        icon: Icons.calendar_today,
                        title: "Date",
                        value: date,
                      ),

                      _InfoTile(
                        icon: Icons.access_time,
                        title: "Time",
                        value: time,
                      ),

                      _InfoTile(
                        icon: Icons.location_on,
                        title: "Location",
                        value: event.location,
                      ),

                      _InfoTile(
                        icon: Icons.event_seat,
                        title: "Seats Left",
                        value: "${event.availableSeats} / ${event.totalSeats}",
                      ),

                      const SizedBox(height: 24),

                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        event.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
