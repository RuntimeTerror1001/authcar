import 'package:auth_car/Screens/connection_screen.dart';
import 'package:auth_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Your Documents',
                    style: GoogleFonts.poppins(
                      color: kAccColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Center(
          child: Icon(
            FontAwesomeIcons.car,
            color: kLightTextColor,
          ),
        ),
        onPressed: () {
          Get.to(() => ConnectionScreen(), transition: Transition.zoom);
        },
      ),
    );
  }
}
