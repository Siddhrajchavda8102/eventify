import 'package:event_booking/core/utils/app_session.dart';
import 'package:event_booking/core/utils/toast_util.dart';
import 'package:event_booking/features/booking/presentation/providers/booking_provider.dart';
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

  Future<int> selectQuantity(BuildContext context) async {
    final provider = context.read<BookingProvider>();

    final selectedQuantity = await showDialog<int>(
      context: context,
      builder: (context) {
        int quantity = 1;

        return AlertDialog(
          title: const Text("Select Quantity"),
          content: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(0),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              ),
              onPressed: () => Navigator.of(context).pop(quantity),
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );

    if (selectedQuantity != null) {
      provider.setSelectedQuantity(selectedQuantity);
    }

    return selectedQuantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();

    final event = eventProvider.eventEntityResult.data;

    return Scaffold(
      appBar: AppBar(title: const Text("Event Details")),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        child: SizedBox(
          height: 50,
          child: Consumer<BookingProvider>(
            builder: (context, provider, child) => ElevatedButton(
              onPressed: () async {
                final quantity = await selectQuantity(context);

                if (quantity <= 0) {
                  return;
                }

                if (event?.availableSeats == null ||
                    event!.availableSeats < quantity) {
                  ToastUtils().showErrorToast(
                    description: Text("Not enough seats available"),
                  );
                  return;
                }

                final userId = AppSession.currentUser?.userId ?? '';

                final totalPrice = (event.price) * quantity;

                final bookingModel = provider.getBookingModelFromEventId(
                  event,
                  userId: userId,
                  quantity: quantity,
                  totalPrice: totalPrice,
                );

                provider.addBooking(
                  bookingModel: bookingModel,
                  onSuccess: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Booking Successful")),
                    );

                    await eventProvider.updateEvent(event.eventId, -quantity);

                    // ignore: use_build_context_synchronously
                    await context.read<EventProvider>().getEvent(
                      widget.eventId,
                    );
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Booking Failed: $error")),
                    );
                  },
                );
              },
              child: provider.addBookingResult.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Book Now"),
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (eventProvider.eventEntityResult.isLoading) {
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
                        // 'lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
