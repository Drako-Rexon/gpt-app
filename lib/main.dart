import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini_app/providers/gemini_provider.dart';
import 'package:gemini_app/providers/internet_provider.dart';
import 'package:gemini_app/providers/permission_provider.dart';
import 'package:gemini_app/providers/permission_whatsapp_provider.dart';
import 'package:gemini_app/providers/user_provider.dart';
import 'package:gemini_app/firebase_options.dart';
import 'package:gemini_app/utils/popup.dart';
import 'package:gemini_app/view/auth/sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    dotenv.load(fileName: "assets/.env")
  ]);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final LocalAuthentication auth;
  // bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool value) {});

    _getAvailableBiometric();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GeminiProProvider()),
        ChangeNotifierProvider(create: (_) => InternetProvider()),
        ChangeNotifierProvider(create: (_) => PermissionProvider()),
        // * whatsapp status saver provider
        ChangeNotifierProvider(create: (_) => GetStatusProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
        ],
        theme: ThemeData(
            // textTheme: TextTheme().apply(displayColor: Colors.white),
            ),
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      if (await auth.canCheckBiometrics) {
        await auth.authenticate(
            localizedReason: 'Please login to enter the app',
            options: const AuthenticationOptions(
                biometricOnly: false, stickyAuth: true));
      }
    } on PlatformException catch (err) {
      popupWindow(context, err.details.toString(), err.message!);
    }
  }

  void _getAvailableBiometric() async {
    List<BiometricType> availableBiometric =
        await auth.getAvailableBiometrics();

    log('available biometric: ${availableBiometric.toString()}');

    if (!mounted || availableBiometric.isEmpty) {
      return;
    }

    _authenticate();
  }
}
