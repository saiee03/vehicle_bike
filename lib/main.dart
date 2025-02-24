import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/bike_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BikeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.orange,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
