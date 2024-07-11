import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:soop_broad/utils/custom_route_observer.dart';
import 'package:soop_broad/utils/custom_theme_data.dart';
import 'package:soop_broad/utils/custom_theme_mode.dart';
import 'package:soop_broad/utils/navigation_service.dart';
import 'package:soop_broad/views/main/main_view.dart';
import 'package:soop_broad/views/main/provider/main_provider.dart';
import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // MediaStorePlugin().initMediaStore();
  EasyLoading()
    ..userInteractions = false
    ..dismissOnTap = false
    ..loadingStyle = EasyLoadingStyle.dark;

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
            home: SplashView(
              loadingIndicator: const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(),
              ),
              // backgroundImageDecoration: const BackgroundImageDecoration(
              //   image: AssetImage('Assets/images/splash_background.png'),
              // ),
              // logo: SvgPicture.asset('Assets/images/splash_logo.svg'),
              done: Done(
                const MainView(),
                animationDuration: const Duration(milliseconds: 750),
                curve: Curves.ease,
              ),
              showStatusBar: true,
            ),
            debugShowCheckedModeBanner: false,
            // theme: esgConstTheme,
            darkTheme: CustomThemeData.dark,
            theme: CustomThemeData.light,
            themeMode: mode,
            routes: routes,
            navigatorKey: NavigationService.navigatorKey,
            //onGenerateRoute: generateRoute,
            navigatorObservers: [CustomRouteObserver()],
            //initialRoute: LoginView.path,
            builder: (context, child) {
              CustomRouteObserver().setContext(context);
              final loader = EasyLoading.init(
                // builder: AppVersionChecker.init(),
              );
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
