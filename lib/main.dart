

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/bloc/cubit.dart';
import 'package:news_project/pages/newsPage.dart';


void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CubitFavoritos>(
          create: (BuildContext context) => CubitFavoritos(),
        ),
      ],
      child: MaterialApp(
        home: NewsPage(),
      ),
    ),
  );
}
