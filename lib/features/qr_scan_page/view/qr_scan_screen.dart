import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ozimiz_project/features/login_phone_or_sign/view/sign_up_or_login.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 697.h,
        decoration: BoxDecoration(
            color: Color(0xFFF0F3FB),
            borderRadius: BorderRadius.circular(32.r)),
        child: Column(children: [
          SizedBox(
            height: 194.h,
          ),
          SizedBox(
            width: 200.w,
            height: 200.h,
            child: Center(child: MobileScanner(
              onDetect: (barcodes) {
                print(barcodes.raw);
              },
            )
                // QRView(
                //   key: qrKey,
                //   onQRViewCreated: _onQRViewCreated,
                //   overlay: QrScannerOverlayShape(
                //       borderColor: Colors.red,
                //       borderRadius: 10.r,
                //       borderLength: 30.h,
                //       borderWidth: 10.w,
                //       cutOutSize: MediaQuery.of(context).size.width * 0.8,
                //       overlayColor: Colors.black),
                // ),
                ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
              width: 222.w,
              child: Text(
                'Отсканируйте QR код для регистрация',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w600),
              ))
        ]),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller
          .pauseCamera(); // Остановите камеру, как только QR будет сканирован
      print(scanData.code);
      if (scanData.code == 'Test') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpOrLogin()));
      }
      // Навигация на другой экран с данными QR
    });
  }
}
