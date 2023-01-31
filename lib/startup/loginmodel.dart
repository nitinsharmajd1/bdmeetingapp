class LoginModel {
  int? status;
  String? message;
  List<Datalist>? datalist;

  LoginModel({this.status, this.message, this.datalist});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['datalist'] != null) {
      datalist = <Datalist>[];
      json['datalist'].forEach((v) {
        datalist!.add(new Datalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datalist != null) {
      data['datalist'] = this.datalist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  String? id;
  String? username;
  String? phone;
  String? status;
  Null? deletionmsg;

  Datalist({this.id, this.username, this.phone, this.status, this.deletionmsg});

  Datalist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    status = json['status'];
    deletionmsg = json['deletionmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['deletionmsg'] = this.deletionmsg;
    return data;
  }
}
