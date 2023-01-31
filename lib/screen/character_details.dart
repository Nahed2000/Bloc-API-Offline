import 'package:breaking_bad/constant/mycolor.dart';
import 'package:flutter/material.dart';

import '../model/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          title: 'Status : ', value: character.status),
                      characterDivider(),
                      characterInfo(
                          title: 'Species : ', value: character.species),
                      characterDivider(),
                      character.type.isEmpty
                          ? Container()
                          : characterInfo(
                              title: 'type : ', value: character.status),
                      character.type.isEmpty ? Container() : const Divider(),
                      characterInfo(
                          title: 'Gender  : ', value: character.gender),
                      characterDivider(),
                      characterInfo(
                          title: 'Location : ',
                          value:
                              '${character.location.name} / ${character.location.url}'),
                      characterDivider(),
                      character.type.isEmpty
                          ? Container()
                          : characterInfo(
                              title: 'Url : ', value: character.url),
                      character.type.isEmpty ? Container() : characterDivider(),
                      characterInfo(
                          title: 'Created : ', value: character.created),
                      characterDivider(),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.56),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget characterDivider() {
    return Divider(
      color: MyColor.myYellow,
      thickness: 2,
      endIndent: 200,
      height: 30,
    );
  }

  Widget characterInfo({required String title, required String value}) {
    return RichText(
      // textAlign: TextAlign.,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,

      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColor.myWhite,
              )),
          TextSpan(
              text: value,
              style: const TextStyle(fontSize: 16, color: MyColor.myWhite)),
        ],
      ),
    );
  }

  Widget buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.85,
      backgroundColor: MyColor.myGrey,
      stretch: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(color: MyColor.myWhite),
          // textAlign: TextAlign.start,
        ),

        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
