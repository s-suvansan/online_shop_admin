import '../../main_index.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      builder: (context, model, _) => _Body(),
      onModelReady: (model) => model.onInit(context),
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}

// body
class _Body extends ViewModelWidget<SplashViewModel> {
  @override
  Widget build(BuildContext context, SplashViewModel model) {
    return Container(
      color: !model.isNoInternet ? BrandColors.dark : BrandColors.light,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !model.isNoInternet
              ? Expanded(
                  child: Container(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            APP_LOGO,
                            height: 120,
                            width: 120,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            APP_NAME,
                            // width: 180,
                            height: 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : _NoInternet(),
        ],
      ),
    );
  }
}

//no internet widget
class _NoInternet extends ViewModelWidget<SplashViewModel> {
  const _NoInternet({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SplashViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: Image.asset(
            NO_INRETNET,
            height: 160.0,
            width: 160.0,
          ),
        ),
        SizedBox(height: 20.0),
        BrandTexts.titleBold(text: "${getIt<LanguageChange>().lang.noNetConnection}", color: BrandColors.shadowDark),
        SizedBox(height: 20.0),
        OutlineButton(
          onPressed: () => model.checkConnection(context),
          color: BrandColors.brandColorDark,
          hoverColor: BrandColors.brandColorLight,
          borderSide: BorderSide(color: BrandColors.brandColorDark, style: BorderStyle.solid, width: 2),
          child: BrandTexts.titleBold(text: "${getIt<LanguageChange>().lang.retry}"),
        )
      ],
    );
  }
}
