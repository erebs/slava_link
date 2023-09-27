class HomeModel {
  String? date;
  String? status;
  String? totalHour;
  String? statusCode;

  HomeModel({this.date, this.status, this.totalHour, this.statusCode});

  HomeModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    totalHour = json['total_hour'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['status'] = this.status;
    data['total_hour'] = this.totalHour;
    data['status_code'] = this.statusCode;
    return data;
  }
}
