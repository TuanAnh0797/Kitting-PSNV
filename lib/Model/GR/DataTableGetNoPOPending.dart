import 'package:flutter/material.dart';

class DataTableGetNoPOPending {
  final String unitno;
  final String material;
  final double quantitybox;
  final String sloc;
  final String invoiceno;
  final String ctrkey;
  final String t;

  DataTableGetNoPOPending(
      {required this.unitno,
        required this.material,
        required this.quantitybox,
        required this.sloc,
        required this.invoiceno,
        required this.ctrkey,
        required this.t});

  factory DataTableGetNoPOPending.fromJson(Map<String, dynamic> json) {
    return DataTableGetNoPOPending(
      unitno: json['UnitNo'] ?? '',
      material: json['Material'] ?? '',
      quantitybox: json['QuantityBox'] ?? '',
      sloc: json['Sloc'] ?? '',
      invoiceno: json['InvoiceNo'] ?? '',
      ctrkey: json['CtrlKey'] ?? '',
      t: json['T'] ?? '',
    );
  }
}

class InvoiceModel2 {
  final  String? mAHOADON;
  final  String? tENKH;
  final String? dIACHI;
  final int? tONG_TIEN;
  final int? dA_TT;
  final int? cON_LAI;
  final  String? gHI_CHU;
  final String? sDT;
  final String? iNSERT_DT1;
  final String? gHI_CHU_SHOP;



  InvoiceModel2(
      {this.mAHOADON,
        this.tENKH,
        this.sDT,
        this.dIACHI,
        this.tONG_TIEN,
        this.dA_TT,
        this.cON_LAI,
        this.gHI_CHU,
        this.iNSERT_DT1,
        this.gHI_CHU_SHOP,
      });

  factory InvoiceModel2.fromJson(Map<String, dynamic> json) {
    return InvoiceModel2(
      mAHOADON : json['MAHOADON']??'',
      tENKH : json['TENKH']??'',
      sDT : json['SDT']??'',
      dIACHI : json['DIACHI']??'',
      tONG_TIEN : json['TONG_TIEN']??'',
      dA_TT : json['DA_TT']??'',
      cON_LAI : json['CON_LAI']??'',
      gHI_CHU : json['GHI_CHU']??'',
      iNSERT_DT1 : json['INSERT_DT1']??'',
      gHI_CHU_SHOP : json['GHI_CHU_SHOP']??'',);

  }
}
