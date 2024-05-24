import 'package:forus/services/auth_services.dart';
import 'package:forus/services/navigation_service.dart';
import 'package:forus/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await setUp();
  runApp(MyApp());
}

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthServices _authServices;

  MyApp({super.key}) {
    _navigationService = _getIt.get<NavigationService>();
    _authServices = _getIt.get<AuthServices>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.ubuntuTextTheme(),
      ),
      initialRoute:_authServices.user !=null ?"/home":"/login",
      routes: _navigationService.routes,
    );
  }
}
