class FavoriteModel {
  late bool status;
  late FavoriteDataModel data;
  FavoriteModel.fromJson(Map<String ,dynamic> json){
    status=json['status'];
    data=FavoriteDataModel.fromJson(json['data']);
  }
}

class FavoriteDataModel {
  late List<FavoriteProductData> productData = [];
  FavoriteDataModel.fromJson(Map<String ,dynamic> json){
    json['data'].forEach((element){
      productData.add(FavoriteProductData.fromJson(element));
    });
  }
}
class FavoriteProductData {
  late int favoriteId;
  late Product productInfo;
  FavoriteProductData.fromJson(Map<String ,dynamic> json){
    favoriteId=json['id'];
    productInfo=Product.fromJson(json['product']);
  }
}

class Product {
  late int productId;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  Product.fromJson(Map<String ,dynamic> json){
    productId=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}