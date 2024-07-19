
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soop_broad/common/app_bar/custom_app_bar.dart';
import 'package:soop_broad/views/home/home_view.dart';
import 'package:soop_broad/views/main/provider/main_provider.dart';
import 'package:soop_broad/views/more/more_view.dart';

import '../../common/drawer/custom_drawer.dart';
import '../../common/widget/custom_toast_widget.dart';
import '../../utils/custom_theme_mode.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String className = 'MainView';
  static const String path = '/main';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final _pageController = context.read<MainProvider>();

  Widget _body() {
    return IndexedStack(
      index: _pageController.page,
      children: const [
        HomeView(),
        Center(
          child: Text('스포츠'),
        ),
        Center(
          child: Text('MY'),
        ),
        MoreView()
      ],
    );
  }

  // 앱 종료시 뒤로가기 두번 누르기 이벤트
  DateTime? currentBackPressTime;

  Future<bool> handleBackPress() async {
    final scaffoldState = _scaffoldKey.currentState;

    if (scaffoldState?.isEndDrawerOpen ?? false) {
      scaffoldState?.closeEndDrawer();
      return false;
    }

    if (await _pageController.willPopAction()) {
      final now = DateTime.now();

      if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        CustomToastWidget.showToast('앱을 종료하려면 한번 더 누르세요', 80, false, null);
        return false;
      }
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainProvider(
      :page,
      :appBarTitle
    ) = context.watch<MainProvider>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Future<bool> result = handleBackPress();
        if (await result) {
          SystemNavigator.pop();
        }
      },
      child: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: CustomThemeMode.current,
          builder: (context, value, child) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: CustomAppBar(
                title: appBarTitle,
                scaffoldKey: _scaffoldKey,
                // bottom: _appBarTab(),
              ),
              endDrawer: CustomDrawer(scaffoldKey: _scaffoldKey),
              body: _body(),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: BottomNavigationBar(
                  currentIndex: page,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      // activeIcon: Icon(Icons.home),
                      label: '홈'),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.sports),
                      // activeIcon: Icon(Icons.sports),
                      label: '스포츠'),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.my_library_add),
                      // activeIcon: Icon(Icons.my_library_add),
                      label: 'MY'),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.more_horiz),
                      // activeIcon: Icon(Icons.add),
                      label: '더보기'),
                  ],
                  onTap: (value) => _pageController.changeIndex(value),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

