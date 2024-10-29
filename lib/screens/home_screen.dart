import 'package:flutter/material.dart';
import 'package:master_focus_todo/screens/configs/configs_screen.dart';
import 'package:master_focus_todo/screens/focus_list_screen.dart';
import 'package:master_focus_todo/screens/statistics/statistics_screen.dart';

const strings = {
  'label_focus_list': 'Tarefas',
  'label_charts': 'Estatisticas',
  'label_configs': 'Configurações',
};

const _screens = [
  FocusListScreen(),
  StatisticsScreen(),
  ConfigsScreen(),
];

const icons = [
  Icons.list_alt,
  Icons.bar_chart,
  Icons.settings,
];

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(icons[0]),
            label: strings['label_focus_list'],
          ),
          BottomNavigationBarItem(
            icon: Icon(icons[1]),
            label: strings['label_charts'],
          ),
          BottomNavigationBarItem(
            icon: Icon(icons[2]),
            label: strings['label_configs'],
          ),
        ],
      ),
    );
  }
}
