import 'package:flutter/material.dart';

class DataModel {
  final String id;
  final String da;
  final String status;

  DataModel({required this.id, required this.da, required this.status});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] ?? '',
      da: json['da'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
