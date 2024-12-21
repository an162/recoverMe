
import 'package:flutter/material.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 5, 97, 173), 
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
        color: const Color.fromARGB(255, 5, 97, 173), 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white, 
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'RecoverMe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.health_and_safety, color: Colors.white),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.white),
              title: Text(
                'Activities',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, '/activities');
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}