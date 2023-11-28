//======= dt_kittingTran //==========
class Get_KittingTran_Issue_line_Partcard {
  final String Partcode;
  final int Status;
  final double Quantity;
  final String Model;
  final String Line;
  final String Time;
  final String Issue_Sloc;
  final String DeliveryDate;
  final String BarcodeCarton;
  final String BarcodePartcard;
  //final String Typekitting;
  final int SttCheck;

  Get_KittingTran_Issue_line_Partcard(
      {
        required this.Partcode,
        required this.Status,
        required this.Quantity,
        required this.Model,
        required this.Line,
        required this.Time,
        required this.Issue_Sloc,
        required this.DeliveryDate,
        required this.BarcodeCarton,
        required this.BarcodePartcard,
        //required this.Typekitting,
        required this.SttCheck,
      });

  factory Get_KittingTran_Issue_line_Partcard.fromJson(Map<String, dynamic> json) {
    return Get_KittingTran_Issue_line_Partcard(
      Partcode: json['Partcode'] ?? '',
      Status: json['Status'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Model: json['Model'] ?? '',
      Line: json['Line'] ?? '',
      Time: json['Time'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      DeliveryDate: json['DeliveryDate'] ?? '',
      BarcodeCarton: json['BarcodeCarton'] ?? '',
      BarcodePartcard: json['BarcodePartcard'] ?? '',
      //Typekitting: json['Typekitting'] ?? '',
      SttCheck: json['SttCheck'] ?? '',
    );
  }
}

//======= dt_temp //==========
class Report_Partcard_DIP_new
{
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
  Report_Partcard_DIP_new ({
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
    required this.Position2,
    required this.Category,
    required this.Category_JT,
  });
  factory Report_Partcard_DIP_new.fromJson(Map<String, dynamic> json) {
    return Report_Partcard_DIP_new(
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
      Position2: json['Position1'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
    );
  }
}