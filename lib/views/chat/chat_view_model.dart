import 'dart:async';

import '../../main_index.dart';

class ChatViewModel extends BaseViewModel {
  //variables
  String _message = "";

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  List<MessageModel> _messageList = [];
  List<MessageModel> get messageList => _messageList;

  String _userId = "";
  String get userId => _userId;

  void init(BuildContext context) {
    ChatListModel _args = ModalRoute.of(context).settings.arguments;
    _userId = _args?.userId ?? "";
  }

  void getChatList(AsyncSnapshot<DocumentSnapshot> snapshot) {
    // print(snapshot);
    try {
      if (snapshot.hasData && snapshot?.data?.data() != null && snapshot.data.data().length >= 0) {
        // var data = snapshot.data;
        List<MessageModel> _msgList = [];
        snapshot.data.data().forEach((key, value) {
          // MessageModel _msg = MessageModel.fromJson(value);
          _msgList.add(MessageModel.fromJson(value));
        });
        _messageList = _msgList;
        _messageList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
      // _messageList = List<MessageModel>.from(snapshot.data.data.map((key, value) => MessageModel.fromJson(value)));
    } catch (e) {
      print(e.toString());
    }
  }

  // MessageModel.fromJson(val)
  bool _isTyping = false;
  final _debouncer = Debouncer(milliseconds: 2000);

  void onMessageType(String msg) {
    _message = msg;

    if (msg.isNotEmpty && !_isTyping) {
      _isTyping = true;
      FireChatService.setIsTyping(_isTyping, userId: _userId);
    }

    _debouncer.run(
      () {
        if (_isTyping) {
          _isTyping = false;
          FireChatService.setIsTyping(_isTyping, userId: _userId);
          print(msg);
        }
      },
    );
  }

  void onSendMessage() {
    if (_message != null && _message != "") {
      FireChatService.sentMessage(MessageModel(message: _message), userId: _userId).then((value) {
        if (value) {
          _message = "";
          _textEditingController.clear();
          if (_isTyping) {
            _isTyping = false;
            FireChatService.setIsTyping(_isTyping, userId: _userId);
          }
        }
      });
    }
  }

  bool canShowDate(int index) {
    try {
      var _nextIndex = (index + 1);
      if ((_nextIndex < _messageList.length &&
              _messageList[index].dateTime.toDate().day != _messageList[_nextIndex].dateTime.toDate().day) ||
          index == _messageList.length - 1) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool checkWhoSentNextMessage(int index, {bool bellowDateTile = false}) {
    try {
      var _nextIndex = (index + 1);
      if (!bellowDateTile &&
          _nextIndex < _messageList.length &&
          _messageList[index].isCustomer == _messageList[_nextIndex].isCustomer) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
