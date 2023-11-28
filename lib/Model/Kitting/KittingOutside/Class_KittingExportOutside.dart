class Get_TBLGRTrans {
  int GRTranID;
  double AvaiableQuantity;
  double GetQuantity;

  Get_TBLGRTrans({required this.GRTranID,required this.AvaiableQuantity,required this.GetQuantity});

  factory Get_TBLGRTrans.fromJson(Map<String, dynamic> json) {
    return Get_TBLGRTrans(
      GRTranID: json['GRTranID'] ?? '' ,
      AvaiableQuantity: json['AvaiableQuantity'] ?? '',
      GetQuantity: json['GetQuantity'] ?? '',
    );
  }
}