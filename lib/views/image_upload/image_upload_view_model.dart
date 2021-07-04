import 'package:online_shop_admin/main_index.dart';
import 'package:path/path.dart' as p;

class ImageUploadViewModel extends BaseViewModel {
  //variables
  List<String> _alreadyUploaedImages = <String>[];
  List<File> _imageFiles = new List<File>();
  List<String> _uploadedImages = List<String>();
  bool _isLoading = false;

  //getter
  List<String> get alreadyUploaedImages => _alreadyUploaedImages;
  List<File> get imageFiles => _imageFiles;
  bool get isLoading => _isLoading;

  //on init
  void onInit(BuildContext context) {
    ImageUploadArg arg = ModalRoute.of(context).settings.arguments;
    _alreadyUploaedImages.addAll(arg.alreadyUploadedImage);
  }

  // pick image from gallary
  Future<void> pickImages(BuildContext context) async {
    List<File> _files = await FilePicker.getMultiFile();
    if (_files != null) {
      _imageFiles.addAll(_files);
      notifyListeners();
    }
  }

  //upload files
  Future<void> uploadFiles(List<File> _images, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    showLoadingDialog(context);
    try {
      var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
      print(imageUrls);
      if (imageUrls != null && imageUrls.isNotEmpty) {
        _uploadedImages.clear();
        _uploadedImages = imageUrls;
        if (_alreadyUploaedImages != null && _alreadyUploaedImages.isNotEmpty) {
          _uploadedImages.addAll(_alreadyUploaedImages);
        }
        _isLoading = false;
        notifyListeners();
        App.popOnce(context);
        Navigator.pop(context, _uploadedImages);
      } else {
        App.popOnce(context);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      App.popOnce(context);
    }
  }

  //upload file
  Future<String> uploadFile(File _image) async {
    String basename = p.basename(_image.path);
    StorageReference storageReference = FirebaseStorage.instance.ref().child('images/$basename');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    return await storageReference.getDownloadURL();
  }

  //remove image
  void removeImage({@required int index}) {
    _imageFiles.removeAt(index);
    notifyListeners();
  }
}
