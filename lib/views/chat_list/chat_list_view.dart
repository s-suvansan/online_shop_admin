import 'package:online_shop_admin/main_index.dart';

class ChatListView extends StatelessWidget {
  static const String routeName = "/chatlistview";
  const ChatListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatListViewModel>.nonReactive(
      builder: (context, model, _) => Scaffold(
        appBar: _AppBar(),
        body: _ChatList(),
      ),
      viewModelBuilder: () => ChatListViewModel(),
    );
  }
}

//app bar
class _AppBar extends ViewModelWidget<ChatListViewModel> implements PreferredSizeWidget {
  const _AppBar({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatListViewModel model) {
    return CommonAppBar(
      title: "Messages",
      isCenterTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ChatList extends ViewModelWidget<ChatListViewModel> {
  _ChatList({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatListViewModel model) {
    return StreamBuilder<QuerySnapshot>(
        stream: FireChatService.getChatsList(),
        builder: (context, snapshot) {
          model.getChatList(snapshot);
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            itemBuilder: (context, index) => _ChatListTile(
              key: UniqueKey(),
              chat: model.chatList[index],
            ),
            separatorBuilder: (_, __) => SizedBox(height: 8.0),
            itemCount: model?.chatList?.length ?? 0,
          );
        });
  }
}

class _ChatListTile extends ViewModelWidget<ChatListViewModel> {
  final ChatListModel chat;
  _ChatListTile({Key key, this.chat}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatListViewModel model) {
    return ListTile(
      onTap: () => model.openChatRoom(context, chat: chat),
      leading: CircleAvatar(
        child: BrandTexts.subTitleBold(text: chat.userName.substring(0, 1).toUpperCase()),
      ),
      title: BrandTexts.subTitleBold(text: chat.userName),
      subtitle: BrandTexts.commonText(text: chat.lastMessage, fontSize: 12.0, color: BrandColors.shadow),
      selected: true,
      selectedTileColor: BrandColors.brandColorLight.withOpacity(0.2),
    );
  }
}
