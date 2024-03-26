import 'package:cinema_app/domain/api_client/api_client.dart';
import 'package:cinema_app/domain/entity/movie_details_credits.dart';
import 'package:cinema_app/library/widgets/provider.dart';
import 'package:cinema_app/ui/widgets/elements/radial_percent_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_model.dart';
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
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _PeopleWidget(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Text _overviewWidget() => Text('Overview', style: getTextStyle());
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(
      model?.movieDetails?.overview ?? '',
      style: getTextStyle(),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final voteAverage = model?.movieDetails?.voteAverage ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: voteAverage / 10,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 5,
                  child: Text((voteAverage * 10).toStringAsFixed(0)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('User Score'),
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
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}

class _MovieNamewidget extends StatelessWidget {
  const _MovieNamewidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return Center(
      child: RichText(
        maxLines: null,
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: model?.movieDetails?.title ?? '',
                style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
            TextSpan(
              text: year,
              style: getTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Summerywidget extends StatelessWidget {
  const _Summerywidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];
    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }
    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      final name = '(${productionCountries.first.iso})';
      texts.add(name);
    }
    final runTime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
      texts.add(genresNames.join(', '));
    }

    // 'R, 04/29/2021 (USA) 1h49m Action, Adventure, Thriller, War',
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Text(
          texts.join(' '),
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
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChanks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChanks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }
    return Column(
      children: crewChanks
          .map(
            (chunk) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _PeopleWidgetRow(employees: chunk),
            ),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetRow extends StatelessWidget {
  final List<Employee> employees;
  const _PeopleWidgetRow({
    super.key,
    required this.employees,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: employees
          .map(
            (employee) => _PeopleWidgetRowItem(employee: employee),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetRowItem extends StatelessWidget {
  final Employee employee;
  const _PeopleWidgetRowItem({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.name, style: getTextStyle(fontWeight: FontWeight.w600)),
          Text(employee.job, style: getTextStyle()),
        ],
      ),
    );
  }
}
