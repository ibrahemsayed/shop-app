import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/cubit/states.dart';

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
            drawer: Drawer(),
            appBar: AppBar(
              title: Text('Salla'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: cubit.homeScreens[cubit.index],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.blue,
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
