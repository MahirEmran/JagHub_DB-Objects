import 'package:flutter/gestures.dart';

class UserData {
  late String _userId;
  late String _email;
  late String _profilePic;
  late String _name;
  late List<String> _currentEvents;
  late List<String> _pastEvents;
  late int _points;
  late int _grade;
  late Map<String, int> _pastPoints;
  late List<String> _joinedGroups;

  UserData({
    required String userId,
    required String email,
    required String profilePic,
    required String name,
    required List<String> currentEvents,
    required List<String> pastEvents,
    required int points,
    required int grade,
    required Map<String, int> pastPoints,
    required List<String> joinedGroups,
  }) {
    _userId = userId;
    _email = email;
    _profilePic = profilePic;
    _name = name;
    _currentEvents = currentEvents;
    _pastEvents = pastEvents;
    _points = points;
    _grade = grade;
    _pastPoints = pastPoints;
    _joinedGroups = joinedGroups;
  }

  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  String get profilePic {
    return _profilePic;
  }

  String get name {
    return _name;
  }

  List<String> get currentEvents {
    return _currentEvents;
  }

  List<String> get pastEvents {
    return _pastEvents;
  }

  int get points {
    return _points;
  }

  int get grade {
    return _grade;
  }

  Map<String, int> get pastPoints {
    return _pastPoints;
  }

  List<String> get joinedGroups {
    return _joinedGroups;
  }
}
