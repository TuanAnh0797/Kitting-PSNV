class ClassListGRPending {
  String Material;
  String Qty;
  String ActQty;
  String PONo;
  String POItem;
  String DAItem;
  String Plant;
  String Vendercode;

  ClassListGRPending({required this.Material,required this.Qty,required this.ActQty,required this.PONo, required this.POItem,required this.DAItem,required this.Plant,required this.Vendercode});

  factory ClassListGRPending.fromJson(Map<String, dynamic> json) {
    return ClassListGRPending(
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