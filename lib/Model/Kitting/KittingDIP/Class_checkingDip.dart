class Get_KittingTran_Partcard_DIP {
  String Partcode;
  int Status;
  double Quantity;
  String Model;
  String Line;
  String Time;
  String Issue_Sloc;
  String DeliveryDate;
  String BarcodeCarton;
  String BarcodePartcard;
  int StatusDelay;
  String SttCheck;
//?? ''

  Get_KittingTran_Partcard_DIP({required this.Partcode,required this.Status,required this.Quantity,
    required this.Model, required this.Line,required this.Time,required this.Issue_Sloc,required this.DeliveryDate,required this.BarcodeCarton,required this.BarcodePartcard,required this.StatusDelay, required this.SttCheck});

  factory Get_KittingTran_Partcard_DIP.fromJson(Map<String, dynamic> json) {
    return Get_KittingTran_Partcard_DIP(
      Partcode: json['Partcode'] ?? '' ,
      Status: json['Status'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Model: json['Model'] ?? '',
      Line: json['Line'] ?? '',
      Time: json['Time'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      DeliveryDate: json['DeliveryDate'] ?? '',
      BarcodeCarton: json['BarcodeCarton'] ?? '',
      BarcodePartcard: json['BarcodePartcard'] ?? '',
      StatusDelay: json['StatusDelay'] ?? '',
      SttCheck: json['SttCheck'] ?? '',
    );
  }
}

class Report_Partcard_DIP_new {
  String Plant;
  String Material;
  double Material_quantity;
  String SLoc;
  String SlocDIP;
  String Model;
  double Quantity1;
  double Quantity;
  String Line;
  String Time;
  String ProductDate;
  String Note;
  String PL;
  String Position;
  String PIC;
  String PIC_Name;
  String Description;
  String Position2;
  String Category;
  String Category_JT;
//?? ''

  Report_Partcard_DIP_new({required this.Plant,required this.Material,required this.Material_quantity,
    required this.SLoc, required this.SlocDIP,required this.Model,required this.Quantity1,
    required this.Quantity,required this.Line,required this.Time,required this.ProductDate,
    required this.Note,required this.PL,required this.Position,required this.PIC,
    required this.PIC_Name,required this.Description,required this.Position2,required this.Category,required this.Category_JT});

  factory Report_Partcard_DIP_new.fromJson(Map<String, dynamic> json) {
    return Report_Partcard_DIP_new(
      Plant: json['Plant'] ?? '' ,
      Material: json['Material'] ?? '',
      Material_quantity: json['Material_quantity'] ?? '',
      SLoc: json['SLoc'] ?? '',
      SlocDIP: json['SlocDIP'] ?? '',
      Model: json['Model'] ?? '',
      Quantity1: json['Quantity1'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Line: json['Line'] ?? '',
      Time: json['Time'] ?? '',
      ProductDate: json['ProductDate'] ?? '',
      Note: json['Note'] ?? '',
      PL: json['PL'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      PIC_Name: json['PIC_Name'] ?? '',
      Description: json['Description'] ?? '',
      Position2: json['Position2'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
    );
  }
}

class Get_List_KittingDIP_NotYet
{
  final String Plant;
  final String Material;
  final String Material_quantity;
  final String SLoc;
  final String SlocDIP;
  final String Model;
  final double Quantity1;
  final double Quantity;
  final String Line;
  final String Time;
  final String ProductDate;
  final String Note;
  final String PL;
  final String Position;
  final String PIC;
  final String PIC_Name;
  final String Description;
  final String Position1;
  final String Category;
  final String Category_JT;
  final int status;
  Get_List_KittingDIP_NotYet ({
    required this.Plant,
    required this.Material,
    required this.Material_quantity,
    required this.SLoc,
    required this.SlocDIP,
    required this.Model,
    required this.Quantity1,
    required this.Quantity,
    required this.Line,
    required this.Time,
    required this.ProductDate,
    required this.Note,
    required this.PL,
    required this.Position,
    required this.PIC,
    required this.PIC_Name,
    required this.Description,
    required this.Position1,
    required this.Category,
    required this.Category_JT,
    required this.status,
  });
  factory Get_List_KittingDIP_NotYet.fromJson(Map<String, dynamic> json) {
    return Get_List_KittingDIP_NotYet(
      Plant: json['Plant'] ?? '',
      Material: json['Material'] ?? '',
      Material_quantity: json['Material_quantity'] ?? '',
      SLoc: json['SLoc'] ?? '',
      SlocDIP: json['SlocDIP'] ?? '',
      Model: json['Model'] ?? '',
      Quantity1: json['Quantity1'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Line: json['Line'] ?? '',
      Time: json['Time'] ?? '',
      ProductDate: json['ProductDate'] ?? '',
      Note: json['Note'] ?? '',
      PL: json['PL'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      PIC_Name: json['PIC_Name'] ?? '',
      Description: json['Description'] ?? '',
      Position1: json['Position1'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
      status: json['status'] ?? '',
    );
  }
}