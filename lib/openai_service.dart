import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  static const apiUri = 'https://api.openai.com/v1/chat/completions';
  static const apiKey = 'sk-rIrpysiEhaJ4euf6uawf9U739V-yePc4x60WjBfVB4T3BlbkFJnrBFzxwyqrWe41GHZpeDT-Ko9JjEvWXPlpQwEnz0IA';

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      "role": "user",
      "content":
          "You are a banking bot called bankbot and you are supposed to only talk about banking.$prompt",
    });
    try {
      final res = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $apiKey',
          'OpenAI-Organization': ''
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": messages,
          "temperature": 0.7
        }),
      );

      //print(res.body);

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
         //specifically going into content 
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}