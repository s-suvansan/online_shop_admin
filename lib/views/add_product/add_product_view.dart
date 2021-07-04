import 'package:flutter_hooks/flutter_hooks.dart';

import '../../main_index.dart';

class AddProductView extends StatelessWidget {
  static const routeName = "/add_product_view";
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProductViewModel>.nonReactive(
        builder: (context, model, _) {
          return SafeArea(
              child: Scaffold(
            appBar: _AppBar(),
            body: _BodyPart(),
            bottomNavigationBar: _CommonButton(),
          ));
        },
        onModelReady: (model) => model.onInit(context),
        viewModelBuilder: () => AddProductViewModel());
  }
}

//app bar
class _AppBar extends ViewModelWidget<AddProductViewModel> implements PreferredSizeWidget {
  _AppBar() : super(reactive: false);

  @override
  Widget build(BuildContext context, AddProductViewModel model) {
    return AppBar(
      centerTitle: true,
      backgroundColor: BrandColors.brandColor,
      elevation: 0.0,
      title: BrandTexts.commonText(
          text: model.arg.isEdit ? "Edit Product" : "Add Product",
          fontSize: 20.0,
          fontWeight: BrandTexts.black,
          color: BrandColors.light),
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

class _BodyPart extends ViewModelWidget<AddProductViewModel> {
  @override
  Widget build(BuildContext context, AddProductViewModel model) {
    return Container(
      child: Form(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            _CommonTextBox(
              hint: "Title",
              helperText: "Type product title here.",
              productInfo: ProductInfo.Title,
              initValue: model.productModel.title,
            ),
            SizedBox(height: 16.0),
            _CommonTextBox(
              hint: "Price",
              inputType: TextFeildInputType.Number,
              helperText: "Type product price here.",
              productInfo: ProductInfo.Price,
              initValue: model.productModel.price,
            ),
            SizedBox(height: 16.0),
            _CommonTextBox(
              hint: "Description",
              inputType: TextFeildInputType.MultiLine,
              helperText: "Type product description here.",
              productInfo: ProductInfo.Desc,
              initValue: model.productModel.desc,
            ),
            SizedBox(height: 16.0),
            _CommonTextBox(
              hint: "Post By (optional)",
              helperText: "Type name who post the product.",
              productInfo: ProductInfo.PostBy,
              initValue: model.productModel.postBy,
            ),
            SizedBox(height: 16.0),
            _NegotibelCheckBox(),
            SizedBox(height: 16.0),
            _ImageBar()
          ],
        ),
      ),
    );
  }
}

// negotible checkbox
class _NegotibelCheckBox extends ViewModelWidget<AddProductViewModel> {
  @override
  Widget build(BuildContext context, AddProductViewModel model) {
    return InkWell(
      onTap: () => model.changeIsNegotible(),
      child: Row(
        children: [
          Icon(
            !model.isNegitible ? Icons.check_box_outline_blank_rounded : Icons.check_box_rounded,
            size: 28.0,
            color: BrandColors.shadowDark,
          ),
          SizedBox(width: 8.0),
          BrandTexts.title(text: "Negotible"),
        ],
      ),
    );
  }
}

//image bar list
class _ImageBar extends ViewModelWidget<AddProductViewModel> {
  @override
  Widget build(BuildContext context, AddProductViewModel model) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BrandTexts.title(text: "Add Images to Products"),
              InkWell(
                onTap: () => model.navigateToImageUploadView(context),
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: BrandColors.brandColorDark,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 30.0,
                    color: BrandColors.light,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
              itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: BrandColors.dark.withOpacity(0.1),
                  ),
                  padding: EdgeInsets.all(4.0),
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      Image.network(
                        model.images[index],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          right: 4.0,
                          top: 4.0,
                          child: InkWell(
                            onTap: () => model.removeAlreadyAddedImageImage(context, index: index),
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
                  )),
              itemCount: (model.images?.length ?? 0),
            ),
          )
        ],
      ),
    );
  }
}

//common textfeild
class _CommonTextBox extends HookViewModelWidget<AddProductViewModel> {
  final String hint;
  final String initValue;
  final String helperText;
  final TextFeildInputType inputType;
  final ProductInfo productInfo;

  _CommonTextBox({
    this.hint = "Title",
    this.initValue = "",
    this.helperText = "",
    this.inputType = TextFeildInputType.Text,
    @required this.productInfo,
  });

  @override
  Widget buildViewModelWidget(BuildContext context, AddProductViewModel model) {
    var textEditingController = useTextEditingController(text: initValue ?? "");
    return TextFormField(
      controller: textEditingController,
      maxLines: (inputType == TextFeildInputType.MultiLine) ? 5 : 1,
      maxLength: (inputType == TextFeildInputType.MultiLine) ? 500 : null,
      keyboardType: (inputType == TextFeildInputType.Number)
          ? TextInputType.number
          : (inputType == TextFeildInputType.MultiLine)
              ? TextInputType.multiline
              : TextInputType.text,
      style: BrandTexts.textStyle(fontWeight: BrandTexts.bold),
      onChanged: (val) => model.onTextChange(val, productInfo),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: BrandTexts.textStyle(),
        filled: true,
        border: _border(),
        errorBorder: _border(),
        focusedBorder: _border(),
        enabledBorder: _border(),
        focusedErrorBorder: _border(),
        disabledBorder: _border(),
        helperText: helperText,
        helperMaxLines: 1,
        helperStyle: BrandTexts.textStyle(fontSize: 12.0),
      ),
    );
  }

  static OutlineInputBorder _border() => OutlineInputBorder(
          borderSide: BorderSide(
        color: BrandColors.shadow,
        width: 2.0,
      ));
}

class _CommonButton extends ViewModelWidget<AddProductViewModel> {
  @override
  Widget build(BuildContext context, AddProductViewModel model) {
    return GestureDetector(
      onTap: () => model.addProduct(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        height: 50.0,
        decoration: BoxDecoration(color: BrandColors.brandColor, borderRadius: BorderRadius.circular(5.0)),
        alignment: Alignment.center,
        child: !model.isLoading
            ? BrandTexts.titleBold(text: model.arg.isEdit ? "Edit Product" : "Add Product", color: BrandColors.light)
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

enum TextFeildInputType {
  Text,
  Number,
  MultiLine,
}

enum ProductInfo {
  Title,
  Price,
  Desc,
  PostBy,
}
