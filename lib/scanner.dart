import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerRoute extends StatelessWidget {
  const ScannerRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Code'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MobileScanner(
                allowDuplicates: false,
                onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    debugPrint('Failed to scan Barcode');
                    Navigator.pop(context, "Failed to scan Barcode");
                  } else {
                    final String code = barcode.rawValue!;
                    debugPrint('Barcode found! $code');
                    Navigator.pop(context, code);
                  }
                }),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ],
        ),
      ),
    );
  }
}
