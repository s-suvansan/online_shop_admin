import '../../main_index.dart';

class PhoneNumberList extends StatelessWidget {
  final List<String> phnNumbers;
  final bool isCall;

  PhoneNumberList({this.phnNumbers, this.isCall = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: App.getDeviceWidth(context) - 100.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: getIt<ThemeChange>().isDark ? BrandColors.dark4 : BrandColors.light,
              boxShadow: [
                BoxShadow(
                  color: getIt<ThemeChange>().isDark ? BrandColors.light.withOpacity(0.1) : BrandColors.dark.withOpacity(0.1),
                  spreadRadius: 1.0,
                  offset: Offset.zero,
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BrandTexts.subTitleBold(
                            text: "${getIt<LanguageChange>().lang.selectNumber}",
                            color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                            fontSize: getIt<LanguageChange>().languageCode == Lang.English.code ? 14.0 : 12.0,
                            maxLines: 2),
                      ),
                      SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () => App.popOnce(context),
                        child: Icon(
                          Icons.cancel_sharp,
                          size: 20.0,
                          color: BrandColors.shadowDark,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                ),
                SizedBox(height: 8.0),
                Column(
                  children: phnNumbers
                      .map(
                        (number) => GestureDetector(
                          onTap: () => _popPhoneNumberList(context, number: number),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            color: BrandColors.glass,
                            child: Row(
                              children: [
                                isCall
                                    ? App.svgImage(
                                        svg: CALL,
                                        height: 18.0,
                                        color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                                      )
                                    : App.svgImage(
                                        svg: WHATSAPP,
                                        height: 18.0,
                                        color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                                      ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                BrandTexts.subTitleBold(
                                  text: number,
                                  color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // pop with valur
  void _popPhoneNumberList(BuildContext context, {@required String number}) {
    Navigator.of(context).pop(number);
  }
}
