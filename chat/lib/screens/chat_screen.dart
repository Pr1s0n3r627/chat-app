import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/encryption_helper.dart';

class ChatScreen extends StatefulWidget {
  final String url;

  ChatScreen({required this.url});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel channel;
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse(widget.url));
    channel.stream.listen((message) {
      final decryptedMessage = EncryptionHelper.decryptMessage(message);
      setState(() {
        messages.add(decryptedMessage);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      final encryptedMessage = EncryptionHelper.encryptMessage(controller.text);
      channel.sink.add(encryptedMessage);
      setState(() {
        messages.add(controller.text); // Display original message locally
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Send a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
