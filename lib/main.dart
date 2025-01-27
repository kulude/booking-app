import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sun Breeze Hotels',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Color.fromARGB(255, 155, 155, 155),
          titleTextStyle: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const RoomDetailsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sun Breeze Hotels'),
      ),
      drawer: const AppDrawer(),
      body: const RoomList(),
    );
  }
}

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final List<Map<String, dynamic>> rooms = List.generate(
    15,
    (index) => {'name': 'Room ${index + 1}', 'isBooked': false},
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.room, color: Colors.blueGrey),
            title: Text(room['name']),
            subtitle: Text(room['isBooked'] ? 'Booked' : 'Available'),
            trailing: Switch(
              value: room['isBooked'],
              onChanged: (bool value) {
                setState(() {
                  rooms[index]['isBooked'] = value;
                });

                if (value) {
                  _showBookingDialog(context, room['name']);
                }
              },
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: room,
              );
            },
          ),
        );
      },
    );
  }

  void _showBookingDialog(BuildContext context, String roomName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Confirmation'),
          content: Text('You have successfully booked $roomName.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final room = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(room['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              room['name'],
            ),
            const SizedBox(height: 16),
            Text(
              room['isBooked'] ? 'Status: Booked' : 'Status: Available',
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sun Breeze Hotels',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your comfort, our priority!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // Add an About page here.
            },
          ),
        ],
      ),
    );
  }
}
