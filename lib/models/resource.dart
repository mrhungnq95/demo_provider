import "data.dart";
import "ad.dart";

class Resource {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Ad ad;

  Resource(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.ad});

  Resource.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      // data = new List<Data>();
      // json['data'].forEach((v) {
      //   data.add(new Data.fromJson(v));
      // });

      var dataAsList = json['data'] as List;
      data = dataAsList?.map((value) => Data.fromJson(value))?.toList();
    }
    ad = json['ad'] != null ? new Ad.fromJson(json['ad']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.ad != null) {
      data['ad'] = this.ad.toJson();
    }
    return data;
  }
}
