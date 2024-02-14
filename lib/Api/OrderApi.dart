import 'package:service_provider/Models/ApiData.dart';
import 'package:service_provider/Api/Api_util.dart';
import 'package:service_provider/Models/Order.dart';
import 'package:service_provider/Models/Rate.dart';

class OrderApi {
  Future<List<Order>> getOrders(int page, String status) async {
    String url = ApiUtil.Orders + '?status=$status&page=$page';
    ApiData response = await theGet(url);

    if (response.statusCode == 200)
      return await loopOrders(response.data['orders']);

    return [];
  }

  Future<Order?> changeOrder(Map data) async {
    String url = ApiUtil.Change_Order;
    ApiData response = await theSend(url, data);

    if (response.statusCode == 201)
      return Order.fromAPI(response.data['order']);
    return null;
  }

  Future<Rate?> rateOrder(Map data) async {
    String url = ApiUtil.Rate_Order;
    ApiData response = await theSend(url, data);
    if (response.statusCode == 200) return Rate.fromAPI(response.data['rate']);
    return null;
  }

  Future<Order?> getNorRatedOrder() async {
    String url = ApiUtil.Not_Rated_Order;
    ApiData response = await theGet(url);
    if (response.statusCode == 200)
      return await Order.fromAPI(response.data['order']);
    return null;
  }

  Future<Order?> getActiveOrder() async {
    String url = ApiUtil.Active_Order;
    ApiData response = await theGet(url);

    if (response.statusCode == 200)
      return await Order.fromAPI(response.data['order']);
    return null;
  }
}
