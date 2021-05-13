import '../../main_index.dart';

class CommonAppBar extends StatefulWidget {
  final String title;
  final bool isCenterTitle;
  final bool needDarkText;

  const CommonAppBar({
    Key key,
    this.title,
    this.isCenterTitle = true,
    this.needDarkText = false,
    // this.onLike,
  }) : super(key: key);

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  bool isLike = false;
  bool isLoadingLike = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          centerTitle: widget.isCenterTitle,
          backgroundColor: getIt<ThemeChange>().isDark ? BrandColors.dark1 : BrandColors.light,
          title: BrandTexts.titleBold(
            text: widget.title ?? "",
            color:
                getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark.withOpacity(widget.needDarkText ? 1.0 : 0.6),
            fontSize: 20.0,
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 8.0,
          child: InkWell(
            onTap: () => App.popOnce(context),
            child: App.svgImage(svg: LEFT_ARROW_SVG, height: 24.0, color: BrandColors.brandColorDark),
          ),
        ),
      ],
    );
  }
}
