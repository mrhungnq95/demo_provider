import 'package:demo_provider/service/my_dio.dart';
import 'package:dio/dio.dart';

class MembershipService extends DioAbstract {
  MembershipService._internal() : super() {
    print("MembershipService created!");
  }
  static MembershipService shared = MembershipService._internal();

  @override
  String getServiceUrl() {
    return "https://reqres.in/api";
  }

  @override
  int getConnectTimeOut() {
    return 30000;
  }

  @override
  int getReceiverTimeOut() {
    return 30000;
  }

  @override
  void resetService() {
    resetDio();

    shared = null;
  }

  @override
  Interceptor getInterceptor() {
    return null;
  }
}
