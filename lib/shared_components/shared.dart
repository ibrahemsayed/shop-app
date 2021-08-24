import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:udemy_shop_app/cubit/cubit.dart';
import 'package:udemy_shop_app/models/home_data_model.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

void navigateAndReplecement(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  bool isPassword = false,
  Function? function,
  String? Function(String?)? validate,
  IconData? suffixIcon,
  var suffixPressed,
}) {
  //final String?Function(String?)? validatorFun;
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)),
    ),
    obscureText: isPassword,
    validator: validate,
  );
}

Widget defaultButton(var function, String text, context) {
  return InkWell(
    onTap: function,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Center(
          child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )),
    ),
  );
}

Widget productItem(ProductModel model,BuildContext context) {
  return Card(
    
    child: Container(
      padding: const EdgeInsets.all(8.0),
      foregroundDecoration: model.discount != 0? const RotatedCornerDecoration(
        color: Colors.red,
        geometry: const BadgeGeometry(width: 48, height: 48,alignment: BadgeAlignment.topLeft),
        textSpan: const TextSpan(
          text: 'Discount',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ):null,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.imageUrl,
                ),
                height: 200.0,
                width: double.infinity,
              ),
              
            ],
          ),
          Column(
            children: [
              Text(
                '${model.name}',
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),
                    ),
                    Spacer(),
                    IconButton(
                    icon: CircleAvatar(child: Icon(Icons.favorite,color: Colors.white,),
                    backgroundColor: ShopCubit.get(context).favorites[model.id]!?Colors.red:Colors.grey,),
                    onPressed: (){ShopCubit.get(context).toggleFavorite(model.id);},
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}
