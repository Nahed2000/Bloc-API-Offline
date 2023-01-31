import 'package:breaking_bad/constant/mycolor.dart';
import 'package:breaking_bad/cubit/character_cubit.dart';
import 'package:breaking_bad/cubit/character_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../model/character.dart';
import '../widget/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CharacterCubit>(context).getAllCharacter();
    super.initState();
  }

  List<Character> listSearch = [];
  bool isSearch = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.myGrey,
        appBar: AppBar(
          backgroundColor: MyColor.myYellow,
          iconTheme: const IconThemeData(color: MyColor.myGrey),
          title: isSearch ? searchWidget() : buildTitleText(),
          actions: appBarAction(),
        ),
        body: OfflineBuilder(connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BuildLoadingApp(isSearch: isSearch, listSearch: listSearch);
          } else {
            return buildNoInternet();
          }
        },
        child: const CircularProgressIndicator(color: MyColor.myYellow),
            ));
  }

  Text buildTitleText() {
    return const Text(
      'Character Screen',
      style: TextStyle(color: MyColor.myGrey),
    );
  }

  Widget searchWidget() {
    return TextField(
      controller: textEditingController,
      cursorColor: MyColor.myGrey,
      style: const TextStyle(color: MyColor.myGrey, fontSize: 18),
      onChanged: (value) => addToSearchList(char: textEditingController.text),
      decoration: const InputDecoration(
          hintStyle: TextStyle(color: MyColor.myGrey, fontSize: 18),
          hintText: 'Find a Character ... ',
          border: InputBorder.none),
    );
  }

  void addToSearchList({required String char}) {
    listSearch = BlocProvider.of<CharacterCubit>(context)
        .myList
        .where((character) => character.name.toLowerCase().startsWith(char))
        .toList();
    setState(() {});
  }

  List<Widget> appBarAction() {
    if (isSearch) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear, color: MyColor.myGrey)),
      ];
    } else {
      return [
        IconButton(
            onPressed: () => _searchedButton(),
            icon: const Icon(Icons.search, color: MyColor.myGrey)),
      ];
    }
  }

  void _searchedButton() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      isSearch = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      isSearch = false;
    });
  }

  void _clearSearch() {
    textEditingController.clear();
  }

  Widget buildNoInternet() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/undraw_Signal_searching_re_yl8n.png'),
          const Text('can\'t connect ..... check your WIFI ..!! '),
        ],
      ),
    );
  }
}

class BuildLoadingApp extends StatelessWidget {
  const BuildLoadingApp({
    Key? key,
    required this.isSearch,
    required this.listSearch,
  }) : super(key: key);

  final bool isSearch;
  final List<Character> listSearch;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        var cubit = BlocProvider.of<CharacterCubit>(context);
        if (state is CharacterIsLoading) {
          return const Center(
              child: CircularProgressIndicator(color: MyColor.myYellow));
        } else if (state is CharacterSuccessfully && cubit.myList.isNotEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return CharacterItem(
                character: isSearch ? listSearch[index] : cubit.myList[index],
              );
            },
            itemCount: isSearch ? listSearch.length : cubit.myList.length,
          );
        } else if (state is CharacterFailed) {
          print(state);
          return const Center(child: Text("don't have any data ...!"));
        } else {
          return const Center(child: Text("Something went wrong ... !!!!"));
        }
      },
    );
  }
}
