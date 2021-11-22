import 'package:http/http.dart' as http;

class ProductApi {
  static Future getProduct() async {
    final response =
    await http.get(Uri.parse('http://10.0.2.2:3000/product'));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future getProductByCategoryId(int categoryId) async{
    return http.get(
      Uri.parse("http://10.0.2.2:3000/products?categoryId=$categoryId"),
    );
  }
}