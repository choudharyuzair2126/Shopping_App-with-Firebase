import 'package:app_ui/Services/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'apiservices.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/products')
  Future<List<ProductModel>> getProducts();
}
