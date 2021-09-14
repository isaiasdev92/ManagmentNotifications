import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:{your_path}/src/services/database/abstract_dao.dart';
import 'package:{your_path}/models/notification/notification_model.dart' as Model;
import 'package:uuid/uuid.dart';

class InstanceNotification implements AbstractDao<Model.NotificationModel> {
  final _uuid = Uuid();

  @override
  Future<bool> insert(Model.NotificationModel notificationModel) async {
    try {
      final jsonFile = await _getFileObjectNotification();
      notificationModel.id = _uuid.v1();

      List<dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.add(notificationModel);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));

      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  @override
  Future<bool> update(Model.NotificationModel notificationModel) async {
    try {
      final listFiles = await getAll();
      final jsonFile = await _getFileObjectNotification();
      
      final singleSearch = listFiles.firstWhere((element) => element.id == notificationModel.id); 
      final indexUpdate = listFiles.indexOf(singleSearch);

      listFiles[indexUpdate] = notificationModel;

      jsonFile.writeAsStringSync(json.encode(listFiles));

      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  @override
  Future<bool> delete(Model.NotificationModel notificationModel) async {
    try {
      final listFiles = await getAll();
      final jsonFile = await _getFileObjectNotification();

      if (listFiles.isNotEmpty) {
        if (listFiles.length == 1) {
          jsonFile.writeAsStringSync(json.encode([]));
        } else {
          listFiles.removeWhere((element) => element.id == notificationModel.id);
          jsonFile.writeAsStringSync(json.encode(listFiles));
        }
      }

      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  @override
  Future<bool> deleteAll() async {
    try {
      final jsonFile = await _getFileObjectNotification();

      if (jsonFile != null) {
        jsonFile.writeAsStringSync(json.encode([]));
      }

      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  @override
  Future<List<Model.NotificationModel>> getAll() async {
    try {
      final jsonFile = await _getFileObjectNotification();

      if (jsonFile != null) {
        List<dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());

        List<Model.NotificationModel> notifications = [];
        if (jsonFileContent.isNotEmpty)
          jsonFileContent.forEach((element) => notifications.add(Model.NotificationModel.fromJson(element)));
        
        return notifications;
      }

      return [];
    } catch (e) {
      Future.error(e);
    }

    return [];
  }

  static Future<File> _getFileObjectNotification() async {
    try {
      final databasePathRoot = await getApplicationDocumentsDirectory();
      final dataBasePath = databasePathRoot.path;
      final fileName = "${Model.NotificationModel.tableName}.json";
      final databasePath = join(dataBasePath, fileName);

      File file = new File(databasePath);

      if (!await File(databasePath).exists()) {
        file.createSync();
        file.writeAsStringSync(json.encode([]));
      }

      return file;
    } catch (e) {
      Future.error(e);
    }

    return null;
  }
}
