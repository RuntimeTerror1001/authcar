import 'package:auth_car/Controllers/signup_controller.dart';
import 'package:auth_car/Controllers/steppermotor_controller.dart';
import 'package:auth_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({Key? key, this.device}) : super(key: key);

  final BluetoothDevice? device;

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  late bool connected;
  Color _color = Colors.red.withOpacity(0.5);
  final StepperMotorController _controller = Get.put(StepperMotorController());

  @override
  void initState() {
    connected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimColor,
      appBar: AppBar(
        backgroundColor: kAccColor,
        centerTitle: true,
        title: Text(
          'AuthCar',
          style: GoogleFonts.montserrat(
            color: kLightTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.solidUser,
            color: kLightTextColor,
            size: 18,
          ),
          onPressed: () {
            SignUpController.instance.logoutUser();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bluetoothB),
            onPressed: () {
              if (connected == false) {
                _controller.connectToDevice();
                setState(() {
                  connected = true;
                  _color = Colors.lightGreenAccent.withOpacity(0.5);
                });
              } else {
                _controller.disconnectFromDevice();
                setState(() {
                  connected = false;
                  _color = Colors.red.withOpacity(0.5);
                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SingleChildScrollView(
            child: GetBuilder<StepperMotorController>(builder: (context) {
              return Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: screenHeight / 6,
                        left: screenWidth / 7.75,
                        child: AnimatedContainer(
                          height: screenWidth / 1.5,
                          width: screenWidth / 1.5,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: _color,
                                spreadRadius: 10,
                                blurRadius: 25,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            border: Border.all(
                              color: _color,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(150),
                          ),
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                      Image.asset('assets/car.png'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  connected == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('Rotate Clockwise'),
                              onPressed: () {
                                _controller.startStepperMotor();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('STOP'),
                              onPressed: () {
                                _controller.stopStepperMotor();
                              },
                            ),
                          ],
                        )
                      : Container()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
