import 'package:demo_provider/models/data.dart';
import 'package:demo_provider/models/service_response.dart';
import 'dart:convert';
import 'membership_service.dart';

class MembershipServiceClient {
  MembershipServiceClient._internal();

  MembershipService service = MembershipService.shared;
  static MembershipServiceClient shared = MembershipServiceClient._internal();

  Future<ServiceResponse<Data>> fetchResourceAsync() async {
    final response = await service.dio.get("/unknown");
    var data = response.data;

    if (data is String) {
      data = jsonDecode(data);
    }

    //var map = Map<String, dynamic>.from(data);
    var result = ServiceResponse<Data>.fromJson(data, Data.fromJsonGeneric);

    return result;
  }

  void resetService() {
    service.resetService();
    shared = null;
  }
}
