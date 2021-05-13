import '../../main_index.dart';

class BookmarkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookmarkViewModel>.nonReactive(
      builder: (context, model, child) => _FavouriteList(),
      onModelReady: (model) => model.onInit(),
      viewModelBuilder: () => BookmarkViewModel(),
    );
  }
}

class _FavouriteList extends ViewModelWidget<BookmarkViewModel> {
  _FavouriteList({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, BookmarkViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
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
            return !model.isLoading
                ? model.product.isNotEmpty
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: model.product.length,
                        itemBuilder: (context, index) => GestureDetector(
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
                        separatorBuilder: (context, i) => SizedBox(height: 8.0),
                      )
                    : Empty(
                        image: EMPTY_MAN,
                        size: 150.0,
                        moveFromTopBy: 180.0,
                        isFav: true,
                      )
                : Center(
                    child: Loading(
                      needBg: true,
                      size: 20.0,
                      bgSize: 40.0,
                    ),
                  );
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
    return Consumer<ThemeChange>(builder: (context, value, child) {
      return Consumer<LanguageChange>(builder: (context, value, child) {
        return Container(
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
                        : "",
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
