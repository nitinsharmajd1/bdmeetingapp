class RevivalModel {
  int? status;
  String? message;
  List<Datalist>? datalist;

  RevivalModel({this.status, this.message, this.datalist});

  RevivalModel.fromJson(Map<String, dynamic> json) {
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
  String? surgeonName;
  String? surgeonCatagory;
  String? categoryFlag;
  String? phoneNo;
  String? date;
  String? time;
  String? address;
  String? status;
  String? mou;
  String? remarks;
  String? location;
  String? isRevival;

  Datalist(
      {this.id,
        this.surgeonName,
        this.surgeonCatagory,
        this.categoryFlag,
        this.phoneNo,
        this.date,
        this.time,
        this.address,
        this.status,
        this.mou,
        this.remarks,
        this.location,
        this.isRevival});

  Datalist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surgeonName = json['surgeon_name'];
    surgeonCatagory = json['surgeon_catagory'];
    categoryFlag = json['categoryFlag'];
    phoneNo = json['phone_no'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    status = json['status'];
    mou = json['mou'];
    remarks = json['remarks'];
    location = json['location'];
    isRevival = json['isRevival'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['surgeon_name'] = this.surgeonName;
    data['surgeon_catagory'] = this.surgeonCatagory;
    data['categoryFlag'] = this.categoryFlag;
    data['phone_no'] = this.phoneNo;
    data['date'] = this.date;
    data['time'] = this.time;
    data['address'] = this.address;
    data['status'] = this.status;
    data['mou'] = this.mou;
    data['remarks'] = this.remarks;
    data['location'] = this.location;
    data['isRevival'] = this.isRevival;
    return data;
  }
}