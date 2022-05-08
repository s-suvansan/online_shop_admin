import '../../main_index.dart';

class ChatView extends StatelessWidget {
  static const String routeName = "chatview";
  const ChatView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = App.getDeviceWidth(context);
    double _height = App.getDeviceHight(context);

    return ViewModelBuilder<ChatViewModel>.nonReactive(
      builder: (context, model, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: BrandColors.shadowLight,
        appBar: _AppBar(),
        body: Container(
          child: Stack(
            children: [
              // App.svgImage(
              //   svg: CHAT_BG_2,
              //   height: _height,
              //   // width: _width,
              //   // color: Colors.blueGrey,
              //   fit: BoxFit.cover,
              // ),
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Expanded(child: _ChatList(width: _width)),
                    _MessageBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: _MessageBox(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
      onModelReady: (model) => model.init(context),
      viewModelBuilder: () => ChatViewModel(),
    );
  }
}

//app bar
class _AppBar extends ViewModelWidget<ChatViewModel> implements PreferredSizeWidget {
  const _AppBar({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return CommonAppBar(
      title: "Chat",
      isCenterTitle: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ChatList extends ViewModelWidget<ChatViewModel> {
  final double width;
  const _ChatList({Key key, this.width}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FireChatService.getChats(userId: model.userId),
        builder: (context, snapshot) {
          model.getChatList(snapshot);
          return ListView.separated(
              reverse: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
              itemBuilder: (context, index) {
                return _ChatTile(
                  key: UniqueKey(),
                  width: width,
                  message: model?.messageList[index],
                  index: index,
                );
              },
              separatorBuilder: (ctx, i) => SizedBox(height: 8.0),
              itemCount: model?.messageList?.length ?? 0);
        });
  }
}

class _ChatTile extends ViewModelWidget<ChatViewModel> {
  final double width;
  final MessageModel message;
  final int index;
  const _ChatTile({Key key, this.width, this.message, this.index}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: message.isCustomer ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if (model.canShowDate(index)) _ChatDateTile(message: message),
        Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: message.isCustomer ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: width - 100.0),
                decoration: BoxDecoration(
                  color: message.isCustomer ? BrandColors.light : BrandColors.brandColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(message.isCustomer ? 0.0 : 12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(message.isCustomer ? 12.0 : 0.0),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                // margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(child: BrandTexts.commonText(text: "${message.message}", fontSize: 14.0, maxLines: 20)),
                        SizedBox(width: 8.0),
                        BrandTexts.caption(
                            text:
                                "${App.showDateTimeInFormat(message.dateTime, format: DateTimeFormat.Time, time: TimeFormat.LocalTime)}",
                            fontSize: 10.0)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChatDateTile extends ViewModelWidget<ChatViewModel> {
  final MessageModel message;
  const _ChatDateTile({Key key, this.message}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: BrandColors.dark.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: BrandTexts.caption(
                  text: "${App.showDateTimeInFormat(
                    message.dateTime,
                    date: DateFormat.NormalDate,
                  )}",
                  fontSize: 12.0,
                  color: BrandColors.light.withOpacity(0.8),
                  fontWeight: BrandTexts.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBox extends ViewModelWidget<ChatViewModel> {
  const _MessageBox({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<DocumentSnapshot>(
            stream: FireChatService.getIsTyping(userId: model.userId),
            builder: (context, snapshot) {
              //isTyping

              return (snapshot.hasData && snapshot?.data?.data != null && snapshot.data.data["isUserTyping"] == true)
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(20, 2, 2, 2),
                      child: BrandTexts.commonText(text: "typing...", fontSize: 11.0, maxLines: 8),
                    )
                  : SizedBox.shrink();
            }),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 2, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: BrandColors.light,
                    borderRadius: BorderRadius.circular(32.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        color: BrandColors.shadow.withOpacity(0.4),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: model.textEditingController,
                    decoration: InputDecoration(
                      hintText: "Message",
                      border: InputBorder.none,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    onChanged: (val) => model.onMessageType(val),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              GestureDetector(
                onTap: () => model.onSendMessage(),
                child: Container(
                  decoration: BoxDecoration(
                    color: BrandColors.light,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        color: BrandColors.shadow.withOpacity(0.4),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
