import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frostify'),
        backgroundColor: Colors.blueGrey,
        
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row untuk menempatkan button secara horizontal
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Menempatkan tombol di tengah
                children: [
                  // Button untuk mengarah ke Scanner Page
                  SizedBox(
                    width: 150, // Lebar kotak
                    height: 150, // Tinggi kotak (sama dengan lebar untuk membuatnya kotak)
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/scanner'); // Ganti '/scanner' dengan route untuk Scanner Page
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Sudut membulat
                        ),
                        padding: const EdgeInsets.all(0), // Menghapus padding tambahan
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 40), // Ikon kamera untuk scanner
                          SizedBox(height: 8), // Jarak antara ikon dan teks
                          Text(
                            'Go to Scanner',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20), // Jarak antara tombol
                  // Button untuk mengarah ke QR Generator Page
                  SizedBox(
                    width: 150, // Lebar kotak
                    height: 150, // Tinggi kotak (sama dengan lebar untuk membuatnya kotak)
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/generator'); // Ganti '/generator' dengan route untuk Generator Page
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Sudut membulat
                        ),
                        padding: const EdgeInsets.all(0), // Menghapus padding tambahan
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code, size: 40), // Ikon QR code untuk generator
                          SizedBox(height: 8), // Jarak antara ikon dan teks
                          Text(
                            'Go to QR Generator',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

