import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/cubit/states.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:udemy_shop_app/models/category_model.dart';
import 'package:udemy_shop_app/shared_components/shared.dart';
import 'package:udemy_shop_app/utiles/colors.dart';

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
                  cubit.homeData != null && cubit.categories != null,
              widgetBuilder: (BuildContext context) => SingleChildScrollView(
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        //*****    Categories            ******/
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CATEGORIES',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold,color: AVAST_COLOR),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                
                                height: 150.0,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) => Container(
                                      
                                      decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.red,width: 2 ),
                                  color: Colors.white,
                                ),
                                        
                                        child: buildCategoryItem(
                                            cubit.categories!, i)),
                                    separatorBuilder: (context, i) => SizedBox(
                                          width: 10.0,
                                        ),
                                    itemCount:
                                        cubit.categories!.catData.data.length),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'New Products',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold,color: AVAST_COLOR),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        //**            Products            **/
                        Container(
                            //color: Colors.grey,
                            //height: 450.0,
                            child: GridView.count(
                              physics: ScrollPhysics(),
                              childAspectRatio: 1 / 1.6,
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              children: List.generate(
                                  cubit.homeData!.data.products.length,
                                  (index) => Container(
                                      child: productItem(
                                          cubit.homeData!.data.products[index],
                                          context))),
                            )),
                      ],
                    )),
                  ),
              fallbackBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget buildCategoryItem(CategoryModel model, int index) {
    return Column(
      children: [
        Image(
          image: NetworkImage(
            model.catData.data[index].image,
          ),
          height: 120.0,
          width: 115.0,
          //fit: BoxFit.cover,
        ),
        Container(
              width: 115.0,
              color: Colors.transparent,
              child: Text(
                model.catData.data[index].name,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
      ],
    );
  }
}
