import '../../main_index.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color loaderColor;
  final double bgSize;
  final Color bgColor;
  final bool needBg;
  final double strokeWidth;

  const Loading({
    Key key,
    this.size,
    this.loaderColor,
    this.bgSize,
    this.bgColor,
    this.needBg = false,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChange>(builder: (context, value, child) {
      return Container(
        height: bgSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: needBg
              ? (bgColor ?? getIt<ThemeChange>().isDark ? BrandColors.dark2 : BrandColors.light.withOpacity(0.8))
              : BrandColors.glass,
        ),
        alignment: Alignment.center,
        child: SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(loaderColor ?? BrandColors.brandColorDark),
          ),
        ),
      );
    });
  }
}
