import 'dart:io';

import '../../main_index.dart';

class AddProductViewModel extends BaseViewModel {
  // variables
  bool _isNegotible = false;
  int _imageCount = 2;
  List<Asset> _images = <Asset>[];
  List<File> _imageFiles = new List<File>();

  // String _error = 'No Error Dectected';

  //getter
  bool get isNegitible => _isNegotible;
  int get imageCount => _imageCount;
  List<Asset> get images => _images;
  List<File> get imageFiles => imageFiles;
  //image selection function
  void loadAssets() async {
    List<Asset> _resultList = <Asset>[];
    try {
      _resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#FF9800",
          statusBarColor: "#EF6C00",
          actionBarTitle: "Image Gallary",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#FF9800",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    _images = _resultList;
    assetToFile(_resultList);
    // notifyListeners();
  }

  // Asset data type to  file
  assetToFile(List<Asset> images) async {
    if (images != null && images.isNotEmpty) {
      try {
        for (Asset asset in images) {
          ByteData byteData = await asset.getByteData();
          File imageFile = File.fromRawPath(byteData.buffer.asUint8List());

          _imageFiles.add(imageFile);
        }
        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // change is negotible
  void changeIsNegotible() {
    _isNegotible = !isNegitible;
    notifyListeners();
  }

  //remove image
  void removeImage({@required int index}) {}
}
