import 'dart:convert';

import 'package:test_project/models/users.dart';
import 'package:http/http.dart' as http;

class UsersProvider {
  Future<UsersList> getUsersList() async {
    final response = await http.get(Uri.parse('https://api.github.com/users'));
    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print(jsonResponse);
      return UsersList.fromJson(jsonResponse);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }

  }

  Future<Users> getUserByLogin(String login) async{
    final response = await http.get(Uri.parse('https://api.github.com/users/$login'));
    final jsonResponse = json.decode(response.body);
    if(response.statusCode == 200){
      print(jsonResponse);
      return Users.fromJson(jsonResponse);
    }else{
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}