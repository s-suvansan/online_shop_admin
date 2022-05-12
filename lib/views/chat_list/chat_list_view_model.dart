import 'package:online_shop_admin/main_index.dart';

class ChatListViewModel extends BaseViewModel {
  //variable
  List<ChatListModel> _chatList = [];
  List<ChatListModel> get chatList => _chatList;

  // get chat list
  void getChatList(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData && snapshot.data.docs.length > 0) {
      _chatList = snapshot.data.docs.map((doc) {
        List<MessageModel> _msgList = [];
        doc.data().forEach((key, value) {
          // MessageModel _msg = MessageModel.fromJson(value);
          _msgList.add(MessageModel.fromJson(value));
        });
        _msgList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        return ChatListModel(
          userName: doc.id,
          userId: doc.id,
          lastMessage: _msgList[0].message,
          lastMessageTime: _msgList[0].dateTime,
        );
      }).toList();
      _chatList.sort((x, y) => y.lastMessageTime.compareTo(x.lastMessageTime));
      // print(snapshot);
      // notifyListeners();
    }
  }

  void openChatRoom(BuildContext context, {ChatListModel chat}) {
    Navigator.pushNamed(context, ChatView.routeName, arguments: chat);
  }

  // void getChatList(ChatChange value) {
  //   List<ChatListModel>
  // }
}

class ChatListModel {
  final String userId;
  final String userName;
  final String userImage;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final bool isLastMessageImage;

  ChatListModel({this.userId, this.userName, this.userImage, this.lastMessage, this.lastMessageTime, this.isLastMessageImage});

  factory ChatListModel.fromJson(Map<dynamic, dynamic> json) => ChatListModel(
        userId: json["userId"] ?? "",
        userName: json["userName"] ?? "",
        userImage: json["userImage"] ?? "",
        lastMessage: json["lastMessage"] ?? "",
        lastMessageTime: json["lastMessageTime"] ?? Timestamp.now(),
        isLastMessageImage: json["isLastMessageImage"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId ?? "",
        "userName": userName ?? "",
        "userImage": userImage ?? "",
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime,
        "isLastMessageImage": isLastMessageImage,
      };
}

class MessageModel {
  final String message;
  final String repliedMessage;
  final bool isCustomer;
  final Timestamp dateTime;
  final List<dynamic> images;
  final bool isRead;

  MessageModel({this.message, this.repliedMessage, this.isCustomer, this.dateTime, this.images, this.isRead});

  factory MessageModel.fromJson(Map<dynamic, dynamic> json) => MessageModel(
        message: json["message"] ?? "",
        repliedMessage: json["repliedMessage"] ?? "",
        isCustomer: json["isCustomer"] ?? false,
        dateTime: json["dateTime"],
        images: json["images"] ?? [],
        isRead: json["isRead"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "message": message ?? "",
        "repliedMessage": repliedMessage ?? "",
        "isCustomer": false,
        "dateTime": Timestamp.now(),
        "images": images ?? [],
        "isRead": isRead ?? false,
      };
}
