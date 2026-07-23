import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () async {}, child: Text('Add Events')),
      ),
    );
  }
}


//  final events = [
//     {
//       "title": "Flutter Workshop 2026",
//       "description":
//           "Learn Flutter from beginner to advanced with hands-on projects.",
//       "image": "https://picsum.photos/600/400?1",
//       "category": "Technology",
//       "price": 499,
//       "date": "2026-08-15T10:00:00",
//       "location": "Ahmedabad, Gujarat",
//       "latitude": 23.0225,
//       "longitude": 72.5714,
//       "organizerId": "admin",
//       "totalSeats": 150,
//       "availableSeats": 150,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "AI & Gemini Bootcamp",
//       "description": "Build AI-powered Flutter apps using Gemini APIs.",
//       "image": "https://picsum.photos/600/400?2",
//       "category": "Technology",
//       "price": 999,
//       "date": "2026-08-25T09:30:00",
//       "location": "Surat, Gujarat",
//       "latitude": 21.1702,
//       "longitude": 72.8311,
//       "organizerId": "admin",
//       "totalSeats": 120,
//       "availableSeats": 120,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Live Music Festival",
//       "description": "Experience live performances from top artists.",
//       "image": "https://picsum.photos/600/400?3",
//       "category": "Music",
//       "price": 799,
//       "date": "2026-09-05T18:30:00",
//       "location": "Vadodara, Gujarat",
//       "latitude": 22.3072,
//       "longitude": 73.1812,
//       "organizerId": "admin",
//       "totalSeats": 500,
//       "availableSeats": 500,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Startup Networking Meetup",
//       "description": "Meet entrepreneurs, investors and startup founders.",
//       "image": "https://picsum.photos/600/400?4",
//       "category": "Business",
//       "price": 299,
//       "date": "2026-08-10T17:00:00",
//       "location": "Rajkot, Gujarat",
//       "latitude": 22.3039,
//       "longitude": 70.8022,
//       "organizerId": "admin",
//       "totalSeats": 200,
//       "availableSeats": 200,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Cricket Premier League Finals",
//       "description": "Watch the biggest cricket final live.",
//       "image": "https://picsum.photos/600/400?5",
//       "category": "Sports",
//       "price": 1500,
//       "date": "2026-09-20T19:00:00",
//       "location": "Narendra Modi Stadium, Ahmedabad",
//       "latitude": 23.0917,
//       "longitude": 72.5970,
//       "organizerId": "admin",
//       "totalSeats": 1000,
//       "availableSeats": 1000,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Photography Masterclass",
//       "description":
//           "Learn professional photography techniques from industry experts.",
//       "image": "https://picsum.photos/600/400?6",
//       "category": "Workshop",
//       "price": 699,
//       "date": "2026-08-18T11:00:00",
//       "location": "Bhavnagar, Gujarat",
//       "latitude": 21.7645,
//       "longitude": 72.1519,
//       "organizerId": "admin",
//       "totalSeats": 80,
//       "availableSeats": 80,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Food Carnival",
//       "description": "Taste delicious dishes from over 100 food stalls.",
//       "image": "https://picsum.photos/600/400?7",
//       "category": "Food",
//       "price": 199,
//       "date": "2026-08-30T12:00:00",
//       "location": "Sabarmati Riverfront, Ahmedabad",
//       "latitude": 23.0307,
//       "longitude": 72.5802,
//       "organizerId": "admin",
//       "totalSeats": 1000,
//       "availableSeats": 1000,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Ahmedabad Marathon 10K",
//       "description":
//           "Annual city marathon for runners of all experience levels.",
//       "image": "https://picsum.photos/600/400?8",
//       "category": "Sports",
//       "price": 399,
//       "date": "2026-10-02T06:00:00",
//       "location": "Ahmedabad, Gujarat",
//       "latitude": 23.0225,
//       "longitude": 72.5714,
//       "organizerId": "admin",
//       "totalSeats": 800,
//       "availableSeats": 800,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Gaming Championship",
//       "description": "Compete in Valorant, BGMI and FIFA tournaments.",
//       "image": "https://picsum.photos/600/400?9",
//       "category": "Gaming",
//       "price": 599,
//       "date": "2026-09-10T10:00:00",
//       "location": "Surat Convention Centre",
//       "latitude": 21.1702,
//       "longitude": 72.8311,
//       "organizerId": "admin",
//       "totalSeats": 300,
//       "availableSeats": 300,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//     {
//       "title": "Digital Marketing Summit",
//       "description":
//           "Learn SEO, Social Media Marketing, AI tools and Branding.",
//       "image": "https://picsum.photos/600/400?10",
//       "category": "Business",
//       "price": 899,
//       "date": "2026-09-15T09:00:00",
//       "location": "Gandhinagar, Gujarat",
//       "latitude": 23.2156,
//       "longitude": 72.6369,
//       "organizerId": "admin",
//       "totalSeats": 250,
//       "availableSeats": 250,
//       "createdAt": "2026-07-22T10:00:00",
//     },
//   ];

 