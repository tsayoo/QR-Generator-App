// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class QrScannerScreen extends StatefulWidget {
//   const QrScannerScreen({super.key});

//   @override
//   State<QrScannerScreen> createState() => _QrScannerScreenState();
// }

// class _QrScannerScreenState extends State<QrScannerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Scan QR Code!"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.popAndPushNamed(context, "/generator");
//             },
//             icon: const Icon(Icons.qr_code),
//           )
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Widget pemindai QR code
//           MobileScanner(
//             controller: MobileScannerController(
//               detectionSpeed: DetectionSpeed.noDuplicates,
//               returnImage: true,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               final Uint8List? image = capture.image;
//               for (final barcode in barcodes) {
//                 print(
//                     'Barcode is valid, here is the source: ${barcode.rawValue}');
//               }
//               if (image != null) {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text(
//                         barcodes.first.rawValue ??
//                             "No reference Found from this QR",
//                       ),
//                       content: Image(
//                         image: MemoryImage(image),
//                       ),
//                     );
//                   },
//                 );
//               }
//             },
//           ),

//           // Desain scanner (lubang kotak transparan)
//           Center(
//             child: ClipPath(
//               clipper: ScannerClipper(),
//               child: Container(
//                 color: Colors.transparent,
//                 child: Stack(
//                   children: [
//                     // Efek border pada kotak scanner
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Teks instruksi di atas scanner
//           const Positioned(
//             bottom: 50,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Text(
//                 'Arahkan QR Code ke dalam kotak ini',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom clipper untuk "lubang kotak"
// class ScannerClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double holeSize = 250; // Ukuran kotak scanner
//     Path path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

//     // Membuat lubang kotak di tengah
//     path.addRect(Rect.fromCenter(
//       center: Offset(size.width / 2, size.height / 2),
//       width: holeSize,
//       height: holeSize,
//     ));

//     return path..fillType = PathFillType.evenOdd;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code!"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/generator"); // Navigasi ke Generator
            },
            icon: const Icon(Icons.qr_code),
          )
        ],
      ),
      body: Stack(
        children: [
          // Widget pemindai QR code
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              returnImage: true,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                print('Barcode found: ${barcode.rawValue}');
              }
              if (image != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        barcodes.isNotEmpty
                            ? barcodes.first.rawValue ?? "No QR Code"
                            : "No QR Code found",
                      ),
                      content: Image.memory(image),
                    );
                  },
                );
              }
            },
          ),

          // Desain scanner (kotak transparan)
          Center(
            child: ClipPath(
              clipper: ScannerClipper(),
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    // Border kotak
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Teks instruksi di bawah kotak
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Arahkan QR Code ke dalam kotak ini',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper untuk membuat "lubang" kotak
class ScannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double holeSize = 250; // Ukuran kotak scanner
    Path path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Membuat lubang kotak di tengah layar
    path.addRect(Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: holeSize,
      height: holeSize,
    ));

    return path..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
