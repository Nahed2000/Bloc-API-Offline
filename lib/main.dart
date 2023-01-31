import 'package:breaking_bad/cubit/character_cubit.dart';
import 'package:breaking_bad/screen/character_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen/character_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CharacterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/character_screen',
        routes: {
          '/character_screen': (context) => const CharacterScreen(),
        },
      ),
    );
  }
}
