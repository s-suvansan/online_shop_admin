import 'package:online_shop_admin/views/add_product/add_product_arg.dart';

import '../../main_index.dart';

class AddProductViewModel extends BaseViewModel {
  // variables
  bool _isNegotible = false;
  List<String> _images = <String>[];
  ProductModel _productModel = ProductModel();
  bool _isLoading = false;
  AddProductArg _arg;
  AddProductArg get arg => this._arg;

  //getter
  bool get isNegitible => _isNegotible;
  List<String> get images => _images;
  ProductModel get productModel => _productModel;
  bool get isLoading => _isLoading;

  //on init
  void onInit(BuildContext context) {
    _arg = ModalRoute.of(context).settings.arguments;
    if (_arg.isEdit) {
      _productModel = _arg.productModel;
      _images = _arg?.productModel?.imageUrl ?? [];
      _isNegotible = _arg?.productModel?.isNegotiable ?? false;
    }
  }

  // change is negotible
  void changeIsNegotible() {
    _isNegotible = !isNegitible;
    notifyListeners();
  }

  //navigate to image upload view
  void navigateToImageUploadView(context) {
    Navigator.of(context)
        .pushNamed(ImageUploadView.routeName, arguments: ImageUploadArg(alreadyUploadedImage: _images))
        .then((value) {
      if (value != null) {
        _images = value;
        notifyListeners();
      }
    });
  }

  //remove image
  removeAlreadyAddedImageImage(BuildContext context, {int index}) async {
    // if (_images.length > 1) {
    App.showCommonPopup(
        context,
        CommonPopup(
          desc: "Do you want to delete this image?",
        )).then((value) {
      if (value) {
        showLoadingDialog(context);

        Reference ref = FirebaseStorage.instance.refFromURL(_images[index]);
        if (ref != null) {
          FirebaseStorage.instance.ref().child(ref.fullPath).delete().then((_) {
            FireStoreService.removeImageUrl(docId: _productModel.id, imageUrl: _images[index]).then((value) {
              _images.removeAt(index);
              notifyListeners();
              App.popOnce(context);
            });
          });
        }
      }
    });
    // } else {
    //   App.showInfoBar(context, msg: "புண்ட ஒரு image ஆவது கட்டயம் இருக்கோணும்.", bgColor: BrandColors.dangers);
    // }
  }

  void addProduct(BuildContext context) {
    _productModel.id = _arg.isEdit ? _arg.productModel.id : App.getRandomString(20);
    _productModel.imageUrl = _images;
    _productModel.isNegotiable = isNegitible;
    if (_productModel?.title != null &&
        _productModel.title != "" &&
        _productModel?.desc != null &&
        _productModel.desc != "" &&
        _productModel?.price != null &&
        _productModel.price != "" &&
        _images != null &&
        _images.isNotEmpty) {
      showLoadingDialog(context);
      _isLoading = true;
      notifyListeners();
      FireStoreService.addProduct(_productModel, isEdit: _arg.isEdit).then((value) {
        if (value) {
          _isLoading = false;
          notifyListeners();
          App.popOnce(context);
          App.popOnce(context);
        } else {
          App.popOnce(context);
        }
      });
    } else {
      _isLoading = false;
      notifyListeners();
      App.showInfoBar(context, msg: "வடிவா check பண்ணுடா புண்ட, ஒரு image ஆவது கட்டயம் குடு.", bgColor: BrandColors.dangers);
    }
  }

  onTextChange(String val, ProductInfo productInfo) {
    switch (productInfo) {
      case ProductInfo.Title:
        _productModel.title = val;
        break;
      case ProductInfo.Price:
        _productModel.price = val;
        break;
      case ProductInfo.Desc:
        _productModel.desc = val;
        break;
      case ProductInfo.PostBy:
        _productModel.postBy = val;
        break;
      default:
    }
  }
}
