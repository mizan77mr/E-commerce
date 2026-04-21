
class ProductCreateReviewRequestModel {
  final String product;
  final String comment;
  final String rating;

  ProductCreateReviewRequestModel({
    required this.product,
    required this.comment,
    required this.rating, required fristName, required lastName,
  });


  Map<String,dynamic>toJson(){
    return{
      "product": product,
      "comment":comment,
      "rating": rating

    };
  }
}


