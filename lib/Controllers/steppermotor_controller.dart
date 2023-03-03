import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:auth_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class StepperMotorController extends GetxController {
  BluetoothConnection? connection;
  bool isConnected = false;

  void connectToDevice() async {
    connection =
        await BluetoothConnection.toAddress('00:22:06:01:A8:C9').then((value) {
      // print('Successfully Connected to device');
      Get.snackbar(
        'HC-05',
        'Successfully Connected!!',
        icon: const Icon(
          FontAwesomeIcons.check,
          color: kLightTextColor,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kAccColor,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: kLightTextColor,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
        shouldIconPulse: true,
      );
      // moveStepperMotor(true, 200);
      return null;
    });
    isConnected = true;
    update();
  }

  void disconnectFromDevice() async {
    await connection?.close();
    isConnected = false;
    update();
  }

  // Future<void> sendCommand(String command) async {
  //   if (isConnected && connection != null) {
  //     String toEncode = command + '\r\n';
  //     connection!.output.add(utf8.encode(toEncode) as Uint8List);
  //     await connection!.output.allSent;
  //   }
  // }
  //
  // void moveStepperMotor(bool move) async {
  //   if (isConnected) {
  //     String direction = move ? 'START' : 'STOP';
  //     await sendCommand(direction);
  //   }
  // }

  void startStepperMotor() async {
    if (isConnected && connection != null) {
      // connection!.output
      //     .add(utf8.encode('TURN_ON_MOTOR' + '\r\n') as Uint8List);
      FlutterBluetoothSerial.instance.write('1');
      // connection!.output.add(utf8.encode('1') as Uint8List);
      await connection!.output.allSent;
    }
  }

  void stopStepperMotor() async {
    if (isConnected && connection != null) {
      connection!.output.add(utf8.encode('0' + '\r\n') as Uint8List);
      await connection!.output.allSent;
    }
  }
}
