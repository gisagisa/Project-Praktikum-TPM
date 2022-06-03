import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static final String baseUrl = "https://629358da089f87a57abe92dd.mockapi.io";
  static Future<List<dynamic>> get(partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;
    //debugPrint("\n\n\n\nBaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(Uri.parse(fullUrl));
    //debugPrint("\n\n\n\nBaseNetwork - response : ${response}");
    return _processResponse(response);
  }
  static Future<List<dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      debugPrint("\n\n\n\nTEST : ${jsonBody}");
      return jsonBody;
    } else {
      print("processResponse error");
      return [{"error": true}];
    }
  }
  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}