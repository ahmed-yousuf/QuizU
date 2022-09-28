import 'dart:developer';
import 'package:http/http.dart' as http;

abstract class ClientHelper {
  // GET
  static Future<http.Response?> getData(String url, String token) async {
    final uri = Uri.parse(url);
    final respnse = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    try {
      if (respnse.statusCode == 200) {
        return respnse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // POST
  static Future<http.Response?> postData(
      String url, Map<String, dynamic> data, String token) async {
    final uri = Uri.parse(
      url,
    );
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: data);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //PATCH (Update single field in a column)
  static Future<http.Response?> patchData(String url, dynamic field) async {
    final uri = Uri.parse(url);
    final response = await http.patch(uri, body: field);
    try {
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // DELETE
  static Future<http.Response?> deleteData(
      String url, Map<String, dynamic> data) async {
    final uri = Uri.parse(url);
    final response = await http.delete(uri, body: data);
    try {
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

abstract class ClientHelperCategory {
  static Future<http.Response?> getAllCategory(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
