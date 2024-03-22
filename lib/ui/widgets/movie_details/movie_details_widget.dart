import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_additional_information_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_recommendations_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_screen_cast_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_social_media_widget.dart';
import 'package:flutter/material.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;
  const MovieDetailsWidget({super.key, required this.movieId});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fears'),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: const [
            MovieDetailsMainInfoWidget(),
            MovieDetailsMainScreenCastWidget(),
            MovieDetailsMainSocialMediaWidget(),
            MovieDetailsMainRecommendationsWidget(),
            MovieDetailsMainAdditionalInformationWidget(),
          ],
        ),
      ),
    );
  }
}
