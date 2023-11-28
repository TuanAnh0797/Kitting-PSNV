//==================// GR MCS //=========================
class ClasOpenGR {
  String Material;
  String DaNo;
  String PONo;
  String POItem;
  String Qty;
  String ActQty;
  String POPending;
  String Status;
  String ID;

  ClasOpenGR({required this.Material,required this.DaNo,required this.PONo,required this.POItem, required this.Qty,required this.ActQty,required this.POPending,required this.Status,required this.ID});

  factory ClasOpenGR.fromJson(Map<String, dynamic> json) {
    return ClasOpenGR(
      Material: json['Material'],
      DaNo: json['DaNo'],
      PONo: json['PONo'],
      POItem: json['POItem'],
      Qty: json['Qty'],
      ActQty: json['ActQty'],
      POPending: json['POPending'],
      Status: json['Status'],
      ID: json['ID'],
    );
  }
}

class ClasListGRPending {
  String Material;
  String Qty;
  String ActQty;
  String PONo;
  String POItem;
  String DAItem;
  String Plant;
  String Vendercode;

  ClasListGRPending({required this.Material,required this.Qty,required this.ActQty,required this.PONo, required this.POItem,required this.DAItem,required this.Plant,required this.Vendercode});

  factory ClasListGRPending.fromJson(Map<String, dynamic> json) {
    return ClasListGRPending(
      Material: json['Material'],
      Qty: json['Qty'],
      ActQty: json['ActQty'],
      PONo: json['PONo'],
      POItem: json['POItem'],
      DAItem: json['DAItem'],
      Plant: json['Plant'],
      Vendercode: json['Vendercode'],
    );
  }
}

//==================// end GR MCS //===================

//==================// begin kitting MCS //=========================
class ClasLisTypeKitting {
  String Partcode;
  String Model;
  String Line;
  String Status;
  String Quantity;
  String Position;
  String PIC;
  String Issue_sloc;
  String Deliverydate;
  String Model_Quantity;
  String Category_JT;

  ClasLisTypeKitting({required this.Partcode,required this.Model,required this.Line,required this.Status, required this.Quantity,required this.Position,required this.PIC,required this.Issue_sloc,required this.Deliverydate,required this.Model_Quantity, required this.Category_JT});

  factory ClasLisTypeKitting.fromJson(Map<String, dynamic> json) {
    return ClasLisTypeKitting(
      Partcode: json['Partcode'],
      Model: json['Model'],
      Line: json['Line'],
      Status: json['Status'],
      Quantity: json['Quantity'],
      Position: json['Position'],
      PIC: json['PIC'],
      Issue_sloc: json['Issue_sloc'],
      Deliverydate: json['Deliverydate'],
      Model_Quantity: json['Model_Quantity'],
      Category_JT: json['Category_JT'],
    );
  }
}

//ntime
class ProcKittingNTime_PartCard_category {
  final String Partcode;
  final String Model;
  final String Line;
  final int Status;
  final double Quantity;
  final String Position;
  final String PIC;
  final String Issue_sloc;
  final String Deliverydate;
  final int Model_Quantity;
  final String Category_JT;

  ProcKittingNTime_PartCard_category({
    required this.Partcode,
    required this.Model,
    required this.Line,
    required this.Status,
    required this.Quantity,
    required this.Position,
    required this.PIC,
    required this.Issue_sloc,
    required this.Deliverydate,
    required this.Model_Quantity,
    required this.Category_JT,
  });

  factory ProcKittingNTime_PartCard_category.fromJson(
      Map<String, dynamic> json) {
    return ProcKittingNTime_PartCard_category(
      Partcode: json['Partcode'] ?? '',
      Model: json['Model'] ?? '',
      Line: json['Line'] ?? '',
      Status: json['Status'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Issue_sloc: json['Issue_sloc'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
    );
  }
}

//_XHGopModel
class ProcKitting_XHGopModel_PartdCard_NOTime_Category {
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final double quantity;
  final String Model_Quantity;
  final String Receipt_Location;
  final String Issue_sloc;
  final int Status;
  final String Plant;
  final String Position;
  final String PIC;
  final String Category_JT;

  ProcKitting_XHGopModel_PartdCard_NOTime_Category({
    required this.Line,
    required this.Model,
    required this.Deliverydate,
    required this.Partcode,
    required this.quantity,
    required this.Model_Quantity,
    required this.Receipt_Location,
    required this.Issue_sloc,
    required this.Status,
    required this.Plant,
    required this.Position,
    required this.PIC,
    required this.Category_JT,
  });

  factory ProcKitting_XHGopModel_PartdCard_NOTime_Category.fromJson(
      Map<String, dynamic> json) {
    return ProcKitting_XHGopModel_PartdCard_NOTime_Category(
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      quantity: json['quantity'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_sloc: json['Issue_sloc'] ?? '',
      Status: json['Status'] ?? '',
      Plant: json['Plant'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
    );
  }
}

//PrepareNTime
class ProcKittingPrepareNTime_PartCard_category {
  final String Partcode;
  final String Issue_Sloc;
  final double Quantity;
  final String Model;
  final String Line;
  final String Model_Quantity;
  final String Receipt_Location;
  final String Deliverydate;
  final String Plant;
  final int Status;
  final String Position;
  final String PIC;


  ProcKittingPrepareNTime_PartCard_category({
    required this.Partcode,
    required this.Issue_Sloc,
    required this.Quantity,
    required this.Model,
    required this.Line,
    required this.Model_Quantity,
    required this.Receipt_Location,
    required this.Deliverydate,
    required this.Plant,
    required this.Status,
    required this.Position,
    required this.PIC,

  });

  factory ProcKittingPrepareNTime_PartCard_category.fromJson(
      Map<String, dynamic> json) {
    return ProcKittingPrepareNTime_PartCard_category(
      Partcode: json['Partcode'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Model: json['Model'] ?? '',
      Line: json['Line'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Plant: json['Plant'] ?? '',
      Status: json['Status'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',

    );
  }
}

//Prepare1Time
class ProcKittingPrepare1Time_PartCard_NOTime_category {
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final double quantity;
  final String Model_Quantity;
  final String Receipt_Location;
  final String Issue_sloc;
  final int Status;
  final String Position;
  final String PIC;
  final String Plant;

  ProcKittingPrepare1Time_PartCard_NOTime_category({
    required this.Line,
    required this.Model,
    required this.Deliverydate,
    required this.Partcode,
    required this.quantity,
    required this.Model_Quantity,
    required this.Receipt_Location,
    required this.Issue_sloc,
    required this.Status,
    required this.Position,
    required this.PIC,
    required this.Plant,
  });

  factory ProcKittingPrepare1Time_PartCard_NOTime_category.fromJson(
      Map<String, dynamic> json) {
    return ProcKittingPrepare1Time_PartCard_NOTime_category(
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      quantity: json['quantity'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_sloc: json['Issue_sloc'] ?? '',
      Status: json['Status'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Plant: json['Plant'] ?? '',
    );
  }
}

class ClassViewKitting {
  String Partcode;
  String Pos;
  String Sloc;
  String Qty;
  String Model;
  String Line;
  String Deliverydate;
  String Plant;
  String PIC;
  String PIC_ID;
  String Receipt_Location;
  String Unit;
  String Status;
  String ActualQuantity;
  String Category_JT;
  String Time;
  String SortTime;

  String Model_Quantity;
  String Reservation_No;
  String Recipient;
  String ActQty;
  String Time1;
  String Position;
  String Material_special;
  String Category;
  String Position_FA;
  String First_Time;


  ClassViewKitting({required this.Partcode,required this.Pos,required this.Sloc,required this.Qty,
    required this.Model,required this.Line,required this.Deliverydate,required this.Plant,required this.PIC,
    required this.PIC_ID, required this.Receipt_Location, required this.Unit, required this.Status,
    required this.ActualQuantity, required this.Category_JT, required this.Time, required this.SortTime,
    required this.Model_Quantity, required this.Reservation_No, required this.Recipient, required this.ActQty,
    required this.Time1, required this.Position, required this.Material_special, required this.Category, required this.Position_FA, required this.First_Time });

  factory ClassViewKitting.fromJson(Map<String, dynamic> json) {
    return ClassViewKitting(
      Partcode: json['Partcode'] ?? '',
      Pos: json['Pos'] ?? '',
      Sloc: json['Sloc'] ?? '',
      Qty: json['Qty'] ?? '',
      Model: json['Model'] ?? '',
      Line: json['Line'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Plant: json['Plant'] ?? '',
      PIC: json['PIC'] ?? '',
      PIC_ID: json['PIC_ID'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Unit: json['Unit'] ?? '',
      Status: json['Status'] ?? '',
      ActualQuantity:json['ActualQuantity'] ?? '',
      Category_JT:json['Category_JT'] ?? '',
      Time:json['Time'] ?? '',
      SortTime:json['SortTime'] ?? '',


      Model_Quantity:json['Model_Quantity'] ?? '',
      Reservation_No:json['Reservation_No'] ?? '',
      Recipient:json['Recipient'] ?? '',
      ActQty:json['ActQty'] ?? '',
      Time1:json['Time1'] ?? '',
      Position:json['Position'] ?? '',
      Material_special:json['Material_special'] ?? '',
      Category:json['Category'] ?? '',
      Position_FA:json['Position_FA'] ?? '',
      First_Time:json['First_Time'] ?? '',
    );
  }
}
//==================// end kitting MCS //===================


class User {
  String username;
  String password;
  User({required this.username, required this.password});
  /*User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }*/

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }*/
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }
}

class UserFoss2 {
  String userid;
  String fullname;
  String password;
  String userrightid;
  String sectionid;
  String position;

  UserFoss2(this.userid, this.fullname, this.password, this.userrightid, this.sectionid, this.position);

/*factory UserFoss.fromJson(Map<String, dynamic> json) {
    return UserFoss(
      userid: json['UserID'],
      fullname: json['FullName'],
      password: json['UserRightID'],
      userrightid: json['SectionID'],
      sectionid: json['SectionID'],
      position: json['Position'],

    );
  }*/
}

class UserFoss {
  String userid;
  String fullname;
  String password;
  String status;
  /*String userrightid;
  String sectionid;
  String position;*/

  UserFoss({required this.userid,required this.fullname,required this.password, required this.status});
  //UserFoss({required this.userid,required this.fullname,required this.password,required this.userrightid,required this.sectionid,required this.position});

  factory UserFoss.fromJson(Map<String, dynamic> json) {
    return UserFoss(
      userid: json['userid'],
      fullname: json['fullname'],
      password: json['password'],
      status: json['status'],
      /*   userrightid: json['SectionID'],
      sectionid: json['SectionID'],
      position: json['Position'],*/

    );
  }
}

class Dadetail {
  String dATotalID;
  String quantityDetail;
  String quantityBox;

  Dadetail({required this.dATotalID,required this.quantityDetail,required this.quantityBox});

  factory Dadetail.fromJson(Map<String, dynamic> json) {
    return Dadetail(
      dATotalID: json['DATotalID'],
      quantityDetail: json['QuantityDetail'],
      quantityBox: json['QuantityBox'],
    );
  }
}


