import 'package:auth_car/Controllers/signup_controller.dart';
import 'package:auth_car/Screens/signup_screen.dart';
import 'package:auth_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool? _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: kPrimColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.22,
                ),
                Text(
                  'Login',
                  style: GoogleFonts.montserrat(
                    color: kLightTextColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please sign in to continue.',
                  style: GoogleFonts.montserrat(
                    color: Colors.white38,
                    fontSize: 17.5,
                  ),
                ),
                const SizedBox(height: 20),
                //Form
                Center(
                  child: Form(
                    key: _loginFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //Email TextField
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'EMAIL',
                              hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: kGreyTextColor, fontSize: 13)),
                              prefixIcon: const Icon(
                                FontAwesomeIcons.envelope,
                                color: kGreyTextColor,
                              ),
                              focusColor: Colors.white54,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    color: kPrimColor, width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    color: kPrimColor, width: 0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    color: kPrimColor, width: 0),
                              ),
                            ),
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.montserrat(
                              color: kLightTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }

                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          //Password TextField
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'PASSWORD',
                              hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: kGreyTextColor, fontSize: 13)),
                              prefixIcon: const Icon(
                                FontAwesomeIcons.lock,
                                color: kGreyTextColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible!
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white54,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !(_passwordVisible!);
                                  });
                                },
                              ),
                              focusColor: Colors.white54,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    color: kPrimColor, width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    color: kPrimColor, width: 0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    color: kPrimColor, width: 0),
                              ),
                            ),
                            controller: controller.password,
                            obscureText: !_passwordVisible!,
                            keyboardType: TextInputType.text,
                            style: GoogleFonts.montserrat(
                              color: kLightTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: Colors.white,
                          ),
                          //Forgot Password
                          TextButton(
                            onPressed: () {
                              print('Forgot Password');
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.montserrat(
                                color: kAccColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          //LogIn Button
                          SizedBox(
                            width: screenWidth * 0.5,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_loginFormKey.currentState!.validate()) {
                                  SignUpController.instance.loginUser(
                                    controller.email.text.trim(),
                                    controller.password.text.trim(),
                                  );
                                }
                              },
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kAccColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'OR',
                            style: GoogleFonts.montserrat(
                              color: Colors.white38,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 15),
                          //Google LogIn
                          SizedBox(
                            width: screenWidth * 0.7,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                print('Google Login Pressed');
                              },
                              child: Center(
                                child: Text(
                                  'Continue with Google',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kAccColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                // Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.montserrat(
                        color: Colors.white38,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                          () => const SignUpScreen(),
                          transition: Transition.zoom,
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.montserrat(
                          color: kAccColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
