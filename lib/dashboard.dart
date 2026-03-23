import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SolvedComplaintsPage.dart';
import 'NewComplaintPage.dart';
import 'login_page.dart';
import 'my_complaint_page.dart';
import 'settings_page.dart';
import 'pie_chart_display.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  const SizedBox(height: 60),
                  Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    children: [
                      _buildGlassButton(
                        label: "All Complaints",
                        icon: Icons.list,
                        color: Colors.blueAccent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ComplaintsPage()));
                        },
                      ),
                      _buildGlassButton(
                        label: "Unsolved Complaints",
                        icon: Icons.report_problem,
                        color: Colors.redAccent,
                        onTap: () {
                          // Add navigation if needed
                        },
                      ),
                      _buildGlassButton(
                        label: "Solved Complaints",
                        icon: Icons.check_circle,
                        color: Colors.orangeAccent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SolvedComplaintsPage()));
                        },
                      ),
                      _buildGlassButton(
                        label: "Pie Chart",
                        icon: Icons.pie_chart,
                        color: Colors.greenAccent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PieChartDisplay()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Glass Button Widget
  Widget _buildGlassButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.cyan),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome Admin!",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            label: "Home",
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.check_circle,
            label: "Solved Complaints",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SolvedComplaintsPage()));
            },
          ),
          _buildDrawerItem(
            icon: Icons.pie_chart,
            label: "Pie Chart",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => PieChartDisplay()));
            },
          ),
          _buildDrawerItem(
            icon: Icons.all_inbox,
            label: "All Complaints",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ComplaintsPage()));
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            label: "Settings",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
          const Spacer(),
          _buildDrawerItem(
            icon: Icons.logout,
            label: "Logout",
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // Drawer Items
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.cyan),
      title: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  // Logout Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
