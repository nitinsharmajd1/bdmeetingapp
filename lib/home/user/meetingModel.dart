class AddMeetingModel {
  String? msg;
  String? message;
  int? status;

  AddMeetingModel({this.msg,this.message, this.status});

  AddMeetingModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class MeetinListModel {
  int? status;
  String? message;
  List<Datalist2>? datalist;

  MeetinListModel({this.status, this.message, this.datalist});

  MeetinListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['datalist'] != null) {
      datalist = <Datalist2>[];
      json['datalist'].forEach((v) {
        datalist!.add(new Datalist2.fromJson(v));
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

class Datalist2 {
  String? id;
  String? surgeonName;
  String? surgeonCatagory;
  String? categoryFlag;
  String? phoneNo;
  String? date;
  String? time;
  String? address;
  String? remark;
  String? status;
  String? isRevival;

  Datalist2(
      {this.id,
        this.surgeonName,
        this.surgeonCatagory,
        this.categoryFlag,
        this.phoneNo,
        this.date,
        this.time,
        this.address,
        this.remark,
        this.status,
        this.isRevival});

  Datalist2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surgeonName = json['surgeon_name'];
    surgeonCatagory = json['surgeon_catagory'];
    categoryFlag = json['categoryFlag'];
    phoneNo = json['phone_no'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    remark = json['remark'];
    status = json['status'];
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
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['isRevival'] = this.isRevival;
    return data;
  }
}

class CompletedMeetingModel {
  int? status;
  String? message;
  List<Datalist1>? datalist;

  CompletedMeetingModel({this.status, this.message, this.datalist});

  CompletedMeetingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['datalist'] != null) {
      datalist = <Datalist1>[];
      json['datalist'].forEach((v) {
        datalist!.add(new Datalist1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data1 = new Map<String, dynamic>();
    data1['status'] = this.status;
    data1['message'] = this.message;
    if (this.datalist != null) {
      data1['datalist'] = this.datalist!.map((v) => v.toJson()).toList();
    }
    return data1;
  }
}

class Datalist1 {
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
  String? revivalCount;

  Datalist1(
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
        this.revivalCount});

  Datalist1.fromJson(Map<String, dynamic> json) {
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
    revivalCount = json['revivalCount'];
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
    data['revivalCount'] = this.revivalCount;
    return data;
  }
}