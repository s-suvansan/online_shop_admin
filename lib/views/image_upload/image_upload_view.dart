import '../../main_index.dart';

class ImageUploadView extends StatelessWidget {
  static const routeName = "image_upload_view";
  const ImageUploadView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImageUploadViewModel>.nonReactive(
      builder: (context, model, _) => SafeArea(
          child: Scaffold(
        appBar: _AppBar(),
        body: _Body(),
        bottomNavigationBar: _CommonButton(),
      )),
      onModelReady: (model) => model.onInit(context),
      viewModelBuilder: () => ImageUploadViewModel(),
    );
  }
}

//app bar
class _AppBar extends ViewModelWidget<ImageUploadViewModel> implements PreferredSizeWidget {
  _AppBar() : super(reactive: false);

  @override
  Widget build(BuildContext context, ImageUploadViewModel model) {
    return AppBar(
      centerTitle: true,
      backgroundColor: BrandColors.brandColor,
      elevation: 0.0,
      title: BrandTexts.commonText(text: "Add Images", fontSize: 20.0, fontWeight: BrandTexts.black, color: BrandColors.light),
      leading: InkWell(
        onTap: () => App.popOnce(context),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: BrandColors.light,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

//body
class _Body extends ViewModelWidget<ImageUploadViewModel> {
  @override
  Widget build(BuildContext context, ImageUploadViewModel model) {
    return Column(
      children: [
        if (model.alreadyUploaedImages != null && model.alreadyUploaedImages.isNotEmpty) _ImageBar(),
        if (model.alreadyUploaedImages != null && model.alreadyUploaedImages.isNotEmpty) SizedBox(height: 16.0),
        Container(
          // height: 120.0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: BrandColors.dark.withOpacity(0.1),
              ),
              padding: EdgeInsets.all(4.0),
              child: (index != model.imageFiles.length)
                  ? Stack(
                      // fit: StackFit.expand,
                      children: [
                        /* AssetThumb(
                            asset: model.images[index],
                            width: 300,
                            height: 300,
                          ), */
                        Image.file(
                          model.imageFiles[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            right: 4.0,
                            top: 4.0,
                            child: InkWell(
                              onTap: () => model.removeImage(index: index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: BrandColors.brandColorDark,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 20.0,
                                  color: BrandColors.light,
                                ),
                              ),
                            )),
                      ],
                    )
                  : InkWell(
                      onTap: () => model.pickImages(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        color: BrandColors.shadowLight,
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 30.0,
                        ),
                      ),
                    ),
            ),
            separatorBuilder: (_, __) => SizedBox(
              height: 8.0,
            ),
            itemCount: (model.imageFiles?.length ?? 0) + 1,
          ),
        ),
      ],
    );
  }
}

//image bar list
class _ImageBar extends ViewModelWidget<ImageUploadViewModel> {
  @override
  Widget build(BuildContext context, ImageUploadViewModel model) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BrandTexts.title(text: "Already Uploaded Images"),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            height: 120.0,
            child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: BrandColors.dark.withOpacity(0.1),
                  ),
                  padding: EdgeInsets.all(4.0),
                  child: Image.network(
                    model.alreadyUploaedImages[index],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )),
              separatorBuilder: (_, __) => SizedBox(
                width: 8.0,
              ),
              itemCount: (model.alreadyUploaedImages?.length ?? 0),
            ),
          )
        ],
      ),
    );
  }
}

class _CommonButton extends ViewModelWidget<ImageUploadViewModel> {
  @override
  Widget build(BuildContext context, ImageUploadViewModel model) {
    return GestureDetector(
      onTap: () => model.uploadFiles(model.imageFiles, context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        height: 50.0,
        decoration: BoxDecoration(color: BrandColors.brandColor, borderRadius: BorderRadius.circular(5.0)),
        alignment: Alignment.center,
        child: !model.isLoading
            ? BrandTexts.titleBold(text: "Add Images", color: BrandColors.light)
            : SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(BrandColors.light),
                ),
              ),
      ),
    );
  }
}
