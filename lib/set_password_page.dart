import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _savePassword() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final prefs = await SharedPreferences.getInstance();
    String newPassword = _newPasswordController.text;

    // Save password
    await prefs.setString('password', newPassword);

    try {
      // Log for debugging
      print("Sending email...");

      // Send email
      await _sendPasswordByEmail(newPassword);

      print("Password updated and email sent.");

      // Delay for 5 seconds before showing the confirmation dialog
      await Future.delayed(Duration(seconds: 5));

      // Show confirmation dialog after 5 seconds
      _showConfirmationDialog();
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send password: $e")),
      );
    }

    setState(() {
      _isLoading = false; // Hide loading indicator after 5 seconds
    });
  }

  Future<void> _sendPasswordByEmail(String password) async {
    final Email email = Email(
      body: 'Your new password is: $password',
      subject: 'New Password Set',
      recipients: ['prafulkadam226@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      print("Email sent successfully!");
    } catch (e) {
      print("Error sending email: $e");
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Password Updated"),
          content: const Text("Your password has been updated and sent via email."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set New Password"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Set a New Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _savePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Save Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
