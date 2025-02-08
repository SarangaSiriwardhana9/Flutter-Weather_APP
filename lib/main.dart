// Import necessary Flutter packages and local files
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/bottom_nav_bar.dart';

// This is the main function that runs when the app starts
void main() {
  runApp(const MyApp());
}

// This is the root widget of our app
class MyApp extends StatelessWidget {
  // Constructor for MyApp
  const MyApp({Key? key}) : super(key: key);

  // This method builds the UI for our app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the app title
      title: 'Weather App',
      // Define the app's theme (colors, text styles, etc.)
      theme: ThemeData(
        primaryColor: const Color(0xFF1E88E5),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      // Set the home screen of our app
      home: const MainScreen(),
    );
  }
}

// This is the main screen of our app, which can change state
class MainScreen extends StatefulWidget {
  // Constructor for MainScreen
  const MainScreen({Key? key}) : super(key: key);

  // Create the mutable state for this widget
  @override
  _MainScreenState createState() => _MainScreenState();
}

// This is the state for our MainScreen
class _MainScreenState extends State<MainScreen> {
  // Keep track of which screen is selected
  int _selectedIndex = 0;

  // List of all our screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];

  // This method is called when a bottom navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // This method builds the UI for our main screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show the selected screen
      body: _screens[_selectedIndex],
      // Show the bottom navigation bar
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
