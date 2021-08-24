import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udemy_shop_app/constants/constants.dart';
import 'package:udemy_shop_app/cubit/states.dart';
import 'package:udemy_shop_app/layout/home_screens/categories.dart';
import 'package:udemy_shop_app/layout/home_screens/favorites.dart';
import 'package:udemy_shop_app/layout/home_screens/home.dart';
import 'package:udemy_shop_app/layout/home_screens/settings.dart';
import 'package:udemy_shop_app/models/category_model.dart';
import 'package:udemy_shop_app/models/change_favorite_model.dart';
import 'package:udemy_shop_app/models/favorite_model.dart';
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
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.list_bullet), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_favorites_alt), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings')
  ];
  void changeBottomBarItem(int currentIndex) {
    print(token);
    index = currentIndex;
    emit(ChangeBottomNavigationState());
  }

  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(GetHomeDataLoadingState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeData = HomeData.fromJson(value.data);
      homeData!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(homeData!.data.banners[0].image);
      
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataErrorState());
    });
  }

  CategoryModel? categories;
  void getCategoriesData() {
    emit(GetCategoryDataLoadingState());

    DioHelper.getData(
      url: CATEGORIES,
      //token: token,
    ).then((value) {
      categories = CategoryModel.fromJson(value.data);
      print(categories!.catData.data[0].id.toString());
      emit(GetCategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDataErrorState());
    });
  }

//******************       favorites ********************/
  FavoriteModel? favoritesData;
  void getfavoritesData() {
    emit(GetFavoriteDataLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesData = FavoriteModel.fromJson(value.data);
      print(favoritesData!.data.productData[0].productInfo.image);
      emit(GetFavoriteDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteDataErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void toggleFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ToggleFavoriteLoadingState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else
        getfavoritesData();
      emit(ToggleFavoriteSuccessState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ToggleFavoriteErrorState());
    });
  }
}
