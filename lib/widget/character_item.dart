import 'package:breaking_bad/model/character.dart';
import 'package:breaking_bad/screen/character_details.dart';
import 'package:flutter/material.dart';

import '../constant/mycolor.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailsScreen(character: character),
          )),
      child: Hero(
        tag: character.id,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          padding: const EdgeInsetsDirectional.all(4),
          decoration: BoxDecoration(
            color: MyColor.myWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridTile(
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  color: MyColor.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            child: Container(
              color: MyColor.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      height: double.infinity,
                      placeholder:
                          'assets/images/9619-loading-dots-in-yellow.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
        ),
      ),
    );
  }
}
