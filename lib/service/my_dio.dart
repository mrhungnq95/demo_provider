import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

abstract class DioAbstract {
  String getServiceUrl();
  int getConnectTimeOut();
  int getReceiverTimeOut();
  Interceptor getInterceptor();

  Dio dioToken;
  Dio dio;

  DioAbstract() {
    dio = new Dio();

    dio.options.baseUrl = getServiceUrl();
    dio.options.connectTimeout = getConnectTimeOut();
    dio.options.receiveTimeout = getReceiverTimeOut();

    //Accept all cookies
    dio.interceptors.add(CookieManager(CookieJar()));
    //dio.interceptors.add(CookieManager(PersistCookieJar()));
    dio.interceptors.add(LogInterceptor(responseBody: false));

    if (getInterceptor() != null) {
      dio.interceptors.add(getInterceptor());
    }

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print('Send request：path:${options.path}，baseURL:${options.baseUrl}');
      String myToken = null;

      // if (myToken == null) {
      //   print("First time. No token detected!");
      //   //lock the dio.
      //   dio.lock();

      //   dioToken = new Dio(BaseOptions(baseUrl: ""));
      //   dioToken.options = dio.options;
      //   return dioToken.get("/token").then((d) {
      //     print("request token succeed, value: " + d.data['data']['token']);

      //     options.headers["myToken"] = myToken = d.data['data']['token'];

      //     print(
      //         'continue to perform request：path:${options.path}，baseURL:${options.path}');
      //     return options;
      //   }).whenComplete(
      //       () => dio.unlock()); // unlock the dio to continues request
      // } else {
      //   options.headers["myToken"] = myToken;
      //   return options;
      // }

      return options;
    }, onError: (DioError error) {
      // 401 ->Token expired
      if (error.response?.statusCode == 401) {
        RequestOptions options = error.response.request;

        String myToken = null; //Token on cache

        // If the token has been updated, repeat directly.
        if (myToken != options.headers["myToken"]) {
          options.headers["myToken"] = myToken;
          //Retry request again, with new Token
          return dio.request(options.path, options: options);
        }
        // Update token and Retry request
        // Lock to block the incoming request until the token updated
        dio.lock();
        dio.interceptors.responseLock.lock();
        dio.interceptors.errorLock.lock();

        dioToken = new Dio(BaseOptions(baseUrl: ""));
        dioToken.options = dio.options;

        return dioToken.get("/token").then((d) {
          //update myToken
          options.headers["myToken"] = myToken = d.data['data']['token'];
        }).whenComplete(() {
          dio.unlock();
          dio.interceptors.responseLock.unlock();
          dio.interceptors.errorLock.unlock();
        }).then((e) {
          //Retry request again, with new Token
          return dio.request(options.path, options: options);
        });
      }
      return error;
    }));

    print("DioAbstract created! - ${getConnectTimeOut()}");
  }

  void resetDio() {
    dio = null;
    dioToken = null;
  }

  void resetService();
}
