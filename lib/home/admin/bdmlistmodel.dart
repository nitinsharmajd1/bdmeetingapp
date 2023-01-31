class BDMListModel {
  int? status;
  String? message;
  List<Datalist>? datalist;

  BDMListModel({this.status, this.message, this.datalist});

  BDMListModel.fromJson(Map<String, dynamic> json) {
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
  String? password;
  String? status;

  Datalist({this.id, this.username, this.password, this.status});

  Datalist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}
