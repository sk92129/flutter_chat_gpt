import 'package:flutter/material.dart';
import 'package:flutterchatgpt/chatgptlib.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Demo',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  String _response = '';

  Future<void> _sendMessage() async {
    final prompt = _controller.text;
    if (prompt.isEmpty) return;
    
    final response = await fetchChatGPTResponse(prompt);
    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Ask ChatGPT'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send'),
            ),
            const SizedBox(height: 20),
            if (_response.isNotEmpty)
              Text(
                'Response: $_response',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
