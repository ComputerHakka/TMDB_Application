import 'package:flutter/material.dart';

class MovieDetailsMainRecommendationsWidget extends StatelessWidget {
  const MovieDetailsMainRecommendationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Text(
              'Рекомендации',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const _RecommendedMovieWidget();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _RecommendedMovieWidget extends StatelessWidget {
  const _RecommendedMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          color: Colors.green,
          height: 170,
          width: 300,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Filth'),
            Text('63'),
          ],
        ),
      ],
    );
  }
}
