import 'dart:convert';
import 'package:flutterchatgpt/constants.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchChatGPTResponse(String prompt) async {
  const apiKey = APIKEY;
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'model': 'gpt-3.5-turbo',  // Or the model you're using
       'messages': [
        {'role': 'user', 'content': prompt}
      ],
      'max_tokens': 100,
      'temperature': 0.7,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    return data;
  } else {
    throw Exception('Failed to fetch response ${response.statusCode} ${response.body}');
  }
}
