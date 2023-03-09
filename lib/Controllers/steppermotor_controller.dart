import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:auth_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class StepperMotorController extends GetxController {
  BluetoothConnection? connection;

  void connectToDevice() async {
    // DC:1A:C5:2C:30:70
    try {
      connection = await BluetoothConnection.toAddress('00:22:06:01:A8:C9');
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
      update();
    } catch (exception) {
      print(exception);
    }
  }

  void disconnectFromDevice() async {
    await connection?.close();
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

  void startStepperMotor(String command) {
    print("start motor $command");
    print("connection start motor ${connection.toString()}");
    if (connection != null) {
      connection!.output.add(utf8.encode('1' + '\r\n') as Uint8List);
      // FlutterBluetoothSerial.instance.write(command);
      // connection!.output.add(utf8.encode('1') as Uint8List);
      connection!.output.allSent;
      print('after starting ${connection?.output}');
    }
  }

  void stopStepperMotor(String command) {
    if (connection != null) {
      connection!.output.add(utf8.encode('0') as Uint8List);
      connection!.output.allSent;
      print('after stopping ${connection?.output}');
    }
  }
}
