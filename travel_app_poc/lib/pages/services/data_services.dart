import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_app_poc/model/data_model.dart';

class DataServices {
  String baseUrl = 'https://mocki.io/v1/34dc644a-4977-4991-bb76-566ef56ffe01';
  Future<List<DataModel>> getInfo() async {
    var apiUrl = 'getplaces';
    http.Response res = await http.get(Uri.parse(baseUrl));
    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => DataModel.fromJson(e)).toList();
      } else {
        return <DataModel>[];
      }
    } catch (e) {
      return <DataModel>[];
    }
  }
}
