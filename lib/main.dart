import 'package:flutter/material.dart';
import 'package:random/register.dart';
import 'home.dart';
import 'login.dart';
import 'chat screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const home(), initialRoute: '/home', routes: {
      '/login': (context) => const login(),
      '/register': (context) => const register(),
      '/home': (context) => const home(),
      '/chat screen': (context) => const chat(),
    });
  }
}
