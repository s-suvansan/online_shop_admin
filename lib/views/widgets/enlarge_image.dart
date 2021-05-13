import '../../main_index.dart';

class ImageViewer extends StatefulWidget {
  static const routeName = "imageFullView";
  final List<String> images;
  final List<String> thumbnail;
  final int viewedIndex;
  ImageViewer({@required this.images, this.thumbnail, this.viewedIndex: 0});

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  List<dynamic> images, thumbnail;
  int activeImage = 0;
  static double bottemImageHeight = 60.0;
  static double closeScreenHeight = 20.0;
  double thumnailImageListWidth = 0.0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    images = widget.images == null ? [] : widget.images;
    thumbnail = widget.thumbnail == null ? images : widget.thumbnail;
    // setState(() {
    activeImage = widget.viewedIndex;
    // });
    Future.delayed(const Duration(milliseconds: 10), () {
      _pageController.jumpToPage(
        widget.viewedIndex,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: getIt<ThemeChange>().isDark ? BrandColors.dark3 : BrandColors.shadowLight,
          // height: App.getDeviceHight(context),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  if (images.isNotEmpty)
                    Container(
                        height: App.getDeviceHight(context) - (closeScreenHeight * 1.5 + (8 + bottemImageHeight)),
                        width: App.getDeviceWidth(context),
                        child: PhotoViewGallery.builder(
                          backgroundDecoration:
                              BoxDecoration(color: getIt<ThemeChange>().isDark ? BrandColors.dark3 : BrandColors.shadowLight),
                          scrollPhysics: const BouncingScrollPhysics(),
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                              minScale: PhotoViewComputedScale.contained / 3,
                              filterQuality: FilterQuality.high,
                              imageProvider: NetworkImage(images[index] ?? NO_IMAGE),
                              initialScale: PhotoViewComputedScale.contained * 1,
                            );
                          },
                          pageController: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              activeImage = index;
                            });
                          },
                          itemCount: images.length,
                          loadingBuilder: (context, event) => Center(
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              child: CircularProgressIndicator(
                                value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                              ),
                            ),
                          ),
                        )),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () => App.popOnce(context),
                            child: CircleAvatar(
                              backgroundColor: getIt<ThemeChange>().isDark ? BrandColors.dark3 : BrandColors.shadowLight,
                              radius: 15,
                              child: Icon(
                                Icons.close,
                                color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                                size: 25,
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),

              // SizedBox(
              //   height: 5,
              // ),
              if (thumbnail.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: bottemImageHeight,
                  alignment: Alignment.center,
                  width: App.getDeviceWidth(context),
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: thumbnail.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                            padding: EdgeInsets.only(left: index == thumbnail.length ? 0.0 : 5.0),
                            child: GestureDetector(
                              onTap: () => _pageController.jumpToPage(index),
                              child: Container(
                                height: bottemImageHeight, //bottemImageHeight
                                width: bottemImageHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(
                                      color: activeImage == index
                                          ? BrandColors.brandColor
                                          : getIt<ThemeChange>().isDark
                                              ? BrandColors.light
                                              : BrandColors.dark,
                                      width: activeImage == index ? 2.0 : 1.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      thumbnail[index] ?? NO_IMAGE,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
