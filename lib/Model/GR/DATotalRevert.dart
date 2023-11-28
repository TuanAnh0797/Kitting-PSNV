class DATotalRevert {
  final String material;
  final String daNo;
  final String pONo;
  final String pOItem;
  final String qty;
  final String actQty;
  final String pOPending;
  final String status;
  final String iD;

  DATotalRevert({
    required this.material,
    required this.daNo,
    required this.pONo,
    required this.pOItem,
    required this.qty,
    required this.actQty,
    required this.pOPending,
    required this.status,
    required this.iD,
  });
  factory DATotalRevert.fromJson(Map<String, dynamic> json) {
    return DATotalRevert(
      material: json['Material'],
      daNo: json['DaNo'],
      pONo: json['PONo'],
      pOItem: json['POItem'],
      qty: json['Qty'],
      actQty: json['ActQty'],
      pOPending: json['POPending'],
      status: json['Status'],
      iD: json['ID'],
    );
  }
}

