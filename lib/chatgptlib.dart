import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchChatGPTResponse(String prompt) async {
  const apiKey = 'your_openai_api_key';
  final url = Uri.parse('https://api.openai.com/v1/completions');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'model': 'gpt-3.5-turbo',  // Or the model you're using
      'prompt': prompt,
      'max_tokens': 100,
      'temperature': 0.7,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['choices'][0]['text'].toString();
  } else {
    throw Exception('Failed to fetch response');
  }
}
