import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:soop_broad/common/loading/custom_loading.dart';
import 'package:soop_broad/utils/custom_route_observer.dart';
import 'package:soop_broad/utils/custom_theme_data.dart';
import 'package:soop_broad/utils/custom_theme_mode.dart';
import 'package:soop_broad/utils/navigation_service.dart';
import 'package:soop_broad/views/main/main_view.dart';
import 'package:soop_broad/views/main/provider/main_provider.dart';

import 'common/widget/custom_toast_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    //스크린 세로모드 고정
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);

  CustomThemeMode.instance;
  runApp(const SoopMobileApp());
}


final routes = {
  MainView.path: (context) => const MainView(), // 메인화면
};

class SoopMobileApp extends StatelessWidget {
  const SoopMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: CustomThemeMode.themeMode,
        builder: (context, mode, child) {
          return MaterialApp(
            title: 'Soop_broad',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ko'),
            ],
            home: Builder(builder: (context) {
              CustomRouteObserver().setContext(context);
              CustomLoadingContext().setContext(context);
              CustomToastContext().setContext(context);
              return const MainView();
            }),
            debugShowCheckedModeBanner: false,
            darkTheme: CustomThemeData.dark,
            theme: CustomThemeData.light,
            themeMode: mode,
            routes: routes,
            navigatorKey: NavigationService.navigatorKey,
            navigatorObservers: [CustomRouteObserver()],
            //initialRoute: LoginView.path,
            builder: (context, child) {
              final loader = EasyLoading.init();
              return MediaQuery(
                data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
                child: loader(context, child),
              );
            },
          );
        }
      ),
    );
  }
}
