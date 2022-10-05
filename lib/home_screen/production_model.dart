class ProductionModel {
  final int id;
  final String bale_5_Sp;
  final String bale_10_Sp;
  final String slice_Sp;
  final String bombolino_Sp;
  final String bale_5;
  final String bale_10;
  final String slice;
  final String bombolino;
  final String producedDate;
  ProductionModel(
      {this.bale_5,
      this.id,
      this.bale_10,
      this.slice,
      this.producedDate,
      this.bombolino,
      this.bale_5_Sp,
      this.bale_10_Sp,
      this.bombolino_Sp,
      this.slice_Sp});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bale_5': bale_5,
      'bale_10': bale_10,
      'slice': slice,
      'bombolino': bombolino,
      'bale_5_Sp': bale_5_Sp,
      'bale_10_Sp': bale_10_Sp,
      'slice_Sp': slice_Sp,
      'producedDate': producedDate,
      'bombolino_Sp': bombolino_Sp
    };
  }

  static ProductionModel fromMap(Map<String, dynamic> map) {
    return ProductionModel(
        id: map['id'],
        bale_5: map['bale_5'],
        bale_10: map['bale_10'],
        slice: map['slice'],
        bombolino: map['bombolino'],
        bale_5_Sp: map['bale_5_Sp'],
        bale_10_Sp: map['bale_10_Sp'],
        slice_Sp: map['slice_Sp'],
        producedDate: map['producedDate'],
        bombolino_Sp: map['bombolino_Sp']);
  }
}
