import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:udemy_shop_app/models/login_model.dart';
import 'package:udemy_shop_app/modules/login_module/login_cubit/login_states.dart';
import 'package:udemy_shop_app/network/remote/dio_helper_methods.dart';
import 'package:udemy_shop_app/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  late LoginData loginData;
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

  //************        user login function           *********//
  /*void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
            url: LOGIN,
            data: {'email': email, 'password': password},
            lang: 'ar')
        .then((value) {
      print(value.data);
      loginData = LoginData.fromJason(value.data);
      print(loginData.data.email);
      print(loginData.status);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }*/
   void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      //print(value.data);
      loginData = LoginData.fromJson(value.data);
      print(loginData.status);
      emit(LoginSuccessState(loginData));
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(PasswordVisibilityState());
  }
}
