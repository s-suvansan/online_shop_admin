import '../../main_index.dart';

class ProductInfoView extends StatelessWidget {
  final ProductModel productModel;

  const ProductInfoView({Key key, @required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductInfoViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: getIt<ThemeChange>().isDark ? BrandColors.dark1 : BrandColors.light,
        appBar: _AppBar(),
        body: Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              _TopImagesView(),
              _ContentView(),
            ],
          ),
        ),
        bottomNavigationBar: _BottomCallButton(),
      ),
      onModelReady: (model) => model.onInit(productModel),
      viewModelBuilder: () => ProductInfoViewModel(),
    );
  }
}

//app bar
class _AppBar extends ViewModelWidget<ProductInfoViewModel> implements PreferredSizeWidget {
  const _AppBar({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ProductInfoViewModel model) {
    return CommonAppBar(
      title: "${getIt<LanguageChange>().lang.productInfo}",
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// top image view
class _TopImagesView extends ViewModelWidget<ProductInfoViewModel> {
  @override
  Widget build(BuildContext context, ProductInfoViewModel model) {
    return Container(
        height: 220.0,
        color: getIt<ThemeChange>().isDark ? BrandColors.dark4 : BrandColors.shadowLight,
        child: Stack(
          children: [
            PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: model.pageController,
              itemCount: model.product.imageUrl?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => model.openFullImageView(context, index: index),
                  child: App.cacheImage(
                    model.product.imageUrl[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
              onPageChanged: (currentIndex) => model.onImageChange(index: currentIndex),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => model.onArrowClick(isForward: false),
                child: Container(
                  height: 40.0,
                  width: 25.0,
                  padding: EdgeInsets.only(right: 6.0),
                  decoration: BoxDecoration(
                      color: getIt<ThemeChange>().isDark ? BrandColors.dark2 : BrandColors.light,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 18.0,
                    color: BrandColors.shadow,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => model.onArrowClick(),
                child: Container(
                  height: 40.0,
                  width: 25.0,
                  padding: EdgeInsets.only(left: 6.0),
                  decoration: BoxDecoration(
                      color: getIt<ThemeChange>().isDark ? BrandColors.dark2 : BrandColors.light,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      )),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18.0,
                    color: BrandColors.shadow,
                  ),
                ),
              ),
            ),
            if (model.product.imageUrl.isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                      color: BrandColors.dark.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    alignment: Alignment.center,
                    width: 80.0,
                    height: 20.0,
                    child: ListView.separated(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.product.imageUrl.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, dotIndex) => Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dotIndex == model.currentImageIndex ? BrandColors.brandColorLight : BrandColors.light,
                        ),
                      ),
                      separatorBuilder: (context, i) => SizedBox(width: 4.0),
                    )),
              ),
          ],
        ));
  }
}

// content view
class _ContentView extends ViewModelWidget<ProductInfoViewModel> {
  const _ContentView({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ProductInfoViewModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      width: App.getDeviceWidth(context),
      color: getIt<ThemeChange>().isDark ? BrandColors.dark1 : BrandColors.light,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          BrandTexts.commonText(
              text: "${model.product.title}",
              fontSize: 24.0,
              fontWeight: BrandTexts.bold,
              maxLines: 3,
              color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark),
          SizedBox(height: 8.0),
          // posted time
          BrandTexts.caption(
            text: getIt<LanguageChange>()
                .lang
                .postedAt
                .replaceFirst("{}", "${App.showDateTimeInFormat(model.product.postAt, format: DateTimeFormat.DateAndTime)}"),
            color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark,
          ),
          if (model.product.postBy != "") SizedBox(height: 8.0),
          // posted by
          if (model.product.postBy != "")
            Row(
              children: [
                BrandTexts.caption(
                  text: getIt<LanguageChange>().lang.postedBy.replaceFirst("{}", "${model.product.postBy}"),
                  color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark,
                ),
                /*   BrandTexts.caption(
                  text: ", ${model.product.postFrom} ",
                  color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark,
                ), */
              ],
            ),

          SizedBox(height: 16.0),
          Divider(height: 0.0, color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark),
          SizedBox(height: 8.0),
          //price
          Row(
            children: [
              App.svgImage(svg: PRICE_TAG, height: 28.0, color: BrandColors.brandColorDark),
              SizedBox(width: 8.0),
              BrandTexts.commonText(
                text: "${App.getPrice(model.product.price)}",
                fontSize: 20.0,
                fontWeight: BrandTexts.black,
                color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark,
                maxLines: 3,
              ),
              SizedBox(width: 8.0),
              if (model.product.isNegotiable)
                BrandTexts.subTitleBold(
                  text: "${getIt<LanguageChange>().lang.negotiable}",
                  fontStyle: FontStyle.italic,
                  color: getIt<ThemeChange>().isDark ? BrandColors.dark5.withOpacity(0.5) : BrandColors.shadow,
                )
            ],
          ),
          SizedBox(height: 8.0),
          Divider(height: 0.0, color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark),
          SizedBox(height: 16.0),
          if (model.product.desc != "") _DescView(),
        ],
      ),
    );
  }
}

// desc
class _DescView extends ViewModelWidget<ProductInfoViewModel> {
  @override
  Widget build(BuildContext context, ProductInfoViewModel model) {
    return LayoutBuilder(builder: (context, size) {
      // for find the maxline of desc
      final span = TextSpan(text: model.product.desc);
      final tp = TextPainter(text: span, maxLines: 5, textDirection: TextDirection.ltr);
      tp.layout(maxWidth: size.maxWidth);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BrandTexts.titleBold(
            text: "${getIt<LanguageChange>().lang.desc}",
            color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
          ),
          SizedBox(height: 8.0),
          //description
          BrandTexts.titleBold(
            text: "${model.product.desc} ",
            color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadowDark,
            textAlign: TextAlign.justify,
            maxLines: model.showMore ? 100 : 5,
          ),
          SizedBox(height: 8.0),
          // show more and show less button
          if (tp.didExceedMaxLines)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => model.showMoreDesc(),
                  child: Container(
                    padding: EdgeInsets.only(right: 8.0, left: 2.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: getIt<ThemeChange>().isDark ? BrandColors.dark3 : BrandColors.shadowLight,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadow,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          model.showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadow,
                          size: 26.0,
                        ),
                        BrandTexts.subTitleBold(
                          text: model.showMore
                              ? "${getIt<LanguageChange>().lang.showLess}"
                              : "${getIt<LanguageChange>().lang.showMore}",
                          color: getIt<ThemeChange>().isDark ? BrandColors.dark5 : BrandColors.shadow,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 16.0),
        ],
      );
    });
  }
}

class _BottomCallButton extends ViewModelWidget<ProductInfoViewModel> {
  const _BottomCallButton({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, ProductInfoViewModel model) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => model.showPhoneNumbers(context, phoneNumber: Global.phoneNumberModel.normal),
            child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: BrandColors.callColor, borderRadius: BorderRadius.circular(5.0)),
              margin: EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  App.svgImage(svg: CALL, height: 18.0, color: BrandColors.light),
                  SizedBox(width: 8.0),
                  BrandTexts.titleBold(
                      text: "${getIt<LanguageChange>().lang.call}",
                      color: BrandColors.light,
                      fontSize: getIt<LanguageChange>().languageCode == Lang.English.code ? 18.0 : 16.0),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => model.showPhoneNumbers(context, phoneNumber: Global.phoneNumberModel.whatsApp, isCall: false),
            child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: BrandColors.whatsappColor, borderRadius: BorderRadius.circular(5.0)),
              margin: EdgeInsets.only(left: 8.0, right: 16.0, top: 8.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  App.svgImage(svg: WHATSAPP, height: 22.0, color: BrandColors.light),
                  SizedBox(width: 8.0),
                  BrandTexts.titleBold(
                      text: "${getIt<LanguageChange>().lang.whatsapp}",
                      color: BrandColors.light,
                      fontSize: getIt<LanguageChange>().languageCode == Lang.English.code ? 18.0 : 16.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
