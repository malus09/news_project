
import 'package:flutter/material.dart';
import 'package:news_project/modal/newsModal.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final News news;

  DetailsPage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Notícia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(news.urlToImage),
            SizedBox(height: 16),
            Text(
              'Título: ${news.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Autor: ${news.author}'),
            SizedBox(height: 8),
            Text('Descrição: ${news.description}'),
            SizedBox(height: 8),
            TextButton(
              onPressed: () async {
                if (await canLaunch(news.url)) {
                  await launch(news.url);
                } else {
                  print('Could not launch ${news.url}');
                }
              },
              child: Text('Abrir no Navegador'),
            ),
          ],
        ),
      ),
    );
  }
}
