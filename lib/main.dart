import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/locator.dart';
import 'presentation/blocs/liked_cats/liked_cats_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  setupLocator();
  runApp(const CatTinderApp());
}

class CatTinderApp extends StatelessWidget {
  const CatTinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кототиндер',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: BlocProvider(
        create: (_) => LikedCatsBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
