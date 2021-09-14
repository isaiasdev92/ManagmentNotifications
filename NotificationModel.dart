import 'dart:convert';

class NotificationModel {
  static String channelNotification = "";
  static String tableName = 'Notification';
  static String columnId = 'Id';
  static String columnRequestID = 'RequestId';
  static String columnTitle = 'Title';
  static String columnMessage = 'Message';
  static String columnIsSeen = 'IsSeen';
  static String columnTimestamp = 'Timestamp';

  // File jsonFile;
  // static bool fileExists = false;

  String id;
  String requestID;
  String title;
  String message;
  bool isSeen;
  DateTime timestamp;

  NotificationModel({this.id, this.requestID, this.title, this.message, this.isSeen, this.timestamp});

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json[columnId] == null ? "00000-0000" : json[columnId] as String,
        requestID: json[columnRequestID] == null ? "000" : json[columnRequestID] as String,
        title: json[columnTitle] == null ? "No title" : json[columnTitle] as String,
        message: json[columnMessage] == null ? "No data" : json[columnMessage] as String,
        isSeen: json[columnIsSeen] == null ? false : json[columnIsSeen] as bool,
        timestamp: json[columnTimestamp] == null ? DateTime.now() : DateTime.parse(json[columnTimestamp]),
      );

  Map<String, dynamic> toJson() => {
        columnId: id == null ? null : id,
        columnTitle: title == null ? null : title,
        columnMessage: message == null ? null : message,
        columnIsSeen: isSeen == null ? null : isSeen,
        columnTimestamp: timestamp == null ? null : timestamp.toIso8601String(),
        columnRequestID: requestID == null ? null : requestID
      };


}
