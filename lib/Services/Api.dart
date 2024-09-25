import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String _baseUrl;

  Api(this._baseUrl);

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post('$_baseUrl$endpoint' as Uri, headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode(data));
    return jsonDecode(response.body);
  }
}