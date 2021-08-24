import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_shop_app/layout/home_screen.dart';
import 'package:udemy_shop_app/modules/login_module/login_screen.dart';

import 'constants/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'modules/onboarding_screen.dart';
import 'network/remote/dio_helper_methods.dart';
import 'network/local/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool? onBoarding = CacheHelper.getSharedData(key: 'onBoarding') !=null?CacheHelper.getSharedData(key: 'onBoarding'):false;
  token = CacheHelper.getSharedData(key: 'token')!=null?CacheHelper.getSharedData(key: 'token'):'';
  Widget widget;
  if (onBoarding == true) {
    if (token.isNotEmpty) {
      widget = HomeScreen();
      print(token);
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnboardingScreen();
  }
  runApp(MyApp(onBoarding!, widget));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  final bool onBoarding;
  const MyApp(this.onBoarding, this.startScreen);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //..getHomeData()
      create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getfavoritesData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Jannah'),
            home: startScreen,
          );
        },
      ),
    );
  }
}
