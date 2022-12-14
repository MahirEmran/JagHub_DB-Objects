class GroupData {
  late String _groupId;
  late String _title;
  late String _image;

  GroupData({
    required String groupId,
    required String title,
    required String image,
  }) {
    _groupId = groupId;
    _title = title;
    _image = image;
  }

  String get groupId {
    return _groupId;
  }

  String get title {
    return _title;
  }

  String get image {
    return _image;
  }
}
