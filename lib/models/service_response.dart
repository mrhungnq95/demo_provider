import "ad.dart";

class ServiceResponse<T> {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<T> data;
  Ad ad;

  ServiceResponse(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.ad});

  factory ServiceResponse.fromJson(
      Map<String, dynamic> json, Function fromJson) {
    final items = json['data'].cast<Map<String, dynamic>>();
    return ServiceResponse<T>(
        page: json["page"],
        perPage: json["perPage"],
        total: json["total"],
        totalPages: json["totalPages"],
        ad: json['ad'] != null ? new Ad.fromJson(json['ad']) : null,
        data: new List<T>.from(items.map((itemsJson) => fromJson(itemsJson))));
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['page'] = this.page;
  //   data['per_page'] = this.perPage;
  //   data['total'] = this.total;
  //   data['total_pages'] = this.totalPages;
  //   if (this.data != null) {
  //     data['data'] = this.data.map((v) => v.toJson()).toList();
  //   }
  //   if (this.ad != null) {
  //     data['ad'] = this.ad.toJson();
  //   }
  //   return data;
  // }
}
