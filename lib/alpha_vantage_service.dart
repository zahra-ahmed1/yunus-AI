import 'dart:convert';
import 'package:http/http.dart' as http;

class AlphaVantageService {
  static const String baseUrl = "https://www.alphavantage.co/query";
  static const String apiKey = "RPG70NE8MY28JCHY"; // Replace with your actual API key

  Future<String> getStockQuote(String symbol) async {
    final response = await http.get(
      Uri.parse('$baseUrl?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final stockPrice = data['Global Quote']['05. price'];
      return 'The current price of $symbol is $stockPrice';
    } else {
      return 'Failed to fetch stock data';
    }
  }
}
