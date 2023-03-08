class ChanegFavoritesModel {
  bool? status;
  String? message;
  ChanegFavoritesModel.fromjson(Map<String, dynamic> myjson) {
    status = myjson["status"];
    message = myjson["message"];
  }
}
