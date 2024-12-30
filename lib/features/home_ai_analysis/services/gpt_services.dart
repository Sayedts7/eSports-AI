import 'dart:convert';
import 'package:http/http.dart' as http;

class GptServices{
  final String apiKey = "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";

Future<String> sendMsg(String query) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": query},
          ],
          "max_tokens": 600,
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(response.body);
        print('12345678');
        print(json["choices"][0]["message"]["content"].toString());
        print('123456     78');
        print('123    45678');

        return json["choices"][0]["message"]["content"].toString();
      } else {
        throw Exception("API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("An error occurred while sending the message: $e");
    }
  }

}