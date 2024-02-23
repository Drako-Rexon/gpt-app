import 'package:flutter/material.dart';
import 'package:gemini_app/models/chat_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiProProvider extends ChangeNotifier {
  final List<ChatModel> _messages = [];

  List<ChatModel> get messages => _messages;

  deleteChat() {
    _messages.clear();
  }

  Future<void> sentMessage(
      BuildContext context, String prompt, DateTime time) async {
    final apiKey = dotenv.env['API_KEY'] ?? "";
    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final content = [Content.text(prompt)];

      final response = await model.generateContent(content);

      _messages.add(ChatModel(
          text: response.text ?? "no response",
          time: DateTime.now(),
          isUser: false));

      notifyListeners();
    } catch (err) {
      AlertDialog(
        title: Text(err.toString()),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'))
        ],
      );
    }
  }
}
