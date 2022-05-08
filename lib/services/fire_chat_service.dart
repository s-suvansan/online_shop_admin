import '../main_index.dart';

class FireChatService {
  //get chat list
  static Stream<QuerySnapshot> getChatsList() {
    return Firestore.instance.collection(Global.CHAT_ROOM).snapshots();
  }

  // get chat snapshot for stream build
  static Stream<DocumentSnapshot> getChats({@required String userId}) {
    return Firestore.instance.collection(Global.CHAT_ROOM).document(userId).snapshots();
  }

  //sent Message
  static Future<bool> sentMessage(MessageModel data, {@required String userId}) async {
    // Call the user's CollectionReference to add a new user
    try {
      await Firestore.instance
          .collection(Global.CHAT_ROOM)
          .document(userId)
          .setData({"${Timestamp.now().toDate()}": data.toJson()}, merge: true);
      var _data = data.toJson();
      await setUserChatInfo(
        ChatListModel(
          userId: userId,
          userName: userId,
          userImage: "",
          lastMessage: _data["message"],
          lastMessageTime: _data["dateTime"],
          isLastMessageImage: _data["images"].isNotEmpty,
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //sent Message
  static Future<bool> setUserChatInfo(
    ChatListModel data,
  ) async {
    // Call the user's CollectionReference to add a new user
    try {
      await Firestore.instance.collection(Global.CHAT_LIST).document(data.userId).setData(data.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<DocumentSnapshot> getIsTyping({@required String userId}) {
    return Firestore.instance
        .collection(Global.CHAT_ROOM)
        .document(userId)
        .collection("realtime_typing")
        .document("typing")
        .snapshots();
  }

  //sent Message
  static Future<void> setIsTyping(bool val, {@required String userId}) async {
    // Call the user's CollectionReference to add a new user
    try {
      await Firestore.instance
          .collection(Global.CHAT_ROOM)
          .document(userId)
          .collection("realtime_typing")
          .document("typing")
          .setData({"isAdminTyping": val}, merge: true);
      // return true;
    } catch (e) {
      // return false;
      print(e.toString());
    }
  }
}
