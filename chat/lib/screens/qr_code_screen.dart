import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class QRCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final connectionUrl = Provider.of<ConnectionProvider>(context).connectionUrl;

    return Scaffold(
      appBar: AppBar(title: Text('QR Code')),
      body: Center(
        child: QrImage(
          data: connectionUrl,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
