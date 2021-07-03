import 'package:online_shop_admin/views/add_product/add_product_arg.dart';

import '../../main_index.dart';

class BookmarkViewModel extends BaseViewModel {
  //variables
  List<ProductModel> _product = List<ProductModel>();
  bool _isLoading = false;

  //getter
  List<ProductModel> get product => _product;
  bool get isLoading => _isLoading;

  // on init function
  onInit() {
    _isLoading = true;
    // notifyListeners();
  }

  // get product details
  void getProductDetails(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData && snapshot.data.documents.length >= 0) {
      _product = List<ProductModel>.from(snapshot.data.documents.map((x) => ProductModel.fromJson(x.data)));
    }
    _isLoading = false;
  }

  // open product info view
  void openProductInfo(BuildContext context, Widget widget) {
    App.checkConnection(context).then((value) {
      if (value) {
        App.showBottomPopup(context, widget, reduceHeightBy: 25.0);
      }
    });
  }

  openAddProduct(BuildContext context, {bool isEdit = false, ProductModel productModel}) {
    Navigator.pushNamed(context, AddProductView.routeName,
        arguments: AddProductArg(
          isEdit: isEdit,
          productModel: productModel,
        ));
  }

  deleteProduct(BuildContext context, {int index}) {
    App.showCommonPopup(
        context,
        CommonPopup(
          desc: "Do you want to delete this product?",
        )).then((value) {
      if (value) {
        _isLoading = true;
        deleteImages(index).then((value) {
          try {
            Firestore.instance.collection(Global.PRODUCTS).document("${_product[index].id}").delete();
            _isLoading = false;
          } catch (e) {
            _isLoading = false;
          }
        });
      }
    });
  }

  Future<bool> deleteImages(int index) async {
    bool _value = false;
    if (_product[index].imageUrl != null && _product[index].imageUrl.isNotEmpty) {
      _product[index].imageUrl.forEach((url) async {
        StorageReference ref = await FirebaseStorage.instance.getReferenceFromUrl(url);
        if (ref != null) {
          try {
            await FirebaseStorage.instance.ref().child(ref.path).delete();
            _value = true;
          } catch (e) {
            _value = false;
          }
        } else {
          _value = false;
        }
      });
    }
    return _value;
  }
}
