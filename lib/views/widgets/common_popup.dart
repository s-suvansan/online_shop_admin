import '../../main_index.dart';

class CommonPopup extends StatelessWidget {
  final String text;
  final String desc;
  final bool needDoubleButton;
  final String yesText;
  final String noText;
  final String okText;

  const CommonPopup({
    Key key,
    this.text = "",
    this.desc = "",
    this.needDoubleButton = true,
    this.yesText,
    this.noText,
    this.okText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
              color: BrandColors.light,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 52.0),
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                if (text != null && text != "")
                  BrandTexts.commonText(
                    text: text,
                    fontSize: 16.0,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    fontWeight: BrandTexts.bold,
                    letterSpacing: 0.5,
                  ),
                /*  if (text != null && text != "")
                  Divider(
                    color: BrandColors.shadow,
                  ), */
                if (text != null && text != "") SizedBox(height: 16.0),
                if (desc != null && desc != "")
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: BrandTexts.commonText(
                      text: desc,
                      fontSize: 16.0,
                      maxLines: 50,
                      textAlign: TextAlign.center,
                      letterSpacing: 0.5,
                    ),
                  ),
                if (desc != null && desc != "") SizedBox(height: 8.0),
                Divider(color: BrandColors.shadow),
                needDoubleButton ? _doubleButton(context) : _singleButton(context),
              ],
            )),
      ],
    );
  }

  Widget _doubleButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: BrandTexts.titleBold(
              text: yesText ?? "Yes",
              maxLines: 2,
              color: BrandColors.brandColorDark,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
            height: 20.0,
            child: VerticalDivider(
              color: BrandColors.shadow,
            )),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: BrandTexts.titleBold(
              text: noText ?? "No",
              maxLines: 2,
              color: BrandColors.brandColorDark,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _singleButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: BrandTexts.titleBold(
              text: okText ?? "OK",
              maxLines: 2,
              color: BrandColors.brandColorDark,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
