import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/bloc/cubit.dart';
import 'package:news_project/modal/newsModal.dart';
import 'package:news_project/pages/detailsPage.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatefulWidget {
  final News news;

  const NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late CubitFavoritos favoritosCubit;

  @override
  void initState() {
    super.initState();
    favoritosCubit = context.read<CubitFavoritos>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a página de detalhes
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(news: widget.news),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 200,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0x74000000),
                  spreadRadius: 1,
                  blurRadius: 3,
                )
              ]),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(4)),
                    child: Image.network(
                      widget.news.urlToImage,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.news.title,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Icon(
                        Icons.price_check,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.news.description,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Author: ${widget.news.author}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      buildFavoriteButton(),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildFavoriteButton() {
    return IconButton(
      onPressed: () {
        bool isFavorito = favoritosCubit.isFavorito(widget.news);

        if (isFavorito) {
          favoritosCubit.removeFavorite(widget.news);
        } else {
          favoritosCubit.addFavorite(widget.news);
        }
      },
      icon: BlocBuilder<CubitFavoritos, List<News>>(
        builder: (context, state) {
          bool isFavorito = favoritosCubit.isFavorito(widget.news);
          return Icon(
            isFavorito ? Icons.favorite : Icons.favorite_border_rounded,
            size: 36,
            color: isFavorito ? Colors.pink : Colors.grey,
          );
        },
      ),
    );
  }
}
