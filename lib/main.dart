import 'package:flutter/material.dart';
import 'package:gemini_app/controller/gemini_provider.dart';
import 'package:gemini_app/controller/internet_provider.dart';
import 'package:gemini_app/controller/user_provider.dart';
import 'package:gemini_app/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GeminiProProvider()),
        ChangeNotifierProvider(create: (_) => InternetProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            // textTheme: TextTheme().apply(displayColor: Colors.white),
            ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
