class GetMaterialLocked {
  String Barcode;
  int GRTranID;

  GetMaterialLocked({required this.Barcode,required this.GRTranID});

  factory GetMaterialLocked.fromJson(Map<String, dynamic> json) {
    return GetMaterialLocked(
      Barcode: json['Barcode'] ?? '' ,
      GRTranID: json['GRTranID'] ?? '',
    );
  }
}

