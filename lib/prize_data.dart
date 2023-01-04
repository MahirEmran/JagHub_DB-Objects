class PrizeData {
  late String _prizeId;
  late String _name;
  late int _pointCost;
  late String _image;
  late String _description;
  late String _details;
  late bool _buyable;

  PrizeData({
    required String prizeId,
    required String name,
    required int pointCost,
    required String image,
    required String description,
    required String details,
    required bool buyable,
  }) {
    _prizeId = prizeId;
    _name = name;
    _pointCost = pointCost;
    _image = image;
    _description = description;
    _details = details;
    _buyable = buyable;
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

  String get details {
    return _details;
  }

  String get description {
    return _description;
  }

  bool get buyable {
    return _buyable;
  }
}
