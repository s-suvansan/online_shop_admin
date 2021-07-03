import 'dart:io';

import '../../main_index.dart';

class AddProductViewModel extends BaseViewModel {
  // variables
  bool _isNegotible = false;
  int _imageCount = 2;
  List<File> _images = <File>[];
  // List<File> _imageFiles = new List<File>();

  // String _error = 'No Error Dectected';

  //getter
  bool get isNegitible => _isNegotible;
  int get imageCount => _imageCount;
  List<File> get images => _images;
  // List<File> get imageFiles => imageFiles;

  // change is negotible
  void changeIsNegotible() {
    _isNegotible = !isNegitible;
    notifyListeners();
  }

  //remove image
  void removeImage({@required int index}) {}
}
