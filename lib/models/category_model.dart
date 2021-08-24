class CategoryModel{
  late bool status;
  late CategoryData catData;
  CategoryModel.fromJson(Map<String , dynamic> json){
    status=json['status'];
    catData=CategoryData.fromJson(json['data']);
  }
}

class CategoryData{
  late int currentPage;
  late List<Data> data =[];
  CategoryData.fromJson(Map<String , dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(Data.fronJsom(element));
    });
  }

}

class Data{
  late int id;
  late String name;
  late String image;
  Data.fronJsom(Map<String , dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}

