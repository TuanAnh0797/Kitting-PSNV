import 'dart:ui';

class Get_List_CheckStock {
  String UnitNo;
  int StorageID;
  String InvoiceNo;
  double QuantityDetail;
  double QuantityBox;
  int Status;
  String Create_date;
  String Create_User;
  int PositionID;
  double GetQuantity;
  double AvaiableQuantity;


  Get_List_CheckStock({required this.UnitNo,required this.StorageID,required this.InvoiceNo,required this.QuantityDetail, required this.QuantityBox,required this.Status,required this.Create_date,
    required this.Create_User,required this.PositionID,required this.GetQuantity, required this.AvaiableQuantity });

  factory Get_List_CheckStock.fromJson(Map<String, dynamic> json) {
    return Get_List_CheckStock(
      UnitNo: json['UnitNo'] ?? '',
      StorageID: json['StorageID'] ?? '',
      InvoiceNo: json['InvoiceNo'] ?? '',
      QuantityDetail: json['QuantityDetail'] ?? '',
      QuantityBox: json['QuantityBox'] ?? '',
      Status: json['Status'] ?? '',
      Create_date: json['Create_date'] ?? '',
      Create_User: json['Create_User'] ?? '',
      PositionID: json['PositionID'] ?? '',
      GetQuantity: json['GetQuantity'] ?? '',
      AvaiableQuantity: json['AvaiableQuantity'] ?? '',
    );
  }
}

class Get_Reason_UpdateBox {
  String Reason;
  Get_Reason_UpdateBox({required this.Reason });
  factory Get_Reason_UpdateBox.fromJson(Map<String, dynamic> json) {
    return Get_Reason_UpdateBox(
      Reason: json['Reason'] ?? '',
    );
  }
}



class Get_List_CheckStock_duoiL {
  String DateStogare;
  double Qty_Lot;

  Get_List_CheckStock_duoiL({required this.DateStogare,required this.Qty_Lot });

  factory Get_List_CheckStock_duoiL.fromJson(Map<String, dynamic> json) {
    return Get_List_CheckStock_duoiL(
      DateStogare: json['DateStogare'] ?? '',
      Qty_Lot: json['Qty_Lot'] ?? '',
    );
  }
}

class procGetInfoMaterial {
  String Material;
  String Sloc;
  double Qty;
  String Pos;
  double SubQty;
  String SubPos;
  String PIC;
  String Plant;

  procGetInfoMaterial({required this.Material,required this.Sloc,required this.Qty,required this.Pos, required this.SubQty,required this.SubPos,required this.PIC,
    required this.Plant });

  factory procGetInfoMaterial.fromJson(Map<String, dynamic> json) {
    return procGetInfoMaterial(
      Material: json['Material'] ?? '',
      Sloc: json['Sloc'] ?? '',
      Qty: json['Qty'] ?? '',
      Pos: json['Pos'] ?? '',
      SubQty: json['SubQty'] ?? '',
      SubPos: json['SubPos'] ?? '',
      PIC: json['PIC'] ?? '',
      Plant: json['Plant'] ?? '',
    );
  }
}

class Get_Detail_Dependent_CheckSloc {
  int ID;
  String Position;
  double Quantity;

  Get_Detail_Dependent_CheckSloc({required this.ID,required this.Position,required this.Quantity });

  factory Get_Detail_Dependent_CheckSloc.fromJson(Map<String, dynamic> json) {
    return Get_Detail_Dependent_CheckSloc(
      ID: json['ID'] ?? '',
      Position: json['Position'] ?? '',
      Quantity: json['Quantity'] ?? '',
    );
  }
}



class Get_TBLGRTrans {
  int GRTranID;
  double AvaiableQuantity;
  double GetQuantity;

  Get_TBLGRTrans({required this.GRTranID, required this.AvaiableQuantity, required this.GetQuantity });
  factory Get_TBLGRTrans.fromJson(Map<String, dynamic> json) {
    return Get_TBLGRTrans(
      GRTranID: json['GRTranID'] ?? '',
      AvaiableQuantity: json['AvaiableQuantity'] ?? '',
      GetQuantity: json['GetQuantity'] ?? '',
    );
  }
}

