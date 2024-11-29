// import 'package:flutter/material.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';

// class QrGeneratorScreen extends StatefulWidget {
//   const QrGeneratorScreen({super.key});

//   @override
//   State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
// }

// class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
//   String? qrRawValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Generate QR Code!'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.qr_code_scanner) ,
//             onPressed: () {
//               Navigator.popAndPushNamed(context, '/');
//             },
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly, // memberikan space anatar widget sebelum dan sesudah
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextField(
//               onSubmitted: (value) {
//                 setState(() {
//                   qrRawValue = value;
//                 });
//               },
//             ),
//             if(qrRawValue != null) PrettyQrView.data(data: qrRawValue!)
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  String? qrRawValue;
  final ScreenshotController screenshotController = ScreenshotController();

   // Fungsi share QR Code
  Future<void> _shareQrCode() async {
    if (qrRawValue != null) {
      // Pastikan widget masih mounted sebelum melakukan aksi share
      if (mounted) {
        try {
          await Share.share('Check out my QR Code: $qrRawValue');
        } catch (e) {
          // Handle jika terjadi error saat share
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error sharing QR code')),
            );
          }
        }
      }
    }
  }

  Future<void> _downloadQrCode() async {
    if (qrRawValue != null) {
      final Uint8List? image = await screenshotController.capture();

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final file = await File('${directory.path}/qr_code.png').create();
        await file.writeAsBytes(image);

        // Pastikan widget masih 'mounted' sebelum memanggil UI update (SnackBar)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('QR Code saved to: ${file.path}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code!'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.pushNamed(context, '/scanner'); 
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter data to generate QR",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() {
                  qrRawValue = value;
                });
              },
            ),
            if (qrRawValue != null)
              Screenshot(
                controller: screenshotController,
                child: PrettyQrView.data(
                  data: qrRawValue!, // Data QR code
                ),
              ),
            if (qrRawValue != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _shareQrCode,
                    child: const Text("Share QR"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _downloadQrCode,
                    child: const Text("Download QR"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';

// class QrGeneratorScreen extends StatefulWidget {
//   const QrGeneratorScreen({super.key});

//   @override
//   State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
// }

// class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
//   String? qrRawValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Generator'),
//         backgroundColor: Colors.blueGrey,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.camera_alt),
//             onPressed: () {
//               Navigator.pushNamed(context, '/scanner'); // Pindah ke Scanner
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Enter Data for QR',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: (value) {
//                 setState(() {
//                   qrRawValue = value;
//                 });
//               },
//             ),
//                const SizedBox(height: 20),
//             if (qrRawValue != null)
//               PrettyQrView.data(
//                 data: qrRawValue!,
//                 // elementColor: Colors.black, // Warna QR Code
//                 // backgroundColor: Colors.white, // Latar belakang QR Code
//                 errorCorrectLevel: QrErrorCorrectLevel.M, // Tingkat koreksi
//               )
//             else
//               const Text(
//                 "Your QR code will appear here!",
//                 style: TextStyle(color: Colors.grey),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
