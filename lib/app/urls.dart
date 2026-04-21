class Urls{

  static final String _baseUrl='https://ecom-rs8e.onrender.com/api';
  static final String signUpUrl='$_baseUrl/auth/signup';
  static final String verifyOtpUrl='$_baseUrl/auth/verify-otp';
  static final String loginUrl='$_baseUrl/auth/login';


  static final String homeSliderUrl='$_baseUrl/slides';

  static String categoryListUrl(int count, int currentPage) =>
      '$_baseUrl/categories?count=$count&page=$currentPage';

  static String productListByCategoryUrl(int count, int currentPage,
      String categoryId) =>
      '$_baseUrl/products?count=$count&page=$currentPage&category=$categoryId';
  static String productsByTagUrl(String tag) => '$_baseUrl/products?tag=$tag';

  static String productDetailsUrl(String productId) =>
      '$_baseUrl/products/id/$productId';

  static  String addToCartUrl = '$_baseUrl/cart';
  static  String getCartListUrl = '$_baseUrl/cart';
  static String updateQuantity(String id)=>'$_baseUrl/cart/$id';
  static String deleteCartItem(String id)=>'$_baseUrl/cart/$id';
  static String productReviewUrl(String id)=>'$_baseUrl/reviews?product=$id';
  static String createReviewUrl='$_baseUrl/review';
  static String orderPlaceUrl='$_baseUrl/order';
  static  String addToWishUrl = '$_baseUrl/wishlist';
  static  String getWishListUrl = '$_baseUrl/wishlist';
  static String deleteWishItem(String id)=>'$_baseUrl/wishlist/$id';
}