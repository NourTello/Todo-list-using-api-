import 'package:flutter/material.dart';

import '../screens/settings.dart';

Widget ActionBarSettings(BuildContext context) => IconButton(
    onPressed: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen())),
    icon: Icon(Icons.settings));
