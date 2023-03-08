class UserModel {
  late bool status;
  late String? messsage;
  late UserData?  data;

  UserModel.fromjson(Map<String, dynamic> myjson) {
    status = myjson['status'];
    messsage = myjson["message"];
    data = myjson['data'] != null ? UserData.fromjson(myjson['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  //Named constructor
  UserData.fromjson(Map<String, dynamic> myjson) {
    id = myjson['id'];
    name = myjson['name'];
    phone = myjson['phone'];
    email = myjson['email'];
    image = myjson['image'];
    points = myjson['points'];
    credit = myjson['credit'];
    token = myjson['token'];
  }
}
