// Import necessary Flutter package
import 'package:flutter/material.dart';

// This widget creates a bottom navigation bar
class BottomNavBar extends StatelessWidget {
  // Index of the currently selected item
  final int selectedIndex;
  // Function to call when an item is tapped
  final Function(int) onItemTapped;

  // Constructor that requires selectedIndex and onItemTapped
  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  // This method builds the UI for our bottom navigation bar
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // List of items in the navigation bar
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      // Set the current selected index
      currentIndex: selectedIndex,
      // Set the function to call when an item is tapped
      onTap: onItemTapped,
      // Set the color for the selected item
      selectedItemColor: const Color(0xFF1E88E5),
      // Set the color for unselected items
      unselectedItemColor: Colors.grey,
      // Set the background color of the navigation bar
      backgroundColor: Colors.white,
    );
  }
}
