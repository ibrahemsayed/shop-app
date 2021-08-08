import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/cubit/states.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:udemy_shop_app/shared_components/shared.dart';

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
              widgetBuilder: (BuildContext context) => SingleChildScrollView(
                child: Center(
                        child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true, viewportFraction: 1),
                          items: cubit.homeData!.data.banners.map((e) {
                            return Image(
                              image: NetworkImage(
                                '${e.image}',
                              ),
                              fit: BoxFit.cover,
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          color: Colors.grey,
                          //height: 450.0,
                          child: GridView.count(
                            physics: ScrollPhysics(),
                            childAspectRatio: 1/1.6,
                            shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              children: List.generate(
                                cubit.homeData!.data.products.length,
                                (index) =>
                                    Container(
                                      color: Colors.white,
                                      child: productItem(cubit.homeData!.data.products[index])),
                              )),
                        ),
                      ],
                    )),
              ),
              fallbackBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
          
        });
  }
}
