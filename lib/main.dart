import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/providers/app_providers.dart';
import 'package:gokul_weds_vrinda/screens/landing/landing_page.dart';
import 'package:gokul_weds_vrinda/services/firebase_services.dart';
import 'package:provider/provider.dart';

void main() async {
  await FirebaseServices.init();
  runApp(
    MultiProvider(providers: AppProviders.allProviders, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gokul weds Vrinda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LandingPage(),
    );
  }
}
