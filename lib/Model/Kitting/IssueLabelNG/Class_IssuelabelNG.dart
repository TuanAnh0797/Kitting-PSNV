class procGetInfoMaterial_SLOC
{
  final String Plant;
  final String Material;
  final int ID;
  final String Sloc;
  final String Position;
  final double Quantity;

  procGetInfoMaterial_SLOC ({
    required this.Plant,
    required this.Material,
    required this.ID,
    required this.Sloc,
    required this.Position,
    required this.Quantity,

  });
  factory procGetInfoMaterial_SLOC.fromJson(Map<String, dynamic> json) {
    return procGetInfoMaterial_SLOC(
      Plant: json['Plant'] ?? '',
      Material: json['Material'] ?? '',
      ID: json['ID'] ?? '',
      Sloc: json['Sloc'] ?? '',
      Position: json['Position'] ?? '',
      Quantity: json['Quantity'] ?? '',
    );
  }
}