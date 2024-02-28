import 'package:cinema_app/widgets/movie_list/movie_list_widget.dart';
import 'package:cinema_app/widgets/serial_list/serial_list_widget.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TMDb'),
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
            MovieListWidget(),
            const SerialListWidget(),
            const Text('Аккаунт'),
          ],
        ));
  }
}
