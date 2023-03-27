import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upwork/providers/firebase_provider.dart';
import 'package:upwork/view/dashboard/screen/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD-ZGT8krkrJ2LafgboYFPB-FkBhjefq3k',
      appId: '1:1022477161:web:b9b49b169a54c40dd873f8',
      messagingSenderId: '1022477161',
      projectId: 'inventoryapp-b78bc',
    ),
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => FirebaseProvider())],
    child: const ChickenPizzaApp(),
  ));
}

class ChickenPizzaApp extends StatelessWidget {
  const ChickenPizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      home: DashboardScreen(),
    );
  }
}
