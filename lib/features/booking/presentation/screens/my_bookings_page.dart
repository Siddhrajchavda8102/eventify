import 'package:event_booking/core/network/helpers/base_api_result.dart';
import 'package:event_booking/core/router/app_routes.dart';
import 'package:event_booking/features/booking/domain/entities/booking_entity.dart';
import 'package:event_booking/features/booking/presentation/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ---------------- Page ----------------

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().getBookingsByUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();

    final bookings = provider.getBookingList;

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: Builder(
        builder: (context) {
          switch (provider.getBookingListResult.status) {
            case ApiStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case ApiStatus.error:
              return Center(
                child: Text(
                  provider.getBookingListResult.errMessage ??
                      "Something went wrong",
                ),
              );
            case ApiStatus.completed:
              return bookings.isEmpty
                  ? const _EmptyBookingsView()
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: bookings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemBuilder: (context, index) => BookingCard(
                        booking: bookings[index],
                        onTap: () {
                          context
                              .pushNamed(
                                Routes.bookingDetailsName,
                                extra: bookings[index].bookingId,
                              )
                              .then((_) {
                                if (!context.mounted) return;
                                context
                                    .read<BookingProvider>()
                                    .getBookingsByUserId();
                              });
                        },
                      ),
                    );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class _EmptyBookingsView extends StatelessWidget {
  const _EmptyBookingsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_busy_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            'No bookings yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

// ---------------- Card ----------------

class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback? onTap;

  const BookingCard({super.key, required this.booking, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final statusStyle = _statusStyle(booking.status);
    final currency = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE3E6EF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + status badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    booking.eventTitle,
                    style: textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _StatusBadge(style: statusStyle),
              ],
            ),
            const SizedBox(height: 10),

            // Date
            _IconText(
              icon: Icons.calendar_today_outlined,
              text: DateFormat('dd MMM yyyy').format(booking.eventDate),
              textTheme: textTheme,
            ),
            const SizedBox(height: 6),

            // Location
            _IconText(
              icon: Icons.location_on_outlined,
              text: booking.eventLocation,
              textTheme: textTheme,
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade200, height: 1),
            const SizedBox(height: 12),

            // Seats + price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _IconText(
                  icon: Icons.event_seat_outlined,
                  text:
                      '${booking.quantity} Seat${booking.quantity > 1 ? 's' : ''}',
                  textTheme: textTheme,
                ),
                Text(
                  currency.format(booking.totalPrice),
                  style: textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF2F5CF0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _StatusStyle _statusStyle(BookingStatus status) {
    switch (status) {
      case BookingStatus.booked:
        return _StatusStyle(
          label: 'Booked',
          background: const Color(0xFFD3F5E8),
          textColor: const Color(0xFF0B7A4B),
        );
      case BookingStatus.completed:
        return _StatusStyle(
          label: 'Completed',
          background: const Color(0xFFE6ECFB),
          textColor: const Color(0xFF2F5CF0),
        );
      case BookingStatus.cancelled:
        return _StatusStyle(
          label: 'Cancelled',
          background: const Color(0xFFFBE3E1),
          textColor: const Color(0xFFC0392B),
        );
      case BookingStatus.refunded:
        return _StatusStyle(
          label: 'Refunded',
          background: const Color(0xFFFDE9C8),
          textColor: const Color(0xFF9A6400),
        );
    }
  }
}

class _StatusStyle {
  final String label;
  final Color background;
  final Color textColor;

  _StatusStyle({
    required this.label,
    required this.background,
    required this.textColor,
  });
}

class _StatusBadge extends StatelessWidget {
  final _StatusStyle style;
  const _StatusBadge({required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        style.label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: style.textColor),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextTheme textTheme;

  const _IconText({
    required this.icon,
    required this.text,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Text(
          text,
          style: textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
