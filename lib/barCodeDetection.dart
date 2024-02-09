import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  final FocusNode focusNode = FocusNode();
  String barcodeValue = '';
  late Timer timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  void pressKey(RawKeyEvent inputKeys) {
    var data = inputKeys.logicalKey.keyLabel;
    if (inputKeys is RawKeyDownEvent && data != null) {
      barcodeValue += data;
      timer.cancel();
      timer = Timer(const Duration(milliseconds: 50), () {
        if (barcodeValue.length < 9) {
          print('No picking or location or product corresponding to barcode $barcodeValue ');
        } else {
          print('Scanned Barcode: $barcodeValue');
        }
        barcodeValue = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Barcode Scanning')),
      ),
      body: RawKeyboardListener(
        focusNode: focusNode,
        onKey: pressKey,
        autofocus: true,
        child: const Center(
          child: Text(
            'Scan barcode...',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
