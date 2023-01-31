import 'package:breaking_bad/api/controller/api_character_controller.dart';
import 'package:breaking_bad/model/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {

  ApiCharacterController apiCharacter = ApiCharacterController();
  List<Character> myList = [];
  CharacterCubit() : super(CharacterIsLoading());
  void getAllCharacter() async {
    myList = await apiCharacter.getCharacter();
    myList.isNotEmpty ? emit(CharacterSuccessfully()) : emit(CharacterFailed());
  }
}
