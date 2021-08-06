import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/cubit/states.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) =>
                  state is! GetHomeDataLoadingState,
              widgetBuilder: (BuildContext context) => Center(
                      child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(autoPlay: true,viewportFraction: 0.8),
                        items: cubit.homeData!.data.banners.map((e) {
                          return Image(
                            image: NetworkImage('${e.image}',),
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      )
                    ],
                  )),
              fallbackBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
          /*CarouselSlider(options: CarouselOptions(
            autoPlay: true,initialPage: 0,
            height: 250.0,
          ),
          items: cubit.homeData!.data.banners.map((e) {
            return Image(
              image: NetworkImage('${e.image}'),
            );
          }).toList(),

          );*/
          /**/
        });
  }
}
