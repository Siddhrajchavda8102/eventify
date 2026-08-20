import 'package:event_booking/core/utils/toast_util.dart';
import 'package:event_booking/core/network/helpers/base_api_result.dart';
import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';
import 'package:event_booking/features/booking/presentation/providers/booking_provider.dart';
import 'package:event_booking/features/event/presentation/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingDetailsPage extends StatefulWidget {
  // final BookingEntity booking;
  final String id;

  const BookingDetailsPage({super.key, required this.id});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().getBookingFromId(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    final result = provider.getBookingFromIdResult;

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Details')),
      body: Builder(
        builder: (context) {
          switch (result.status) {
            case ApiStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ApiStatus.error:
              return Center(
                child: Text(result.errMessage ?? 'Something went wrong'),
              );
            case ApiStatus.completed:
              final bookingEntity = result.data;
              if (bookingEntity == null) {
                return const Center(child: Text('Booking not found'));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Image
                    if (bookingEntity.eventImage.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          bookingEntity.eventImage,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) {
                            return Container(
                              height: 200,
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Event Title
                    Text(
                      bookingEntity.eventTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 20),

                    _InfoRow(
                      title: 'Location',
                      value: bookingEntity.eventLocation,
                      icon: Icons.location_on_outlined,
                    ),

                    _InfoRow(
                      title: 'Event Date',
                      value: _formatDate(bookingEntity.eventDate),
                      icon: Icons.calendar_today_outlined,
                    ),

                    _InfoRow(
                      title: 'Seats',
                      value: '${bookingEntity.quantity}',
                      icon: Icons.people_outline,
                    ),

                    _InfoRow(
                      title: 'Price per Seat',
                      value:
                          '₹${bookingEntity.totalPrice / bookingEntity.quantity}',
                      icon: Icons.currency_rupee,
                    ),

                    _InfoRow(
                      title: 'Total Price',
                      value: '₹${bookingEntity.totalPrice}',
                      icon: Icons.payments_outlined,
                    ),

                    _InfoRow(
                      title: 'Booking ID',
                      value: bookingEntity.bookingId,
                      icon: Icons.confirmation_number_outlined,
                    ),

                    _InfoRow(
                      title: 'Booked At',
                      value: _formatDate(bookingEntity.bookedAt),
                      icon: Icons.access_time,
                    ),

                    const SizedBox(height: 20),

                    // Status
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bookingEntity.status.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Cancel button
                    if (bookingEntity.status == BookingStatus.booked)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<BookingProvider>().cancelBooking(
                              id: bookingEntity.bookingId,
                              onSuccess: () async {
                                ToastUtils().showSuccessToast(
                                  description: Text("Booking Cancelled"),
                                );

                                await context
                                    .read<BookingProvider>()
                                    .getBookingFromId(id: widget.id);

                                await context.read<EventProvider>().updateEvent(
                                  bookingEntity.eventId,
                                  bookingEntity.quantity,
                                );
                              },
                            );
                          },
                          child: const Text('Cancel Booking'),
                        ),
                      ),
                  ],
                ),
              );
            case ApiStatus.idle:
              return const SizedBox();
          }
        },
      ),
      // bottomNavigationBar: SafeArea(
      //   minimum: const EdgeInsets.fromLTRB(20, 0, 20, 50),
      //   child: SizedBox(
      //     height: 50,
      //     child: Consumer<BookingProvider>(
      //       builder: (context, provider, child) => ElevatedButton(
      //         onPressed: () async {},
      //         child: provider.addBookingResult.isLoading
      //             ? const CircularProgressIndicator(color: Colors.white)
      //             : const Text("Cancel Booking"),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoRow({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
