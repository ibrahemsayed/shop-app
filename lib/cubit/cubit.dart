import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udemy_shop_app/constants/constants.dart';
import 'package:udemy_shop_app/cubit/states.dart';
import 'package:udemy_shop_app/layout/home_screens/categories.dart';
import 'package:udemy_shop_app/layout/home_screens/favorites.dart';
import 'package:udemy_shop_app/layout/home_screens/home.dart';
import 'package:udemy_shop_app/layout/home_screens/settings.dart';
import 'package:udemy_shop_app/models/home_data_model.dart';
import 'package:udemy_shop_app/network/end_points.dart';
import 'package:udemy_shop_app/network/remote/dio_helper_methods.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int index = 0;
  HomeData? homeData;
  List<Widget> homeScreens = [
    Home(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(MdiIcons.homeMinus), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(MdiIcons.shoppingMusic), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(MdiIcons.homeMinus), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(MdiIcons.homeMinus), label: 'Settings')
  ];
  void changeBottomBarItem(int currentIndex) {
    index = currentIndex;
    emit(ChangeBottomNavigationState());
  }

  void getHomeData() {
    emit(GetHomeDataLoadingState());


    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeData = HomeData.fromJson(value.data);
      print(homeData!.data.banners[0].image);
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString);
      emit(GetHomeDataErrorState());
    });
  }
}
