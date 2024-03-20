import 'package:cinema_app/resources/resources.dart';
import 'package:cinema_app/ui/widgets/elements/radial_percent_widget.dart';
import 'package:flutter/material.dart';

TextStyle getTextStyle(
    {Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? Colors.white,
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.w400,
  );
}

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TopPosterWidget(),
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: _MovieNamewidget(),
        ),
        const _ScoreWidget(),
        const _Summerywidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _overviewWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _descriptionWidget(),
        ),
        const SizedBox(height: 30),
        const _PeopleWidget(),
        const SizedBox(height: 30),
      ],
    );
  }

  Text _descriptionWidget() {
    return Text(
      'Bla bla bla bla bla bla Bla bla bla bla bla bla Bla bla bla bla bla bla Bla bla bla bla bla bla Bla bla bla bla bla bla Bla bla bla bla bla bla',
      style: getTextStyle(),
    );
  }

  Text _overviewWidget() => Text('Overview', style: getTextStyle());
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: 0.72,
                  fillColor: Color.fromARGB(255, 10, 23, 25),
                  lineColor: Color.fromARGB(255, 37, 203, 103),
                  freeColor: Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 5,
                  child: Text('72'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('User Score'),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          width: 1,
          height: 15,
        ),
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              Icon(Icons.play_arrow_rounded),
              SizedBox(
                width: 5,
              ),
              Text('Play Trailer'),
            ],
          ),
        ),
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
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Fears',
              style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
          TextSpan(
            text: ' (2021)',
            style: getTextStyle(),
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
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 70.0),
        child: Text(
          'R, 04/29/2021 (USA) 1h49m Action, Adventure, Thriller, War',
          textAlign: TextAlign.center,
          style: getTextStyle(),
        ),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Debil', style: getTextStyle(fontWeight: FontWeight.w600)),
                Text('Director', style: getTextStyle()),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vsiliy',
                    style: getTextStyle(fontWeight: FontWeight.w600)),
                Text('SoundProd', style: getTextStyle()),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Debil', style: getTextStyle(fontWeight: FontWeight.w600)),
                Text('Director', style: getTextStyle()),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vsiliy',
                    style: getTextStyle(fontWeight: FontWeight.w600)),
                Text('SoundProd', style: getTextStyle()),
              ],
            )
          ],
        ),
      ],
    );
  }
}
