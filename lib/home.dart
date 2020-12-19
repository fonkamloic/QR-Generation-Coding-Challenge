import 'package:auto_route/auto_route.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'routes/router.gr.dart' ;

class QRHome extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final scanedSeed = useState('');
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR challenge Home'),
      ),
      body: Center(
        child: Text(scanedSeed.value),
      ),
      floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.add_event,
          animatedIconTheme: const IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          // visible: _dialVisible,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: const CircleBorder(),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.code),
              backgroundColor: Colors.red,
              label: 'QR code',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () => ExtendedNavigator.of(context).pushQRCodeScreen(),
            ),
            SpeedDialChild(
              child: const Icon(Icons.camera),
              backgroundColor: Colors.blue,
              label: 'Scan',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () => scan(context, scanedSeed),
            ),
          ]),
    );
  }
}

Future scan(BuildContext context, ValueNotifier<String> seed) async {
  try {
    final ScanResult barcode =
        await BarcodeScanner.scan(options: const ScanOptions());

    seed.value = barcode.rawContent;
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      FlushbarHelper.createError(
              message: 'The user did not grant the camera permission!')
          .show(context);
      // barcodeState.value = 'The user did not grant the camera permission!';
    } else {
      FlushbarHelper.createError(message: 'Unknown error: $e').show(context);
    }
  } on FormatException {} catch (e) {
    // FlushbarHelper.createError(message: 'Unknown error: $e'.i18n).show(context);
  }
}
