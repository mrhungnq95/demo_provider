import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class AuthenAPI {
  String _apiName = "AuthenAPI";

  String get apiName => _apiName;

  Future<String> requestGetUserInfo() {
    return Future.delayed(Duration(seconds: 5), () {
      return "Lương Xuân Fuock";
    });
  }
}

class AppService {
  AuthenAPI _authenAPI;

  AppService(this._authenAPI);

  Future<String> requestGetUserInfo() {
    print("requestGetUserInfo");
    return _authenAPI.requestGetUserInfo();
  }
}

class ProxyModel with ChangeNotifier {
  AppService _appService;
  String _userInfo = "No Data";
  Future requestGetUserInfoFuture;

  String get userInfo => _userInfo;

  void updateAppService(AppService value) {
    _appService = value;
    print("ProxyModel - updateAppService");
  }

  void requestGetUserInfoAsync() async {
    _userInfo = "Requesting...";
    notifyListeners();

    requestGetUserInfoFuture = _appService.requestGetUserInfo().then((value) {
      _userInfo = value;
      print(_userInfo);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();

    CancelableOperation.fromFuture(requestGetUserInfoFuture).cancel();
  }
}

class ProxyProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proxy Provider"),
      ),
      body: MultiProvider(
        providers: [
          Provider(create: (_) => AuthenAPI()),
          ProxyProvider<AuthenAPI, AppService>(update: (_, authenAPI, __) {
            return AppService(authenAPI);
          }),
          ChangeNotifierProxyProvider<AppService, ProxyModel>(
            update: (_, appService, proxyModel) =>
                proxyModel..updateAppService(appService),
            create: (context) => ProxyModel(),
          )
        ],
        child: _ContentProvider(),
      ),
    );
  }
}

class _ContentProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ProxyModel>(
        builder: (_, proxyModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Result: ${proxyModel.userInfo}"), child],
          );
        },
        child: RaisedButton(
          onPressed: () {
            context.read<ProxyModel>().requestGetUserInfoAsync();
          },
          child: Text("Get UserInfo"),
        ),
      ),
    );
  }
}
