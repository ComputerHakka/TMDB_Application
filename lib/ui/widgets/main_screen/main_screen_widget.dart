import 'package:cinema_app/domain/data_providers/session_data_provider.dart';
import 'package:cinema_app/library/widgets/provider.dart';
import 'package:cinema_app/ui/widgets/movie_list/movie_list_model.dart';
import 'package:cinema_app/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:cinema_app/ui/widgets/serial_list/serial_list_widget.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();
  // static final List<Widget> _widgetOptions = <Widget>[
  //   const Text('Новости'),
  //   MovieListWidget(),
  //   const Text('Сериалы'),
  //   const Text('Аккаунт'),
  // ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TMDb'),
          actions: [
            IconButton(
              onPressed: () => SessionDataProvider().setSessionId(null),
              icon: const Icon(Icons.search),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Новости',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter),
              label: 'Фильмы',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'Сериалы',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Аккаунт',
            ),
          ],
          onTap: (index) => onSelectTab(index),
        ),
        body: IndexedStack(
          index: _selectedTab,
          children: [
            const Text('Новости'),
            NotifierProvider(
              create: () => movieListModel,
              isManagingModel: false,
              child: const MovieListWidget(),
            ),
            const SerialListWidget(),
            const Text('Аккаунт'),
          ],
        ));
  }
}
