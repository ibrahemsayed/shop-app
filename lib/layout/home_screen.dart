import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udemy_shop_app/constants/constants.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/cubit/states.dart';
import 'package:udemy_shop_app/utiles/colors.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AVAST_COLOR,
              title: Text('Salla'),
              actions: [
                IconButton(
                  onPressed: () {
                    print(token);
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: cubit.homeScreens[cubit.index],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                fixedColor: AVAST_COLOR,
                unselectedItemColor: Colors.grey,
                currentIndex: cubit.index,
                onTap: (value) {
                  cubit.changeBottomBarItem(value);
                },
                items: cubit.items),
          );
        });
  }
}
