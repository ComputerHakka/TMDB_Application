import 'package:cinema_app/resources/resources.dart';
import 'package:flutter/material.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TopPosterWidget(),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: _MovieNamewidget(),
        ),
        _Summerywidget(),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Image(image: AssetImage(AppImages.topHeader)),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(
            image: AssetImage(AppImages.moviePlaceholder),
          ),
        )
      ],
    );
  }
}

class _MovieNamewidget extends StatelessWidget {
  const _MovieNamewidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: null,
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Fears',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          TextSpan(
            text: ' (2021)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _Summerywidget extends StatelessWidget {
  const _Summerywidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 70.0),
        child: Text(
          'R, 04/29/2021 (USA) 1h49m Action, Adventure, Thriller, War',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
