import '../../main_index.dart';

class Empty extends StatelessWidget {
  final String image;
  final double size;
  final double moveFromTopBy;
  final bool isFav;

  const Empty({
    Key key,
    this.image,
    this.size = 200.0,
    this.moveFromTopBy = 0.0,
    this.isFav = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: moveFromTopBy),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: getIt<ThemeChange>().isDark ? BrandColors.dark3 : BrandColors.shadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                EMPTY_VELU,
                width: size,
                height: size,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          BrandTexts.titleBold(
            text: isFav ? getIt<LanguageChange>().lang.emptyFavList : getIt<LanguageChange>().lang.emptyProductList,
            fontWeight: BrandTexts.black,
            maxLines: 2,
            fontSize: getIt<LanguageChange>().languageCode == Lang.English.code ? 18.0 : 16.0,
            color: getIt<ThemeChange>().isDark ? BrandColors.shadowLight : BrandColors.shadowDark,
          )
        ],
      ),
    );
  }
}
