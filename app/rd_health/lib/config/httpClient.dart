import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:rd_health/config/config.dart';

class httpClient {
  String endpoint;
  String base_url = '$reqUrl/api/';
  String token;

  httpClient(this.endpoint, this.token);

  Future multipartPost(File file) {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$base_url$endpoint'),
      );
      Map<String, String> headers = {
        "Authorization":
        "Token $token"
      };
      request.files.add(
        http.MultipartFile(
          'image',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: basename(file.path),
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);
      print("request: " + request.toString());
      return request.send();
    } catch(e) {
      print("error");
      print(e);
    }
  }

  Future post(String data) {
    if(token != null) {
      return http.post('$base_url$endpoint',
          headers: {"Content-Type": "application/json",
            "Authorization": "Token "+token}, body: data);
    }
    return http.post('$base_url$endpoint',
        headers: {"Content-Type": "application/json"}, body: data);
  }

  Future patch(String data) {
    if(token != null) {
      return http.patch('$base_url$endpoint',
          headers: {"Content-Type": "application/json",
            "Authorization": "Token "+token}, body: data);
    }
    return http.patch('$base_url$endpoint',
        headers: {"Content-Type": "application/json"}, body: data);
  }

  Future delete() {
    if(token != null) {
      return http.delete('$base_url$endpoint',
          headers: {"Content-Type": "application/json",
            "Authorization": "Token "+token});
    }
    return http.delete('$base_url$endpoint',
        headers: {"Content-Type": "application/json"});
  }

  Future get() {
    if(token != null) {
      final headers = {"Content-Type": "application/json",
        "Authorization": "Token "+token};

      return http.get('$base_url$endpoint',
          headers: headers);
    }
    return http.get('$base_url$endpoint',
        headers: {"Content-Type": "application/json"});
  }
}