class ReportModel {
  final String locationLat;
  final String locationLong;
  final String fileSend;
  final String messageReported;
  final String reporterLocation;
  final String uid;
  // final String timestamp;
  final String reporterPhone;
  final String reporterName;

  ReportModel({
    required this.locationLat,
    required this.locationLong,
    required this.fileSend,
    required this.messageReported,
    required this.reporterLocation,
    required this.uid,
    // required this.timestamp,
    required this.reporterPhone,
    required this.reporterName,
  });

  Map<String, dynamic> toJson() => {
        "locationLat": locationLat,
        "locationLong": locationLong,
        "fileSend": fileSend,
        "messageReported": messageReported,
        "reporterLocation": reporterLocation,
        "uid": uid,
        "reporterPhone": reporterPhone,
        "reporterName": reporterName,
      };

      static ReportModel fromJson(Map<String, dynamic> json) => ReportModel(
        fileSend: json['fileSend'],
        locationLat: json['LocationLat'],
        locationLong: json['LocationLong'],
        messageReported: json['messageReported'],
        reporterLocation: json['reporterLocation'],
        reporterName: json['reporterName'],
        reporterPhone: json['reporterPhone'],
        uid: json['uid']
      );
}
