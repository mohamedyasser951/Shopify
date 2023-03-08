import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/layout/states.dart';
import 'package:shop_app/modules/login_screen/cubit_login.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:shop_app/modules/register_screen/cubit_Register.dart';
import 'package:shop_app/shared/component/block_observer.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/sheredpref_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  DioHelper.init();

  await SharedHelper.init();
  Widget startWidget;
  bool? onBoarding = SharedHelper.getData(key: "onBoarding");
  TOKEN = SharedHelper.getData(key: "token");
  bool? MODE = SharedHelper.getData(key: "isDark");

  if (onBoarding != null) {
    if (TOKEN != null) {
      startWidget = HomeLayout();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(ShopApp(
        MODE: MODE,
        startWidget: startWidget,
      ));
      ;
    },
    blocObserver: MyBlocObserver(),
  );
}

class ShopApp extends StatelessWidget {
  bool? MODE;

  late final Widget startWidget;
  ShopApp({required this.startWidget,this.MODE});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) => CubitHomeLayout()
                ..changeMode(modeFromShared: MODE)
                ..getHomeData()
                ..getCategoryData()
                ..GetFvorites()
                ..GetProfile()
                ..changeMode(modeFromShared: MODE)
                )),
          BlocProvider(create: ((context) => CubitLogin())),
          BlocProvider(create: ((context) => CubitRegister())),
        ],
        child: BlocConsumer<CubitHomeLayout, HomeLayoutStates>(
            listener: ((context, state) {}),
            builder: (context, state) {
              return MaterialApp(
                darkTheme: darkTheme,
                theme: lightTheme,
                themeMode: CubitHomeLayout.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: startWidget,
              );
            }));
  }
}
