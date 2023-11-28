class DataTableDATotal{
  final String dATotalID;
  final String dANo;
  final String venderCode;
  final String dAItem;
  final String pONo;
  final String pOItem;
  final String plant;
  final String material;
  final String qtyOrigin;
  final double quantity;
  final String status;
  final String position;
  final String sloc;

  DataTableDATotal(
      {
        required this.dATotalID,required this.dANo,required this.venderCode,required this.dAItem,required this.pONo,
        required  this.pOItem,required this.plant,required this.material,required this.qtyOrigin,required this.quantity,
        required this.status,
        required  this.position,required this.sloc
      }
      );


  factory DataTableDATotal.fromJson(Map<String, dynamic> json) {
    return DataTableDATotal(
      dATotalID: json['DATotalID'] ?? '',
      dANo: json['DANo'] ?? '',
      venderCode: json['VenderCode'] ?? '',
      dAItem: json['DAItem'] ?? '',
      pONo: json['PONo'] ?? '',
      pOItem: json['POItem'] ?? '',
      plant: json['Plant'] ?? '',
      material: json['Material'] ?? '',
      qtyOrigin: json['QtyOrigin'] ?? '',
      quantity: json['Quantity'] ?? '',
      status: json['Status'] ?? '',
      position: json['Position'] ?? '',
      sloc: json['Sloc'] ?? '',

    );
  }

}