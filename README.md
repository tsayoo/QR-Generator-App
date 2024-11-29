# QR Scanner & Generator App

This Flutter app allows users to scan QR codes and generate QR codes. The app has two main functionalities:

- **Scanner**: Uses the camera to scan QR codes.
- **Generator**: Generates QR codes based on the inputted text.

## Features

### Home Screen

The home screen has two buttons:
1. **Go to Scanner**: Navigates to the QR Scanner screen.
2. **Go to QR Generator**: Navigates to the QR Generator screen.

### QR Scanner Screen

This screen uses the camera to scan QR codes. When a QR code is detected, the app displays its content and gives an option to switch to the QR generator screen.

### QR Generator Screen

On this screen, the user can enter text, and the app will generate a corresponding QR code. The user can then save or share the QR code.

## Libraries Used

- **Flutter**: The framework used for app development.
- **MobileScanner**: To scan QR codes.
- **PrettyQR**: For generating QR codes.
- **Flutter Material Design**: To create the UI components.