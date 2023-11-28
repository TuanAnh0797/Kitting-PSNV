class ClassOpenGR {
   String Material;
   String DaNo;
   String PONo;
   String POItem;
   String Qty;
   String ActQty;
   String POPending;
   String Status;
   String ID;

  ClassOpenGR({required this.Material,required this.DaNo,required this.PONo,required this.POItem, required this.Qty,required this.ActQty,required this.POPending,required this.Status,required this.ID});

  factory ClassOpenGR.fromJson(Map<String, dynamic> json) {
    return ClassOpenGR(
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
