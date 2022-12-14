class EventData {
  late String _eventId;
  late String _title;
  late String _description;
  late String _location;
  late String _time;
  late String _date;
  late String _source;
  late String _type;
  late int _pointReward;
  late String _qrCode;

  EventData({
    required String eventId,
    required String title,
    required String description,
    required String location,
    required String time,
    required String date,
    required String source,
    required String type,
    required int pointReward,
    required String qrCode,
  }) {
    _eventId = eventId;
    _title = title;
    _description = description;
    _location = location;
    _time = time;
    _date = date;
    _source = source;
    _type = type;
    _pointReward = pointReward;
    _qrCode = qrCode;
  }

  String get eventId {
    return _eventId;
  }

  String get title {
    return _title;
  }

  String get description {
    return _description;
  }

  String get location {
    return _location;
  }

  String get time {
    return _time;
  }

  String get date {
    return _date;
  }

  String get source {
    return _source;
  }

  int get pointReward {
    return _pointReward;
  }

  String get type {
    return _type;
  }

  String get qrCode {
    return _qrCode;
  }
}
