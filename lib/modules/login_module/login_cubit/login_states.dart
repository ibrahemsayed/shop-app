import 'package:udemy_shop_app/models/login_model.dart';

abstract class LoginStates{}

class InitialLoginState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginData loginModel;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);

}

//chang password visibility state
class PasswordVisibilityState extends LoginStates{}