class PrizeData {
  late String _prizeId;
  late String _name;
  late int _pointCost;
  late String _image;

  PrizeData({
    required String prizeId,
    required String name,
    required int pointCost,
    required String image,
  }) {
    _prizeId = prizeId;
    _name = name;
    _pointCost = _pointCost;
    _image = image;
  }

  String get prizeId {
    return _prizeId;
  }

  String get name {
    return _name;
  }

  int get pointCost {
    return _pointCost;
  }

  String get image {
    return _image;
  }
}
