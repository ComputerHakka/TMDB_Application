import 'package:flutter/material.dart';

class MovieDetailsMainAdditionalInformationWidget extends StatelessWidget {
  const MovieDetailsMainAdditionalInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            _InfoBlock(title: 'Исходное название', value: 'Fears'),
            _InfoBlock(title: 'Статус', value: 'Fears'),
            _InfoBlock(title: 'Исходный язык', value: 'английский'),
            _InfoBlock(title: 'Бюджет', value: '-'),
            _InfoBlock(title: 'Сборы', value: '-'),
            _KeyWordsWidget(),
          ],
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String title;
  final String value;
  const _InfoBlock({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 60,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _KeyWordsWidget extends StatelessWidget {
  const _KeyWordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ключевые слова',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
                RawChip(label: Text('thriller')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
