import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/modal/newsModal.dart';


class CubitFavoritos extends Cubit<List<News>> {
  List<News> favoritos;

  CubitFavoritos()
      : favoritos = [],
        super([]);

  addFavorite(News news) {
    favoritos.add(news);
    print('Notícia Adicionada: ${news.title}');
    emit(List.from(
        favoritos)); // Emitir uma cópia da lista para garantir a imutabilidade
  }

  removeFavorite(News news) {
    favoritos.remove(news);
    print('Notícia Removida: ${news.title}');
    emit(List.from(favoritos));
    print(favoritos);
  }

  bool isFavorito(News news) {
    return favoritos.any((fav) => fav.title == news.title);
  }
}
