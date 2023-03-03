import 'package:auth_car/Repository/Auth%20Repository/auth_repository.dart';
import 'package:auth_car/Screens/login_screen.dart';
import 'package:auth_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthRepository()));
  runApp(const AuthCar());
}

class AuthCar extends StatefulWidget {
  const AuthCar({Key? key}) : super(key: key);

  @override
  State<AuthCar> createState() => _AuthCarState();
}

class _AuthCarState extends State<AuthCar> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccColor),
      ),
      home: const LogInScreen(),
    );
  }
}
