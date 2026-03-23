import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SolvedComplaintsPage extends StatefulWidget {
  @override
  _SolvedComplaintsPageState createState() => _SolvedComplaintsPageState();
}

class _SolvedComplaintsPageState extends State<SolvedComplaintsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> solvedComplaints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solved Complaints"),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('solvedComplaints')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No solved complaints found."));
          }

          // Data fetched from Firestore
          final solvedComplaintsList = snapshot.data!.docs;

          // Update the local list of solved complaints if new data is received
          if (solvedComplaintsList != solvedComplaints) {
            solvedComplaints = List.from(solvedComplaintsList);
          }

          return ListView.builder(
            itemCount: solvedComplaints.length,
            itemBuilder: (context, index) {
              final complaintDoc = solvedComplaints[index];
              final complaintData = complaintDoc.data() as Map<String, dynamic>;
              final complaintType = complaintData['complaintType'] ?? "Unknown";
              final showName = complaintData['showName'] ?? "No";
              final email = complaintData['email'] ?? "Anonymous";
              final description = complaintData['complaintDescription'] ?? "No description provided";
              final solutionDetails = complaintData['solutionDetails'] ?? "No solution details provided";
              final timestamp = complaintData['timestamp']?.toDate() ?? DateTime.now();

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Type: $complaintType",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text("Complaint: $description"),
                      const SizedBox(height: 5),
                      Text("Solution Details: $solutionDetails"),
                      const SizedBox(height: 5),
                      Text("Name: ${showName == 'Yes' ? email : 'Anonymous'}"),
                      const SizedBox(height: 5),
                      Text(
                        "Submitted On: ${timestamp.toString()}",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteComplaint(index, complaintDoc);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to handle the deletion of the complaint from the UI
  void _deleteComplaint(int index, DocumentSnapshot complaintDoc) async {
    final complaintData = complaintDoc.data() as Map<String, dynamic>;

    // First, we move the complaint back to 'allComplaints'
    try {
      await _firestore.collection('allComplaints').add({
        'complaintType': complaintData['complaintType'],
        'email': complaintData['email'],
        'complaintDescription': complaintData['complaintDescription'],
        'solutionDetails': complaintData['solutionDetails'],
        'showName': complaintData['showName'],
        'timestamp': complaintData['timestamp'],
      });

      // Now, we remove it from 'solvedComplaints'
      await _firestore.collection('solvedComplaints').doc(complaintDoc.id).delete();

      // Remove the complaint from the local list (UI)
      setState(() {
        solvedComplaints.removeAt(index);
      });

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complaint moved back to All Complaints")),
      );
    } catch (e) {
      // Handle errors in case something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
