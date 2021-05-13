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
}
