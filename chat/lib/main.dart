import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/qr_code_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectionProvider(),
      child: MaterialApp(
        title: 'Minimal Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Enter connection URL'),
            ),
            ElevatedButton(
              child: Text('Generate QR Code'),
              onPressed: () {
                Provider.of<ConnectionProvider>(context, listen: false)
                    .setConnectionUrl(controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCodeScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Connect to Chat'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(url: controller.text),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ConnectionProvider extends ChangeNotifier {
  String _connectionUrl = '';

  String get connectionUrl => _connectionUrl;

  void setConnectionUrl(String url) {
    _connectionUrl = url;
    notifyListeners();
  }
}
