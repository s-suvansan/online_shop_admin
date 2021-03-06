import 'package:flutter_slidable/flutter_slidable.dart';

import '../../main_index.dart';

class BookmarkView extends StatelessWidget {
  static const routeName = "/bookmarkAsMain";
  @override
  Widget build(BuildContext context) {
    getIt<ScrollChange>().setStatusBarHeight = MediaQuery.of(context).padding.top;
    return ViewModelBuilder<BookmarkViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: BrandColors.shadowLight,
        appBar: _AppBar(),
        body: _FavouriteList(),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: "message",
              backgroundColor: BrandColors.brandColorDark,
              child: Icon(Icons.message, color: BrandColors.light),
              onPressed: () => model.openChatList(context),
            ),
            SizedBox(height: 12.0),
            FloatingActionButton.extended(
              heroTag: "addProduct",
              backgroundColor: BrandColors.brandColorDark,
              onPressed: () => model.openAddProduct(context),
              label: Row(
                children: [
                  Icon(Icons.add, color: BrandColors.light),
                  BrandTexts.titleBold(text: "ADD", color: BrandColors.light),
                ],
              ),
            ),
          ],
        ),
      ),
      onModelReady: (model) => model.onInit(),
      viewModelBuilder: () => BookmarkViewModel(),
    );
  }
}

//app bar
class _AppBar extends ViewModelWidget<BookmarkViewModel> implements PreferredSizeWidget {
  _AppBar() : super(reactive: false);

  @override
  Widget build(BuildContext context, BookmarkViewModel model) {
    return AppBar(
      centerTitle: true,
      backgroundColor: BrandColors.brandColor,
      elevation: 0.0,
      title: BrandTexts.commonText(
          text: Global.APP_NAME,
          fontSize: 20.0,
          fontWeight: BrandTexts.black,
          fontFamily: BrandTexts.logoFont,
          color: BrandColors.light),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FavouriteList extends ViewModelWidget<BookmarkViewModel> {
  _FavouriteList({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, BookmarkViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: FireStoreService.getProducts(),
          builder: (context, snapshot) {
            model.getProductDetails(snapshot);
            if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done)
              return model.product.isNotEmpty
                  ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: model.product.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => model.openProductInfo(
                          context,
                          ProductInfoView(
                            productModel: model.product[index],
                          ),
                        ),
                        child: _FavouriteListTile(
                          key: UniqueKey(),
                          index: index,
                        ),
                      ),
                      separatorBuilder: (_, i) => SizedBox(height: 8.0),
                    )
                  : Empty(
                      image: EMPTY_MAN,
                      size: 150.0,
                      moveFromTopBy: 0.0,
                    );
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: Loading(
                  needBg: true,
                  size: 20.0,
                  bgSize: 40.0,
                ),
              );
            else
              return SizedBox.shrink();
          }),
    );
  }
}

class _FavouriteListTile extends ViewModelWidget<BookmarkViewModel> {
  final int index;
  // final ProductModel product;

  _FavouriteListTile({Key key, @required this.index}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, BookmarkViewModel model) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () => model.openAddProduct(context, isEdit: true, productModel: model.product[index]),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => model.deleteProduct(context, index: index),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
            color: getIt<ThemeChange>().isDark ? BrandColors.dark3 : BrandColors.light,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                color: BrandColors.shadow.withOpacity(0.1),
                spreadRadius: 0.5,
                offset: Offset.zero,
                blurRadius: 2.0,
              ),
            ]),
        width: App.getDeviceWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        height: 110.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: BrandTexts.commonText(
                          text: "${model.product[index].title}",
                          color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                          maxLines: 1,
                          fontSize: 16.0,
                          fontWeight: BrandTexts.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  BrandTexts.caption(
                    text: "${model.product[index].desc}",
                    color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BrandTexts.subTitleBold(
                        text: "${App.getPrice(model.product[index].price)}",
                        color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                      ),
                      BrandTexts.caption(
                        text: "${App.getTime(model.product[index].postAt)}",
                        color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                        fontSize: getIt<LanguageChange>().languageCode == Lang.English.code ? 12.0 : 10.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Container(
                width: 90.0,
                height: 90.0,
                child: App.cacheImage(
                  (model.product[index].imageUrl != null && model.product[index].imageUrl.isNotEmpty)
                      ? model.product[index].imageUrl[0]
                      : NO_IMAGE,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
