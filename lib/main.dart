import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import './scanner.dart';

void main() {
  runApp(const QrcodeToy());
}

class QrcodeToy extends StatelessWidget {
  const QrcodeToy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QrcodeToy',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const QrcodeToyHomePage(title: 'Qrcode Toy'),
    );
  }
}

class QrcodeToyHomePage extends StatefulWidget {
  const QrcodeToyHomePage({super.key, required this.title});

  final String title;

  @override
  State<QrcodeToyHomePage> createState() => _QrcodeToyHomePageState();
}

class _QrcodeToyHomePageState extends State<QrcodeToyHomePage> {
  // String _content = '';
  String _committedContent = '';
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: _committedContent,
              version: QrVersions.auto,
              size: 320.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                _committedContent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: TextField(
                obscureText: false,
                maxLength: 100,
                maxLines: 3,
                showCursor: true,
                controller: textFieldController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Content for QR code',
                    hintText: "Some content here"),
                // onChanged: (value) {
                //   setState(() {
                //     _content = value;
                //   });
                // },
              ),
            ),
            ElevatedButton(
              child: const Text('Commit Text!'),
              onPressed: () {
                setState(() {
                  _committedContent = textFieldController.text;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScannerRoute()),
          );
          if (result != null) {
            setState(() {
              textFieldController.text = result as String;
            });
          }
        }),
        child: const Icon(Icons.find_in_page),
      ),
    );
  }
}
