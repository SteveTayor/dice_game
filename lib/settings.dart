import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/audio_settings_providers.dart';
import 'providers/settings_providers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Enable Sound'),
            value: settingsProvider.enableAudio,
            onChanged: (value) {
              settingsProvider.enableAudio = value;
            },
          ),
          SwitchListTile(
            title: const Text('Change background Image'),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                final provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(value);
              },
          ),
        ],
      ),
    );
  }
}
