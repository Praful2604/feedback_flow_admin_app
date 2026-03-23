import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewComplaintPage extends StatefulWidget {
  @override
  _NewComplaintPageState createState() => _NewComplaintPageState();
}

class _NewComplaintPageState extends State<NewComplaintPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _complaintType = '';
  String _complaintDescription = '';
  String _email = '';
  bool _showName = false;

  final TextEditingController _complaintTypeController = TextEditingController();
  final TextEditingController _complaintDescriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _newComplaintId; // Store the ID of the newly added complaint

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Complaint"),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _complaintTypeController,
                decoration: const InputDecoration(
                  labelText: "Complaint Type",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint type';
                  }
                  return null;
                },
                onSaved: (value) {
                  _complaintType = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _complaintDescriptionController,
                decoration: const InputDecoration(
                  labelText: "Complaint Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _complaintDescription = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email (Optional)",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Show Name (Make Complaint Public)"),
                value: _showName,
                onChanged: (bool value) {
                  setState(() {
                    _showName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitComplaint,
                child: const Text("Submit Complaint"),
              ),

              // Display the newly added complaint below the form
              if (_newComplaintId != null)
                StreamBuilder<DocumentSnapshot>(
                  stream: _firestore
                      .collection('complaints')
                      .doc(_newComplaintId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("Error loading complaint"));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text("No complaint found"));
                    }

                    // Get complaint data
                    final complaintData = snapshot.data!;
                    final complaintType = complaintData['complaintType'];
                    final complaintDescription = complaintData['complaintDescription'];
                    final email = complaintData['email'];
                    final timestamp = complaintData['timestamp']?.toDate() ?? DateTime.now();

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              complaintType ?? "Unknown",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text("Complaint: $complaintDescription"),
                            const SizedBox(height: 5),
                            Text("Email: $email"),
                            const SizedBox(height: 5),
                            Text(
                              "Submitted On: ${timestamp.toString()}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitComplaint() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Save form data
      _formKey.currentState?.save();

      // Prepare the data to be saved in Firestore
      try {
        final complaintData = {
          'complaintType': _complaintType,
          'complaintDescription': _complaintDescription,
          'email': _email.isEmpty ? 'Anonymous' : _email,
          'showName': _showName ? 'Yes' : 'No',
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'unsolved', // Initial status of the complaint
        };

        // Save the complaint to the 'complaints' collection
        final docRef = await _firestore.collection('complaints').add(complaintData);

        // Save the ID of the newly added complaint
        setState(() {
          _newComplaintId = docRef.id;
        });

        // Show confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complaint submitted successfully!")),
        );
      } catch (e) {
        // Handle any errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to submit complaint")),
        );
      }
    }
  }
}
