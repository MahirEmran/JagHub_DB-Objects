import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_data.dart';
import 'event_data.dart';
import 'group_data.dart';

class API {
  late FirebaseFirestore database;

  API() {
    database = FirebaseFirestore.instance;
  }

  static const String usersCollection = "users";

  static const String nameKey = "name";
  static const String profilePicKey = "profilePic";
  static const String emailKey = "email";
  static const String pointsKey = "points";
  static const String gradeKey = "grade";
  static const String pastEventsKey = "pastEvents";
  static const String currentEventsKey = "currentEvents";
  static const String pastPointsKey = "pastPoints";
  static const String joinedGroupsKey = "joinedGroups";

  static const String eventsCollection = "events";

  static const String titleKey = "title";
  static const String descriptionKey = "description";
  static const String dateKey = "date";
  static const String timeKey = "time";
  static const String pointRewardKey = "pointReward";
  static const String locationKey = "location";
  static const String sourceKey = "source";
  static const String typeKey = "type";
  static const String qrCodeKey = "qrCode";

  static const String groupsCollection = "groups";

  static const String imageKey = "image";
  static const String announcementsCollection = "announcements";

  Future<UserData> getUserData(String id) async {
    DocumentSnapshot userInfo =
        await database.collection(usersCollection).doc(id).get();
    return UserData(
      userId: userInfo.id,
      name: userInfo.get(nameKey) as String,
      email: userInfo.get(emailKey) as String,
      profilePic: userInfo.get(profilePicKey) as String,
      currentEvents: (userInfo.get(currentEventsKey) as List).cast<String>(),
      pastEvents: (userInfo.get(pastEventsKey) as List).cast<String>(),
      pastPoints: (userInfo.get(pastPointsKey) as Map).cast<String, int>(),
      points: userInfo.get(pointsKey) as int,
      grade: userInfo.get(gradeKey) as int,
      joinedGroups: (userInfo.get(joinedGroupsKey) as List).cast<String>(),
    );
  }

  Future<List<UserData>> getUserList() async {
    List<UserData> users = [];
    QuerySnapshot userInfo = await database.collection(usersCollection).get();
    for (QueryDocumentSnapshot user in userInfo.docs) {
      users.add(
        UserData(
          userId: user.id,
          name: user.get(nameKey) as String,
          email: user.get(emailKey) as String,
          profilePic: user.get(profilePicKey) as String,
          currentEvents: user.get(currentEventsKey) as List<String>,
          pastEvents: user.get(pastEventsKey) as List<String>,
          pastPoints: user.get(pastPointsKey) as Map<String, int>,
          joinedGroups: user.get(joinedGroupsKey) as List<String>,
          points: user.get(pointsKey) as int,
          grade: user.get(gradeKey) as int,
        ),
      );
    }
    return users;
  }

  Future<UserData> getCurrentUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user!.email!;
    String userId = await getUserId(email);
    return await getUserData(userId);
  }

  Future<String> getUserId(String email) async {
    QuerySnapshot currentUsers = await database
        .collection(usersCollection)
        .where(emailKey, isEqualTo: email)
        .get();
    return currentUsers.docs[0].id;
  }

  Future<void> modifyUserData(String id, UserData newUserData) async {
    FirebaseFirestore.instance.collection(usersCollection).doc(id).update({
      nameKey: newUserData.name,
      profilePicKey: newUserData.profilePic,
      emailKey: newUserData.email,
      pointsKey: newUserData.points,
      gradeKey: newUserData.grade,
      pastEventsKey: newUserData.pastEvents,
      pastPointsKey: newUserData.pastPoints,
      currentEventsKey: newUserData.currentEvents,
    });
  }

  Future<bool> doesUserExist(String email) async {
    QuerySnapshot currentUsers = await database
        .collection(usersCollection)
        .where(emailKey, isEqualTo: email)
        .get();
    return currentUsers.docs.isEmpty;
  }

  void addUser(String name, String email, String profilePic) {
    Map<String, dynamic> userInfo = Map();
    userInfo[nameKey] = name;
    userInfo[emailKey] = email;
    userInfo[profilePicKey] = profilePic;
    userInfo[currentEventsKey] = [];
    userInfo[pastEventsKey] = [];
    userInfo[pointsKey] = 0;
    userInfo[gradeKey] = 0;
    userInfo[pastPointsKey] = [];
    database.collection(usersCollection).add(userInfo);
  }

  Future<List<EventData>> getEventList() async {
    List<EventData> events = [];
    QuerySnapshot eventInfo = await database.collection(eventsCollection).get();
    for (QueryDocumentSnapshot event in eventInfo.docs) {
      events.add(
        EventData(
          eventId: event.id,
          title: event.get(titleKey) as String,
          description: event.get(descriptionKey) as String,
          date: event.get(dateKey) as String,
          time: event.get(timeKey) as String,
          pointReward: event.get(pointRewardKey) as int,
          source: event.get(sourceKey) as String,
          type: event.get(typeKey) as String,
          location: event.get(locationKey) as String,
          qrCode: event.get(qrCodeKey) as String,
        ),
      );
    }
    return events;
  }

  void addEvent(EventData newEvent) {
    Map<String, dynamic> eventInfo = Map();
    eventInfo[titleKey] = newEvent.title;
    eventInfo[descriptionKey] = newEvent.description;
    eventInfo[dateKey] = newEvent.date;
    eventInfo[timeKey] = newEvent.time;
    eventInfo[pointRewardKey] = newEvent.pointReward;
    eventInfo[locationKey] = newEvent.location;
    eventInfo[sourceKey] = newEvent.source;
    eventInfo[typeKey] = newEvent.type;
    database.collection(eventsCollection).add(eventInfo);
  }

  void removeEvent(String eventId) {
    FirebaseFirestore.instance
        .collection(eventsCollection)
        .doc(eventId)
        .delete();
  }

  Future<EventData> getEvent(String eventId) async {
    DocumentSnapshot eventInfo =
        await database.collection(eventsCollection).doc(eventId).get();
    return EventData(
      eventId: eventId,
      title: eventInfo.get(titleKey) as String,
      description: eventInfo.get(descriptionKey) as String,
      location: eventInfo.get(locationKey) as String,
      time: eventInfo.get(timeKey) as String,
      date: eventInfo.get(dateKey) as String,
      source: eventInfo.get(sourceKey) as String,
      type: eventInfo.get(typeKey) as String,
      pointReward: eventInfo.get(pointRewardKey) as int,
      qrCode: eventInfo.get(qrCodeKey) as String,
    );
  }

  Future<void> joinEvent(String userId, String eventId) async {
    UserData user = await getUserData(userId);
    List<String> currentEvents = user.currentEvents;
    currentEvents.add(eventId);
    await modifyUserData(
        userId,
        UserData(
          currentEvents: currentEvents,
          name: user.name,
          email: user.email,
          userId: userId,
          grade: user.grade,
          points: user.points,
          pastEvents: user.pastEvents,
          pastPoints: user.pastPoints,
          joinedGroups: user.joinedGroups,
          profilePic: user.profilePic,
        ));
  }

  Future<void> leaveEvent(String userId, String eventId) async {
    UserData user = await getUserData(userId);
    List<String> currentEvents = user.currentEvents;
    currentEvents.remove(eventId);
    await modifyUserData(
        userId,
        UserData(
          currentEvents: currentEvents,
          name: user.name,
          email: user.email,
          userId: userId,
          grade: user.grade,
          points: user.points,
          pastEvents: user.pastEvents,
          pastPoints: user.pastPoints,
          joinedGroups: user.joinedGroups,
          profilePic: user.profilePic,
        ));
  }

  Future<List<String>> getUsersInEvent(String eventId) async {
    List<String> userIds = [];
    List<UserData> currentUsers = await getUserList();
    for (int i = 0; i < currentUsers.length; i++) {
      if (currentUsers[i].currentEvents.contains(eventId)) {
        userIds.add(currentUsers[i].userId);
      }
    }
    return userIds;
  }

  Future<void> makePastEvent(String eventId) async {
    List<String> userIds = await getUsersInEvent(eventId);
    for (int i = 0; i < userIds.length; i++) {
      UserData user = await getUserData(userIds[i]);
      user.currentEvents.remove(eventId);
      user.pastEvents.add(eventId);
      await modifyUserData(
          userIds[i],
          UserData(
              userId: userIds[i],
              email: user.email,
              profilePic: user.profilePic,
              name: user.name,
              currentEvents: user.currentEvents,
              pastEvents: user.pastEvents,
              points: user.points,
              grade: user.grade,
              pastPoints: user.pastPoints,
              joinedGroups: user.joinedGroups));
    }
  }

  void addGroup(GroupData newGroup) {
    Map<String, dynamic> groupInfo = Map();
    groupInfo[titleKey] = newGroup.title;
    groupInfo[imageKey] = newGroup.image;
    database.collection(eventsCollection).add(groupInfo);
  }

  Future<List<String>> getUsersInGroup(String groupId) async {
    List<String> userIds = [];
    List<UserData> currentUsers = await getUserList();
    for (int i = 0; i < currentUsers.length; i++) {
      if (currentUsers[i].joinedGroups.contains(groupId)) {
        userIds.add(currentUsers[i].userId);
      }
    }
    return userIds;
  }

  Future<void> joinGroup(String userId, String groupId) async {
    UserData user = await getUserData(userId);
    List<String> joinedGroups = user.joinedGroups;
    joinedGroups.add(groupId);
    await modifyUserData(
        userId,
        UserData(
          currentEvents: user.currentEvents,
          name: user.name,
          email: user.email,
          userId: userId,
          grade: user.grade,
          points: user.points,
          pastEvents: user.pastEvents,
          pastPoints: user.pastPoints,
          joinedGroups: joinedGroups,
          profilePic: user.profilePic,
        ));
  }

  Future<void> leaveGroup(String userId, String groupId) async {
    UserData user = await getUserData(userId);
    List<String> joinedGroups = user.joinedGroups;
    joinedGroups.remove(groupId);
    await modifyUserData(
        userId,
        UserData(
          currentEvents: user.currentEvents,
          name: user.name,
          email: user.email,
          userId: userId,
          grade: user.grade,
          points: user.points,
          pastEvents: user.pastEvents,
          pastPoints: user.pastPoints,
          joinedGroups: joinedGroups,
          profilePic: user.profilePic,
        ));
  }
}
