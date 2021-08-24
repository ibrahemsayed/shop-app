import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  //const FavoritesScreen({Key? key}) : super(key: key);

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
                      child: Container(
                          height: 690.0,
                          child: ListView.separated(
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Container(
                                        height: 150.0,
                                        width: 150.0,
                                        child: ClipRRect(
                                          child: Image(
                                            image: NetworkImage(
                                              cubit
                                                  .favoritesData!
                                                  .data
                                                  .productData[index]
                                                  .productInfo
                                                  .image,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160.0,
                                            child: Text(
                                              '${cubit.favoritesData!.data.productData[index].productInfo.name}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${cubit.favoritesData!.data.productData[index].productInfo.price.round()}',
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              if (cubit
                                                      .favoritesData!
                                                      .data
                                                      .productData[index]
                                                      .productInfo
                                                      .discount !=
                                                  0)
                                                Text(
                                                  '${cubit.favoritesData!.data.productData[index].productInfo.oldPrice.round()}',
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey),
                                                ),
                                              
                                              IconButton(
                                                icon: CircleAvatar(
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                  ),
                                                  backgroundColor: ShopCubit
                                                              .get(context)
                                                          .favorites[
                                                            cubit
                                                      .favoritesData!
                                                      .data
                                                      .productData[index]
                                                      .productInfo.productId
                                                          ]!
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                                onPressed: () {
                                                  ShopCubit.get(context)
                                                      .toggleFavorite(
                                                        cubit
                                                      .favoritesData!
                                                      .data
                                                      .productData[index]
                                                      .productInfo.productId
                                                      );
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                              separatorBuilder: (context, index) => Divider(
                                    height: 1,
                                  ),
                              itemCount: cubit
                                  .favoritesData!.data.productData.length)))),
              fallbackBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
}
