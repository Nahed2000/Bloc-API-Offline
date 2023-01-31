import 'dart:convert';

import 'package:breaking_bad/api/api_settings.dart';
import 'package:breaking_bad/model/character.dart';
import 'package:http/http.dart' as http;

class ApiCharacterController {
  Future<List<Character>> getCharacter() async {
    Uri url = Uri.parse(ApiSettings.character);
    print('we are here');
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['results'] as List;
      List<Character> listCharacter = jsonArray
          .map((characters) => Character.fromJson(characters))
          .toList();
      return listCharacter;
    }
    return [];
  }
}
