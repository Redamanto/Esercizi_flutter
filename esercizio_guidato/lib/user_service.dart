import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class UserService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/users";

  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception("Errore caricamento risorsa");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
