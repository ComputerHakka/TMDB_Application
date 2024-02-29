import 'package:flutter/material.dart';

class MovieDetailsMainSocialMediaWidget extends StatelessWidget {
  const MovieDetailsMainSocialMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          _SocialReviewsWidget(),
          SizedBox(height: 10),
          Divider(),
          _MediaWidget(),
          SizedBox(height: 10),
          Divider(),
        ],
      ),
    );
  }
}

class _SocialReviewsWidget extends StatelessWidget {
  const _SocialReviewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Социальные сети',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: Text('Рецензии 0')),
                    TextButton(onPressed: () {}, child: Text('Обсуждения 0')),
                  ],
                ),
              ),
            ],
          ),
          const Text('У нас нет обзоров на данный фильм'),
        ],
      ),
    );
  }
}

class _MediaWidget extends StatelessWidget {
  const _MediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Медиа',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text('Самое популярное')),
                    TextButton(
                        onPressed: () {}, child: const Text('Задники 0')),
                    TextButton(
                        onPressed: () {}, child: const Text('Видеоролики 0')),
                    TextButton(
                        onPressed: () {}, child: const Text('Постеры 0')),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  color: Colors.blue,
                  width: 200,
                  height: 150,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
