// class HomeModel {
//   bool? status;
//   HomeDataModel? data;
//   HomeModel.fromjson(Map<String, dynamic> myjson) {
//     status = myjson['status'];
//     data = HomeDataModel.fromjson(myjson['data']);
//   }
// }

// class HomeDataModel {
//   List<BannerModel> banners = [];
//   List<ProductsModel> products = [];

//   HomeDataModel.fromjson(Map<String, dynamic> myjson) {
//     myjson['banners'].foreach((element) {
//       banners.add(element);
//     });

//     myjson['products'].foreach((element) {
//       products.add(element);
//     });
//   }
// }

// class BannerModel {
//   int? id;
//   String? image;

//   BannerModel.fromjson(Map<String, dynamic> myjson) {
//     id = myjson['id'];
//     image = myjson['image'];
//   }
// }

// class ProductsModel {

//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   dynamic discount;
//   String? image;
//   bool? inFavorite;
//   bool? inCart;
//   ProductsModel.fromjson(Map<String, dynamic> myjson) {
//     id = myjson['id'];
//     price = myjson['price'];
//     oldPrice = myjson['old_price'];
//     image = myjson['image'];
//     inFavorite = myjson['in_favorites'];
//     inCart = myjson['in_cart'];
//   }
// }

class HomeModel {
  late bool status;
   HomeDataModel? data;

  HomeModel.fromjson(Map<String, dynamic> myjson) {
    status = myjson['status'];
    data = HomeDataModel.fromjson(myjson['data']);
  }
}

class HomeDataModel {
  List<BannersData> banners = [];
  List<ProductData> products = [];

  HomeDataModel.fromjson(Map<String, dynamic> myjson) {
    myjson['banners'].forEach((element) {
      banners.add(BannersData.fromjson(element));
    });
    myjson['products'].forEach((element) {
      products.add(ProductData.fromjson(element));
    });
  }
}

class BannersData {
   int? id;
  String? image;

  BannersData.fromjson(Map<String, dynamic> myjson) {
    id = myjson['id'];
    image = myjson['image'];
  }
}

class ProductData {
  //here
  late int id;
  dynamic price;
  dynamic name;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  dynamic inFavorites;
  dynamic inCart;

  ProductData.fromjson(Map<String, dynamic> myjson) {
    id = myjson['id'];
    price = myjson['price'];
    discount = myjson['discount'];
    oldPrice = myjson['old_price'];
    name = myjson['name'];
    image = myjson['image'];
    inFavorites = myjson['in_favorites'];
    inCart = myjson['in_cart'];
  }
}
