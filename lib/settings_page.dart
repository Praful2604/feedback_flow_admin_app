import 'package:flutter/material.dart';
import 'set_password_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
          children: [
            // Button for resetting password using TextButton (Drawer-like style)



            // Switch for privacy setting


            Divider(height: 5,),
            //Divider(height: 5,),
            // Save button for privacy setting using TextButton (Drawer-like style)
            TextButton.icon(
              icon: const Icon(Icons.save, color: Colors.black87),
              label: const Text(
                "Save Privacy Setting",
                style: TextStyle(color: Colors.black87,fontSize: 20),
              ),
              onPressed: () {
                // Add your save action here
              },
            ),
            Divider(height: 5,),
          ],
        ),
      ),
    );
  }
}
