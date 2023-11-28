

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
  final String Typekitting;

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
        required this.Typekitting,
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
      Typekitting: json['Typekitting'] ?? '',
    );
  }
}

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
        //required this.Descriptions,
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

//==================//// ================================
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