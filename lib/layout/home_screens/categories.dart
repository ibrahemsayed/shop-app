import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/cubit/states.dart';
import 'package:udemy_shop_app/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  //const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Center(
                      child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                        color: Colors.white,
                        child: categoryItem(cubit.categories!, index)),
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                    ),
                    itemCount: cubit.categories!.catData.data.length,
                  ));
              
        });
  }

  Widget categoryItem(CategoryModel model, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        children: [
          Image(
            height: 130.0,
            width: 130,
            image: NetworkImage(model.catData.data[index].image),
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20.0),
          Text(model.catData.data[index].name),
          Spacer(),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
