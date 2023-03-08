class CategoryModel {
  bool? status;
  late CategoryDataModel data;

  CategoryModel.fromjson(Map<String, dynamic> myjson) {
    status = myjson['status'];
    data = CategoryDataModel.fromjson(myjson['data']);
  }
}

class CategoryDataModel {
  late int currentpage;
  late List<DataModel> data = [];

  CategoryDataModel.fromjson(Map<String, dynamic> myjson) {
    currentpage = myjson['current_page'];
    myjson['data'].forEach((element) {
      data.add(DataModel.fromjson(element));
    });
  }
}

class DataModel {
 int? id;
  String? name;
  String? image;
  DataModel.fromjson(Map<String, dynamic> myjson) {
    id = myjson['id'];
    name = myjson['name'];
    image = myjson['image'];
  }
}
