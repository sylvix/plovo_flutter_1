import 'dart:convert';

import 'package:http/http.dart' as http;

// request('http://fjdlkjfldfj');
// request('http://fjdlkjfldfj', method: 'POST', body: {'name': 'John'});
Future<dynamic> request(
  String url, {
  String method = 'GET',
  dynamic body,
}) async {
  final uri = Uri.parse(url);
  http.Response response;

  if (method == 'GET') {
    response = await http.get(uri);
  } else if (method == 'POST') {
    response = await http.post(uri, body: jsonEncode(body));
  } else {
    throw Exception('Method $method not supported');
  }

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Request Error. Url: $url, code: ${response.statusCode}');
  }
}
