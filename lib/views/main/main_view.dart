
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:soop_broad/common/app_bar/custom_app_bar.dart';
import 'package:soop_broad/views/home/home_view.dart';
import 'package:soop_broad/views/main/provider/main_provider.dart';
import 'package:soop_broad/views/more/more_view.dart';
import 'package:soop_broad/views/sports/sports_view.dart';

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
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> handleBackPress() async {
    final scaffoldState = _scaffoldKey.currentState;

    if (scaffoldState?.isEndDrawerOpen ?? false) {
      scaffoldState?.closeEndDrawer();
      return false;
    }

    final mainProvider = context.read<MainProvider>();

    if (await mainProvider.willPopAction()) {
      final now = DateTime.now();

      if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: '모든 정보를 입력해주세요.', backgroundColor: const Color.fromRGBO(100, 100, 100, 0.9), gravity: ToastGravity.BOTTOM);
        //CustomToastWidget.showToast(text: '앱을 종료하려면 한번 더 누르세요', bottom: 80);

        return false;
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final MainProvider(
      :page,
      :appBarTitle,
      :pageController
    ) = context.watch<MainProvider>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (await handleBackPress()) {
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
              ),
              endDrawer: CustomDrawer(scaffoldKey: _scaffoldKey),
              body: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => context.read<MainProvider>().changeIndex(index),
                children: const [
                  HomeView(),
                  SportsView(),
                  Center(
                    child: Text('MY'),
                  ),
                  MoreView()
                ],
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: BottomNavigationBar(
                  currentIndex: page,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
                    BottomNavigationBarItem(icon: Icon(Icons.sports), label: '스포츠'),
                    BottomNavigationBarItem(icon: Icon(Icons.my_library_add), label: 'MY'),
                    BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: '더보기'),
                  ],
                  onTap: (value) {
                    pageController.jumpToPage(value);
                    context.read<MainProvider>().changeIndex(value);
                  },
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}