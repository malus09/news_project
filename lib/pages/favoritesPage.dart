import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/bloc/cubit.dart';
import 'package:news_project/modal/newsModal.dart';
import 'package:news_project/widgets/newsCard.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late CubitFavoritos favoritosCubit;

  @override
  void initState() {
    super.initState();
    favoritosCubit = context.read<CubitFavoritos>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CubitFavoritos, List<News>>(
          builder: (context, snapshot) {
            final cubit = context.watch<CubitFavoritos>();
            if (cubit.state.isNotEmpty) {
              List<News> newsList = cubit.state;

              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, i) {
                  return NewsCard(news: newsList[i]);
                },
              );
            }
            return const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'Você ainda não possui favoritos!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
