//============================ // dt_kittingTran // ============================
import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Get_KittingTran_Partcard {
  String Partcode;
  String Status;
  String Quantity;
  String Model;
  String Line;
  String Time;
  String Issue_Sloc;
  String DeliveryDate;
  String BarcodeCarton;
  String BarcodePartcard;
  String TypeKitting;
  String StatusDelay;
  String SttCheck;

  Get_KittingTran_Partcard({required this.Partcode,required this.Status,required this.Quantity,required this.Model, required this.Line,required this.Time,required this.Issue_Sloc,
    required this.DeliveryDate,required this.BarcodeCarton,required this.BarcodePartcard, required this.TypeKitting, required this.StatusDelay, required this.SttCheck});

  factory Get_KittingTran_Partcard.fromJson(Map<String, dynamic> json) {
    return Get_KittingTran_Partcard(
      Partcode: json['Partcode'] ,
      Status: json['Status'],
      Quantity: json['Quantity'],
      Model: json['Model'],
      Line: json['Line'],
      Time: json['Time'],
      Issue_Sloc: json['Issue_Sloc'],
      DeliveryDate: json['DeliveryDate'],
      BarcodeCarton: json['BarcodeCarton'],
      BarcodePartcard: json['BarcodePartcard'],
      TypeKitting: json['TypeKitting'],
      StatusDelay: json['StatusDelay'],
      SttCheck: json['SttCheck'],
    );
  }
}

class Get_KittingTran_Partcard_All {
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
  String TypeKitting;
  int StatusDelay;
  int SttCheck;

  Get_KittingTran_Partcard_All({required this.Partcode,required this.Status,required this.Quantity,required this.Model, required this.Line,required this.Time,required this.Issue_Sloc,
    required this.DeliveryDate,required this.BarcodeCarton,required this.BarcodePartcard, required this.TypeKitting, required this.StatusDelay, required this.SttCheck});

  factory Get_KittingTran_Partcard_All.fromJson(Map<String, dynamic> json) {
    return Get_KittingTran_Partcard_All(
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
      TypeKitting: json['TypeKitting'] ?? '',
      StatusDelay: json['StatusDelay'] ?? '',
      SttCheck: json['SttCheck'] ?? '',
    );
  }
}
//========================// //=================================================

//========================// dt_temp  : n time = //=================================================
class Supply_NTime_Delivery {

  final String Plant;
  final String Reservation_No;
  final String Recipient;
  final String Line;
  final String Time;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final String Descriptions;
  final String Unit;
  final double Quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  final String Position;
  final String PIC;
  final int Status;
  final int Model_Quantity;
  final double ActualQuantity;
  final String PICModel;
  final String SortTime;
  final String Material_special;
  final String Category;
  final String Category_JT;
  final String Position_FA;

  Supply_NTime_Delivery(
      {
        required this.Plant,
        required this.Reservation_No,
        required this.Recipient,
        required this.Line,
        required this.Time,
        required this.Model,
        required this.Deliverydate,
        required this.Partcode,
        required this.Descriptions,
        required this.Unit,
        required this.Quantity,
        required this.Receipt_Location,
        required this.Issue_Sloc,
        required this.Position,
        required this.PIC,
        required this.Status,
        required this.Model_Quantity,
        required this.ActualQuantity,
        required this.PICModel,
        required this.SortTime,
        required this.Material_special,
        required this.Category,
        required this.Category_JT,
        required this.Position_FA,

      });

  factory Supply_NTime_Delivery.fromJson(Map<String, dynamic> json) {
    return Supply_NTime_Delivery(
      Plant: json['Plant'] ?? '',
      Reservation_No: json['Reservation_No'] ?? '',
      Recipient: json['Recipient'] ?? '',
      Line: json['Line'] ?? '',
      Time: json['Time'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      Descriptions: json['Descriptions'] ?? '',
      Unit: json['Unit'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Status: json['Status'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      ActualQuantity: json['ActualQuantity'] ?? '',
      PICModel: json['PICModel'] ?? '',
      SortTime: json['SortTime'] ?? '',
      Material_special: json['Material_special'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
      Position_FA: json['Position_FA'] ?? '',

    );
  }
}
//========================// //===============================

//========================// dt_temp  : 1 time = //=================================================
class Supply_1Time_Delivery {
  final String Time;
  final String Plant;
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final String Descriptions;
  final String Unit;
  final double Quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  final int Status;
  final String Position;
  final String PIC;
  final String Material_special;
  final String Category;
  final String Category_JT;
  final String Position_FA;

  Supply_1Time_Delivery(
      {
        required this.Time,
        required this.Plant,
        required this.Line,
        required this.Model,
        required this.Deliverydate,
        required this.Partcode,
        required this.Descriptions,
        required this.Unit,
        required this.Quantity,
        required this.Receipt_Location,
        required this.Issue_Sloc,
        required this.Status,
        required this.Position,
        required this.PIC,
        required this.Material_special,
        required this.Category,
        required this.Category_JT,
        required this.Position_FA,
      });

  factory Supply_1Time_Delivery.fromJson(Map<String, dynamic> json) {
    return Supply_1Time_Delivery(
      Time: json['Time'] ?? '',
      Plant: json['Plant'] ?? '',
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      Descriptions: json['Descriptions'] ?? '',
      Unit: json['Unit'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Status: json['Status'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Material_special: json['Material_special'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
      Position_FA: json['Position_FA'] ?? '',

    );
  }
}
//========================// //=================================================

//========================// dt_temp  : 2 prepare time = //=================================================
class Supply_PreparetionNTime {
  final String Plant;
  final String Reservation_No;
  final String Recipient;
  final String Line;
  final String Time;
  final String OutTime;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final String Descriptions;
  final String Unit;
  final double Quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  final String Position;
  final String PIC;
  final int Status;
  final int Model_Quantity;
  final double ActualQuantity;
  final String SortTime;
  final String Material_special;
  final String Category;
  final String Category_JT;
  final String Position_FA;

  Supply_PreparetionNTime(
      {
        required this.Plant,
        required this.Reservation_No,
        required this.Recipient,
        required this.Line,
        required this.Time,
        required this.OutTime,
        required this.Model,
        required this.Deliverydate,
        required this.Partcode,
        required this.Descriptions,
        required this.Unit,
        required this.Quantity,
        required this.Receipt_Location,
        required this.Issue_Sloc,
        required this.Position,
        required this.PIC,
        required this.Status,
        required this.Model_Quantity,
        required this.ActualQuantity,
        required this.SortTime,
        required this.Material_special,
        required this.Category,
        required this.Category_JT,
        required this.Position_FA,
      });

  factory Supply_PreparetionNTime.fromJson(Map<String, dynamic> json) {
    return Supply_PreparetionNTime(
      Plant: json['Plant'] ?? '',
      Reservation_No: json['Reservation_No'] ?? '',
      Recipient: json['Recipient'] ?? '',
      Line: json['Line'] ?? '',
      Time: json['Time'] ?? '',
      OutTime: json['OutTime'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      Descriptions: json['Descriptions'] ?? '',
      Unit: json['Unit'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Status: json['Status'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      ActualQuantity: json['ActualQuantity'] ?? '',
      SortTime: json['SortTime'] ?? '',
      Material_special: json['Material_special'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
      Position_FA: json['Position_FA'] ?? '',
    );
  }
}
//==================// // ================================

//========================// dt_temp  : 8 Supply_XHGopModel_Delivery //=================================================
class Supply_XHGopModel_Delivery {
  final String Time;
  final String Plant;
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final String Descriptions;
  final String Unit;
  final double Quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  final int Status;
  final String Position;
  final String PIC;
  final String Material_special;
  final String Category;
  final String Category_JT;
  final String Position_FA;

  Supply_XHGopModel_Delivery(
      {
        required this.Time,
        required this.Plant,
        required this.Line,
        required this.Model,
        required this.Deliverydate,
        required this.Partcode,
        required this.Descriptions,
        required this.Unit,
        required this.Quantity,
        required this.Receipt_Location,
        required this.Issue_Sloc,
        required this.Status,
        required this.Position,
        required this.PIC,
        required this.Material_special,
        required this.Category,
        required this.Category_JT,
        required this.Position_FA,
      });

  factory Supply_XHGopModel_Delivery.fromJson(Map<String, dynamic> json) {
    return Supply_XHGopModel_Delivery(
      Time: json['Time'] ?? '',
      Plant: json['Plant'] ?? '',
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      Descriptions: json['Descriptions'] ?? '',
      Unit: json['Unit'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Status: json['Status'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Material_special: json['Material_special'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
      Position_FA: json['Position_FA'] ?? '',

    );
  }
}
//==================// // ================================

//========================// dt_temp  : defautl: Supply_Preparetion_Delivery //=================================================
class Supply_Preparetion_Delivery {
  final String Time;
  final String Plant;
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  //final String Descriptions;
  final String Unit;
  final double Quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  //final int Status;
  final String Position;
  final String PIC;
  final String Material_special;
  final String Category;
  final String Category_JT;
  final String Position_FA;

  Supply_Preparetion_Delivery(
      {
        required this.Time,
        required this.Plant,
        required this.Line,
        required this.Model,
        required this.Deliverydate,
        required this.Partcode,
        // required this.Descriptions,
        required this.Unit,
        required this.Quantity,
        required this.Receipt_Location,
        required this.Issue_Sloc,
        //required this.Status,
        required this.Position,
        required this.PIC,
        required this.Material_special,
        required this.Category,
        required this.Category_JT,
        required this.Position_FA,
      });

  factory Supply_Preparetion_Delivery.fromJson(Map<String, dynamic> json) {
    return Supply_Preparetion_Delivery(
      Time: json['Time'] ?? '',
      Plant: json['Plant'] ?? '',
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      //Descriptions: json['Descriptions'] ?? '',
      Unit: json['Unit'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      //Status: json['Status'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Material_special: json['Material_special'] ?? '',
      Category: json['Category'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
      Position_FA: json['Position_FA'] ?? '',

    );
  }
}
//==================// // ================================

class Get_SumQuantity_Supply {
  final String Model;
  final int Quantity;
  final String Line;

  Get_SumQuantity_Supply(
      {
        required this.Model,
        required this.Quantity,
        required this.Line,
      });
  factory Get_SumQuantity_Supply.fromJson(Map<String, dynamic> json)
  {
    return Get_SumQuantity_Supply(
      Model: json['Model'] ?? '',
      Quantity: json['Quantity'] ?? '',
      Line: json['Line'] ?? '',
    );
  }
}
//ProcKitting1Time_PartdCard_NOTime_category
//================== /dt_not_yes_kitting,  ==> khong the nao viet chung duoc class API //===============
//KittingNTime
class ProcKittingNTime_PartCard_Category {
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

  ProcKittingNTime_PartCard_Category({
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

  factory ProcKittingNTime_PartCard_Category.fromJson(
      Map<String, dynamic> json) {
    return ProcKittingNTime_PartCard_Category(
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
//Kitting1Time
class ProcKitting1Time_PartdCard_NOTime_category
{
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final double quantity;
  final int Model_Quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  final int Status;
  final String Plant;
  final String Position;
  final String PIC;
  final String Category_JT;

  ProcKitting1Time_PartdCard_NOTime_category ({
    required this.Line,
    required this.Model,
    required this.Deliverydate,
    required this.Partcode,
    required this.quantity,
    required this.Model_Quantity,
    required this.Receipt_Location,
    required this.Issue_Sloc,
    required this.Status,
    required this.Plant,
    required this.Position,
    required this.PIC,
    required this.Category_JT,
  });
  factory ProcKitting1Time_PartdCard_NOTime_category.fromJson(Map<String, dynamic> json) {
    return ProcKitting1Time_PartdCard_NOTime_category(
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      quantity: json['quantity'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Status: json['Status'] ?? '',
      Plant: json['Plant'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
    );
  }
}
//XHGopModel
class ProcKitting_XHGopModel_PartdCard_NOTime_Category
{
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final double quantity;
  final int Model_Quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  final int Status;
  final String Plant;
  final String Position;
  final String PIC;
  final String Category_JT;
  ProcKitting_XHGopModel_PartdCard_NOTime_Category ({
    required this.Line,
    required this.Model,
    required this.Deliverydate,
    required this.Partcode,
    required this.quantity,
    required this.Model_Quantity,
    required this.Receipt_Location,
    required this.Issue_Sloc,
    required this.Status,
    required this.Plant,
    required this.Position,
    required this.PIC,
    required this.Category_JT,
  });
  factory ProcKitting_XHGopModel_PartdCard_NOTime_Category.fromJson(Map<String, dynamic> json) {
    return ProcKitting_XHGopModel_PartdCard_NOTime_Category(
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      quantity: json['quantity'] ?? '',
      Model_Quantity: json['Model_Quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Status: json['Status'] ?? '',
      Plant: json['Plant'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Category_JT: json['Category_JT'] ?? '',
    );
  }
}
//PrepareNTime
class ProcKittingPrepareNTime_PartCard_category
{
  final String Partcode;
  final String Issue_Sloc;
  final double Quantity;
  final String Model;
  final String Line;
  final int Model_Quantity;
  final String Receipt_Location;
  final String Deliverydate;
  final String Plant;
  final int Status;
  final String Position;
  final String PIC;
  ProcKittingPrepareNTime_PartCard_category ({

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
  factory ProcKittingPrepareNTime_PartCard_category.fromJson(Map<String, dynamic> json) {
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
class ProcKittingPrepare1Time_PartCard_NOTime_category
{
  final String Line;
  final String Model;
  final String Deliverydate;
  final String Partcode;
  final double quantity;
  final int Model_quantity;
  final String Receipt_Location;
  final String Issue_Sloc;
  final int Status;
  final String Position;
  final String PIC;
  final String Plant;
  ProcKittingPrepare1Time_PartCard_NOTime_category ({

    required this.Line,
    required this.Model,
    required this.Deliverydate,
    required this.Partcode,
    required this.quantity,
    required this.Model_quantity,
    required this.Receipt_Location,
    required this.Issue_Sloc,
    required this.Status,
    required this.Position,
    required this.PIC,
    required this.Plant,
  });
  factory ProcKittingPrepare1Time_PartCard_NOTime_category.fromJson(Map<String, dynamic> json) {
    return ProcKittingPrepare1Time_PartCard_NOTime_category(
      Line: json['Line'] ?? '',
      Model: json['Model'] ?? '',
      Deliverydate: json['Deliverydate'] ?? '',
      Partcode: json['Partcode'] ?? '',
      quantity: json['quantity'] ?? '',
      Model_quantity: json['Model_quantity'] ?? '',
      Receipt_Location: json['Receipt_Location'] ?? '',
      Issue_Sloc: json['Issue_Sloc'] ?? '',
      Status: json['Status'] ?? '',
      Position: json['Position'] ?? '',
      PIC: json['PIC'] ?? '',
      Plant: json['Plant'] ?? '',
    );
  }
}
//========================// //=================================================