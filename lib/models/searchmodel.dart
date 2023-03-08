class SearchModel {
  late bool status;
  late SearchData data;
  SearchModel.fromjson(Map<String, dynamic> myjson) {
    status = myjson['status'];
    data = SearchData.fromjson(myjson["data"]);
  }
}

class SearchData {
  late int currentPage;
  late List<ProductData> data = [];
  SearchData.fromjson(Map<String, dynamic> myjson) {
    currentPage = myjson["current_page"];
    if (myjson['data'] != null) {
      myjson['data'].forEach((v) {
        data.add(ProductData.fromjson(v));
      });
    }
  }
}

class ProductData {
   int? id;
  dynamic price;
  dynamic image;
  dynamic name;
  String? description;
  bool? inFavorites;
  bool? inCarts;
  ProductData.fromjson(Map<String, dynamic> myjson) {
    id = myjson['id'];
    name = myjson['name'];
    price = myjson['price'];
    image = myjson['image'];
    description = myjson["description"];
    inCarts = myjson["in_cart"];
    inFavorites = myjson["in_favorites"];
  }
}
