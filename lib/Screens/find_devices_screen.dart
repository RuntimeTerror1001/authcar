import 'package:auth_car/Controllers/stepmotor_controller.dart';
import 'package:auth_car/Screens/connection_screen.dart';
import 'package:auth_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FindDevicesScreen extends StatelessWidget {
  FindDevicesScreen({Key? key}) : super(key: key);

  final StepMotorController _controller = Get.put(StepMotorController());

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
                StreamBuilder<List<ScanResult>>(
                  stream: FlutterBlue.instance.scanResults,
                  initialData: const [],
                  builder: (c, snapshot) {
                    print(snapshot.data);
                    return Column(
                      children: snapshot.data!
                          .map((result) => ListTile(
                                title: Text(
                                  result.device.name == ""
                                      ? "No Name "
                                      : result.device.name,
                                  style: GoogleFonts.poppins(
                                      color: kLightTextColor),
                                ),
                                subtitle: Text(
                                  result.device.id.toString(),
                                  style: GoogleFonts.poppins(
                                      color: kLightTextColor),
                                ),
                                onTap: () {
                                  // result.device.connect().then((value) {
                                  //   print(
                                  //       'Connected : ${result.device.name}:${result.device.state}');
                                  //   _controller
                                  //       .connectToCharacteristic(result.device);
                                  //   Get.off(
                                  //     () => ConnectionScreen(
                                  //       connected: true,
                                  //       device: result.device,
                                  //     ),
                                  //   );
                                  // });

                                  // result.device.disconnect();
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: const Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: const Duration(seconds: 10)));
          }
        },
      ),
    );
  }
}
