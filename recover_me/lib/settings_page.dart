import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _isSoundsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // GENERAL section
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GENERAL', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                _buildListTile('General', Icons.settings),
                _buildSwitchTile('Dark Mode', _isDarkMode, (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                }),
                _buildListTile('Security', Icons.lock),
                _buildListTile('Notifications', Icons.notifications),
                _buildSwitchTile('Sounds', _isSoundsEnabled, (value) {
                  setState(() {
                    _isSoundsEnabled = value;
                  });
                }),
                _buildListTile('Vacation Mode', Icons.beach_access),
              ],
            ),
          ),
          Divider(),
          // ABOUT US section
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ABOUT US', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                _buildListTile('Rate Routiner', Icons.star),
                _buildListTile('Share with Friends', Icons.share),
                _buildListTile('About Us', Icons.info),
                _buildListTile('Support', Icons.support),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile(String title, IconData icon) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon),
      onTap: () {
        // Handle navigation or action
      },
    );
  }

  SwitchListTile _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}