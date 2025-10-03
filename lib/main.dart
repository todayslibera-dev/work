import 'package:flutter/material.dart';

import 'clova_debug_page.dart';
import 'home_page.dart';
import 'src/shared/di/service_locator.dart';
import 'src/shared/app_strings.dart'; // Added

const String clovaApiKey = String.fromEnvironment(
  'CLOVA_API_KEY',
  defaultValue: '',
);

void main() {
  setupLocator(clovaApiKey);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorSchemeSeed: Colors.deepPurple,
      useMaterial3: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle, // Modified
      theme: theme,
      routes: {
        '/': (_) => HomePage(),
        ClovaDebugPage.routeName: (_) => ClovaDebugPage(apiKey: clovaApiKey),
      },
    );
  }
}
