import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplaintsPage extends StatefulWidget {
  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String selectedComplaintType = 'All';
  String selectedDateFilter = 'All';

  List<String> complaintTypes = ['All', 'Campus', 'Teaching', 'Faculty', 'Bus'];
  List<String> dateFilters = ['All', '1 day ago', '5 days ago', 'Older'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints"),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Filters Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Complaint Type Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedComplaintType,
                    isExpanded: true,
                    items: complaintTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedComplaintType = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // Date Filter Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDateFilter,
                    isExpanded: true,
                    items: dateFilters.map((filter) {
                      return DropdownMenuItem(
                        value: filter,
                        child: Text(filter),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDateFilter = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('complaints')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No complaints found."));
                }

                final complaints = snapshot.data!.docs;

                // Apply Filters
                final now = DateTime.now();

                final filteredComplaints = complaints.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final complaintType = data['complaintType'] ?? "Unknown";
                  final timestamp = data['timestamp']?.toDate() ?? DateTime.now();

                  // Complaint Type Filter
                  if (selectedComplaintType != 'All' && complaintType != selectedComplaintType) {
                    return false;
                  }

                  // Date Filter
                  final difference = now.difference(timestamp).inDays;
                  if (selectedDateFilter == '1 day ago' && difference > 1) return false;
                  if (selectedDateFilter == '5 days ago' && (difference <= 1 || difference > 5)) return false;
                  if (selectedDateFilter == 'Older' && difference <= 5) return false;

                  return true;
                }).toList();

                return filteredComplaints.isEmpty
                    ? const Center(child: Text("No complaints matching filters."))
                    : ListView.builder(
                  itemCount: filteredComplaints.length,
                  itemBuilder: (context, index) {
                    final complaintDoc = filteredComplaints[index];
                    final data = complaintDoc.data() as Map<String, dynamic>;

                    final complaintType = data['complaintType'] ?? "Unknown";
                    final showName = data['showName'] ?? "No";
                    final email = data['email'] ?? "Anonymous";
                    final description = data['complaintDescription'] ?? "No description provided";
                    final solution = data['solution'] ?? "No solution provided";
                    final timestamp = data['timestamp']?.toDate() ?? DateTime.now();
                    final status = data['status'] ?? 'pending';

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              complaintType,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text("Complaint: $description"),
                            const SizedBox(height: 5),
                            Text("Suggested Solution: $solution"),
                            const SizedBox(height: 5),
                            Text("Name: ${showName == 'Yes' ? email : 'Not Provided'}"),
                            const SizedBox(height: 5),
                            Text(
                              "Submitted On: ${DateFormat('yyyy-MM-dd – kk:mm').format(timestamp)}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  status == 'solved' ? 'Solved' : 'Pending',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: status == 'solved' ? Colors.green : Colors.orange,
                                  ),
                                ),
                                if (status != 'solved')
                                  IconButton(
                                    icon: const Icon(Icons.check_circle, color: Colors.green),
                                    onPressed: () {
                                      _markAsSolved(context, complaintDoc.id, email, description);
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _markAsSolved(BuildContext context, String complaintId, String email, String description) {
    final TextEditingController _solutionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Mark as Solved"),
          content: TextField(
            controller: _solutionController,
            decoration: const InputDecoration(
              labelText: "How was this complaint solved?",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final solutionDetails = _solutionController.text.trim();

                if (solutionDetails.isNotEmpty) {
                  await _firestore.collection('complaints').doc(complaintId).update({
                    'status': 'solved',
                    'solutionDetails': solutionDetails,
                  });

                  final complaintData = await _firestore.collection('complaints').doc(complaintId).get();
                  await _firestore.collection('solvedComplaints').add({
                    'complaintType': complaintData['complaintType'],
                    'showName': complaintData['showName'],
                    'email': complaintData['email'],
                    'complaintDescription': complaintData['complaintDescription'],
                    'solutionDetails': solutionDetails,
                    'timestamp': complaintData['timestamp'],
                  });

                  await _openEmailApp(email, solutionDetails, description);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Complaint marked as solved, email app opened.")),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please provide details for the solution")),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openEmailApp(String recipientEmail, String solutionDetails, String description) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      queryParameters: {
        'subject': 'Complaint Resolved',
        'body': 'Your complaint has been resolved.\n\nComplaint: $description\nSolution: $solutionDetails\n\nThank you for your patience.'
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email app';
    }
  }
}
