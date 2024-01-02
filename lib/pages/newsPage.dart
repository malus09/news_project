import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/bloc/cubit.dart';
import 'package:news_project/db/news_api.dart';
import 'package:news_project/modal/newsModal.dart';
import 'package:news_project/pages/detailsPage.dart';
import 'package:news_project/pages/favoritesPage.dart';
import 'package:news_project/widgets/newsCard.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late CubitFavoritos favoritosCubit;

  List<News> newsData = [];
  bool loading = true;
  String searchQuery = "";
  List<News> filteredNews = [];
  String newsUrl = "";

  @override
  void initState() {
    super.initState();
    favoritosCubit = context.read<CubitFavoritos>();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      loading = true;
    });

    try {
      List<News> fetchedNews = await NewsApi().findNewsByName();

      setState(() {
        newsData = fetchedNews;
        filteredNews = List.from(newsData);
        loading = false;
      });
    } catch (e) {
      print('Error fetching news: $e');
      setState(() {
        loading = false;
      });
    }
  }

  void onChangeSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredNews = newsData.where((item) {
        return (item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.description.toLowerCase().contains(query.toLowerCase()) ||
            item.author.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Search'),
                    onChanged: onChangeSearch,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Navegue para a página de favoritos
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritesPage()),
                    );
                  },
                ),
              ],
            ),
            Expanded(
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: filteredNews.length,
                        itemBuilder: (context, index) {
                          final item = filteredNews[index];
                          return NewsCard(news: item);
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
