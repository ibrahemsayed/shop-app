import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_shop_app/layout/home_screen.dart';
import 'package:udemy_shop_app/network/local/shared_preferences.dart';
import 'package:udemy_shop_app/shared_components/shared.dart';

import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isSecure = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status) {
            CacheHelper.setData(
                    key: 'token', value: state.loginModel.data.token)
                .then((value) => navigateAndReplecement(context, HomeScreen()));
          } else {
            print(state.loginModel.message);
          }
        }
      }, builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            label: 'Email Address',
                            icon: Icons.email,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'This field must not be empty';
                            }),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isPassword: cubit.isPassword,
                          validate: (value) {
                            if (value!.isEmpty) return 'Password is too short';
                          },
                          suffixPressed: cubit.changePasswordVisibility,
                          suffixIcon: cubit.suffixIcon,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        state is! LoginLoadingState
                            ? defaultButton(() {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }, 'Login', context)
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                                child: Text(
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
