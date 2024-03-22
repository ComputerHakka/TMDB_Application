import 'package:cinema_app/resources/resources.dart';
import 'package:cinema_app/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie(
      {required this.id,
      required this.imageName,
      required this.title,
      required this.time,
      required this.description});
}

class MovieListWidget extends StatefulWidget {
  MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      imageName: AppImages.moviePlaceholder,
      title: 'Страх и ненависть в Лас-Вегасе',
      time: 'Май 9, 2013',
      description:
          'Рандомный большой текст для проверки правильности переноса текста в колонке и за ее пределами, так как Флаттер немного тупенький',
    ),
    Movie(
      id: 2,
      imageName: AppImages.moviePlaceholder,
      title: 'Snach',
      time: 'Июнь 20, 2013',
      description:
          'Рандомный большой текст для проверки правильности переноса текста в колонке и за ее пределами, так как Флаттер немного тупенький',
    ),
    Movie(
      id: 3,
      imageName: AppImages.moviePlaceholder,
      title: 'Криминальное чтиво',
      time: 'Сентябрь 3, 2013',
      description:
          'Рандомный большой текст для проверки правильности переноса текста в колонке и за ее пределами, так как Флаттер немного тупенький',
    ),
    Movie(
      id: 4,
      imageName: AppImages.moviePlaceholder,
      title: 'Форрест гамп',
      time: 'Август 9, 2013',
      description:
          'Рандомный большой текст для проверки правильности переноса текста в колонке и за ее пределами, так как Флаттер немного тупенький',
    ),
    Movie(
      id: 5,
      imageName: AppImages.moviePlaceholder,
      title: 'Trainspotting',
      time: 'Февраль 9, 2013',
      description:
          'Рандомный большой текст для проверки правильности переноса текста в колонке и за ее пределами, так как Флаттер немного тупенький',
    ),
    Movie(
      id: 6,
      imageName: AppImages.moviePlaceholder,
      title: 'Большой Лебовски',
      time: 'Май 10, 2013',
      description:
          'Рандомный большой текст для проверки правильности переноса текста в колонке и за ее пределами, так как Флаттер немного тупенький',
    ),
  ];

  var _fillteredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _fillteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _fillteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fillteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _fillteredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _fillteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image(image: AssetImage(movie.imageName)),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                movie.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                movie.time,
                                style: const TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: () => _onMovieTap(index),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
