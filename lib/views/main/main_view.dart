
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soop_broad/common/app_bar/custom_app_bar.dart';
import 'package:soop_broad/views/home/home_view.dart';
import 'package:soop_broad/views/main/provider/main_provider.dart';

import '../../common/drawer/custom_drawer.dart';
import '../../utils/custom_theme_mode.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String className = 'MainView';
  static const String path = '/main';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // drawer key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final _pageController = context.read<MainProvider>();

  Widget _body() {
    return IndexedStack(
      index: _pageController.page,
      children: const [
        HomeView(),
        Text('search'),
        Center(
          child: Text('upload'),
        ),
        Center(
          child: Text('reels'),
        ),
        Center(
          child: Text('mypage'),
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainProvider(
        :page,
    ) = context.watch<MainProvider>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _pageController.willPopAction();
        // bool result = onWillPop();
        // if (result) {
        //   SystemNavigator.pop();
        // }
      },
      child: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: CustomThemeMode.current,
          builder: (context, value, child) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: CustomAppBar(
                title: 'MY',
                scaffoldKey: _scaffoldKey,
                // bottom: _appBarTab(),
              ),
              endDrawer: CustomDrawer(scaffoldKey: _scaffoldKey),
              body: _body(),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: page,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      // activeIcon: Icon(Icons.home),
                      label: 'home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sports),
                      // activeIcon: Icon(Icons.sports),
                      label: '스포츠'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.my_library_add),
                      // activeIcon: Icon(Icons.my_library_add),
                      label: 'MY'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      // activeIcon: Icon(Icons.add),
                      label: '더보기'),
                ],
                onTap: (value) {
                  _pageController.changeIndex(value);
                },
              ),
            );
          }
        ),
      ),
    );
  }
}

