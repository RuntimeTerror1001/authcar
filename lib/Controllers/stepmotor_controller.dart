import 'package:get/get.dart';
import 'package:flutter_blue/flutter_blue.dart';

class StepMotorController extends GetxController {
  late BluetoothCharacteristic _characteristic;

  // Connect to the Bluetooth characteristic that controls the step motor
  void connectToCharacteristic(BluetoothDevice device) async {
    List<BluetoothService> services =
        (device.services) as List<BluetoothService>;
    print(services);
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.uuid.toString() ==
            '0000fff1-0000-1000-8000-00805f9b34fb') {
          _characteristic = characteristic;
        }
      });
    });
  }

  // Send commands to the Bluetooth characteristic to control the step motor
  void sendCommand(String command) async {
    if (_characteristic != null) {
      List<int> bytes = command.codeUnits;
      await _characteristic.write(bytes);
    }
  }
}
