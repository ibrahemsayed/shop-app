class HomeData{
  late bool status;
  //late String message;
  late DataModel data;
  HomeData.fromJson(Map<String ,dynamic> json){
    status=json['status'];
    //message=json['message'];
    data=DataModel.fromJson(json['data']);
  }
}

class DataModel{
  late List<BannerModel> banners =[];
  late List<ProductModel> products = [];
  DataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(element);
    });
    json['products'].forEach((element){
      products.add(element);
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    image=json['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String imageUrl;
  late String name;
  late bool inFavorites;
  late bool inCart;
  ProductModel.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    imageUrl=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}