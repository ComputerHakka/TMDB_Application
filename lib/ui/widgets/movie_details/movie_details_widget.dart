import 'package:cinema_app/library/widgets/provider.dart';
import 'package:cinema_app/ui/widgets/app/my_app_model.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_additional_information_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_recommendations_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_screen_cast_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_main_social_media_widget.dart';
import 'package:cinema_app/ui/widgets/movie_details/movie_details_model.dart';
import 'package:flutter/material.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const [
        MovieDetailsMainInfoWidget(),
        MovieDetailsMainScreenCastWidget(),
        MovieDetailsMainSocialMediaWidget(),
        MovieDetailsMainRecommendationsWidget(),
        MovieDetailsMainAdditionalInformationWidget(),
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(model?.movieDetails?.title ?? 'Загрузка...');
  }
}
