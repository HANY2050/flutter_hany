import 'package:generalshops/exceptions/exceptions.dart';
import 'package:generalshops/info_shop/info_shop.dart';
import 'package:generalshops/product/product_tag.dart';
import 'package:generalshops/product/product_unit.dart';
import 'package:generalshops/review/product_review.dart';

class Product {
  int product_id;
  String product_description;
  String product_title;
  String size1;
  String size2;
  String size3;
  String size4;
  String size5;
  String color1;
  String color2;
  String color3;
  String color4;
  String color5;
  ProductUnit productUnit;
  int product_price;
  double product_total, product_discount;
  // ProductCategory productCategory;
  InfoShop infoShop;
  List<ProductTag> tags;
  List<String> images;
  List<ProductReview> review;
  //List<String> options;
  // List<Map<String, dynamic>> options;
  // Map<String, dynamic> options = [];
  // List<dynamic> userFriendList = [];

  Product(
    this.product_id,
    this.product_title,
    this.product_description,
    this.productUnit,
    this.product_price,
    this.product_total,
    this.product_discount,
    //  this.productCategory,
    this.infoShop,
    this.tags,
    this.images,
    this.review,
    // this.options,
    this.size1,
    this.size2,
    this.size3,
    this.size4,
    this.size5,
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.color5,
  );

  Product.fromJson(Map<String, dynamic> jsonObject) {
    if (jsonObject['product_id'] == null) {
      throw PropertyIsRequired('Product ID');
    }
    if (jsonObject['product_title'] == null) {
      throw PropertyIsRequired('Product Title');
    }
    if (jsonObject['product_description'] == null) {
      throw PropertyIsRequired('Product Description');
    }
    if (jsonObject['product_price'] == null) {
      throw PropertyIsRequired('Product Price');
    }
    if (jsonObject['product_total'] == null) {
      throw PropertyIsRequired('Product Total');
    }
    if (jsonObject['product_discount'] == null) {
      throw PropertyIsRequired('Product Discount');
    }
    if (jsonObject['size1'] == null) {
      throw PropertyIsRequired('size1');
    }
    if (jsonObject['size2'] == null) {
      throw PropertyIsRequired('size2');
    }
    if (jsonObject['size3'] == null) {
      throw PropertyIsRequired('size3');
    }
    if (jsonObject['size4'] == null) {
      throw PropertyIsRequired('size4');
    }
    if (jsonObject['size5'] == null) {
      throw PropertyIsRequired('size5');
    }
    if (jsonObject['color1'] == null) {
      throw PropertyIsRequired('color1');
    }
    if (jsonObject['color2'] == null) {
      throw PropertyIsRequired('color2');
    }
    if (jsonObject['color3'] == null) {
      throw PropertyIsRequired('color3');
    }
    if (jsonObject['color4'] == null) {
      throw PropertyIsRequired('color4');
    }
    if (jsonObject['color5'] == null) {
      throw PropertyIsRequired('color5');
    }

    /* if (jsonObject['product_category'] == null) {
      throw PropertyIsRequired('Product Category');
    }*/

    /*  if (jsonObject['infoShop'] == null) {
      throw PropertyIsRequired('Info Shop');
    }*/
    this.product_id = jsonObject['product_id'];
    this.product_title = jsonObject['product_title'];

    this.size1 = jsonObject['size1'];
    this.size2 = jsonObject['size2'];
    this.size3 = jsonObject['size3'];
    this.size4 = jsonObject['size4'];
    this.size5 = jsonObject['size5'];
    this.color1 = jsonObject['color1'];
    this.color2 = jsonObject['color2'];
    this.color3 = jsonObject['color3'];
    this.color4 = jsonObject['color4'];
    this.color5 = jsonObject['color5'];

    this.product_description = jsonObject['product_description'];

    this.product_price = jsonObject['product_price'];

    this.product_total = double.tryParse(jsonObject['product_total']);
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    /*this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);*/

    this.infoShop = InfoShop.fromJson(jsonObject['info_shop']);

    this.tags = [];
    if (jsonObject['product_tag'] != null) {
      _setTags(jsonObject['product_tag']);
    }
    /* this.options = [];
    if (jsonObject['options'] != null) {
      _setOption(jsonObject['options']);
    }*/

    if (jsonObject['product_unit'] != null) {
      this.productUnit = ProductUnit.fromJson(jsonObject['product_unit']);
    }

    this.images = [];

    if (jsonObject['product_image'] != null) {
      _setImages(jsonObject['product_image']);
    }

    this.review = [];
    if (jsonObject['product_review'] != null) {
      _setReviews(jsonObject['product_review']);
    }
  }

  void _setTags(List<dynamic> TagsJson) {
    if (TagsJson.length > 0) {
      for (var item in TagsJson) {
        if (item != null) {
          tags.add(ProductTag.fromJson(item));
        }
      }
    }
  }

  void _setReviews(List<dynamic> ReviewsJson) {
    if (ReviewsJson.length > 0) {
      for (var item in ReviewsJson) {
        if (item != null) {
          review.add(ProductReview.fromJson(item));
        }
      }
    }
  }

  void _setImages(List<dynamic> jsonImages) {
    if (jsonImages.length > 0) {
      for (var image in jsonImages) {
        if (image != null) {
          this.images.add(image['image_url']);
        }
      }
    }
  }

  String featuredImage() {
    var url = this.images[0];

    if (this.images.length > 0) {
      return 'http://shop.myadeentrading.com/public/$url';
    } else {
      return 'http://shop.myadeentrading.com/public/1631655586.jpg';
    }
  }
}
