// import 'package:gsheets/gsheets.dart';
//
//
// class GoogleSheetsApi {
//    String ? value;
//   static const _creadentials = r'''
//   {
//   "type": "service_account",
//   "project_id": "basic-archive-353912",
//   "private_key_id": "debae5de374664a14ba6b1ee159c02fa231d1bc1",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDmrkg31ljijpfV\n3wg4WB0h3XG2+4PHkfR/EZwA+qPkeCyWqK5Xcuk2+jg4ekn8Q4vHDc30teOV7fs/\nAfjHtUnrWM0DuHsBWA3VakxtylDmFKcDGzhdhtnuGN8Wvf13S3Ud+hgs8Y5ykA8K\nXoVcmPLLCiXOSeFqd3DaABo+tXEkSJmnFCCOs81QRHhL21bo+tjhCNU8eBS9rV+o\nuuRHpXm7Ciak39/gRRXAGu4KNENWOxlK7v7TprcTViBKE7vusHbiXYEYVHLaYRdT\nIFASMzovt3ranSNY7cH3nLrTAJXusNUcBPDQVX330rIwcTb2M2oNINvMX/h+RoX+\n/LujKqNrAgMBAAECggEAO5dWLKaAu7YeXy+IjhWlIPR1xdFfj5SS1qiT5mTZJdIt\nopXcw9Z5jKxDDcP5jONeHoPgapD6Q+cAepxlyiF5AQUloQptLEG1ASa+q7YSA/3d\nzx2fB/ooHivqpZNbARBLJv1OdX3JUKsKV6FnTi5suira7VmEk95bFtXj8cMpgTeK\nez6uuojkRONkeZEq4NrjBiH1Bk7ak2LQ+yyAKoon+6nz80gvSl9zZAoW3Sh9nPfF\npW5WiMK0ZENFnk/Uxz2bwVXwqhQ9ELVUBwVjJ3zmzdKVuicXnrDCNiS6RVRe2HFx\nd+4F2265CukQCAG3tCAR1E8G+WGfrq6kXtFL+snCsQKBgQD0oi2FqPaejKZjyWeW\nu/lF5V/d7yYx56r5Kwcqq1qfyXIKCx4DOxMcRXC8Z2eWKfD07hPzULXvIe5ehIDM\nXCHmaQca35dMBh+s4QYwe5VMg9Dh8yoL9tt4IkkbiB4QQvzRI98iDi1UNen3b2VW\nC5Dt9a9btkSV/qO3QFQpQETofwKBgQDxZiRcKCBVqK1FdQewTF7u/pviR5seh8g1\nd/bAbfTdbJ7NE0SuTkxZakBNaN2Ceq/G1fIPTi3xiqXBUw4gPwWsV820Zbm/S7yF\nQ+aeSjGv767G6+m8HZEzgD3AObKV7b9rC0x12sulJqyngP9NXgrSJ7Ng7kTcZnB3\n/PZfdQvvFQKBgQCDwUklQMA62mPPQK0zCOCTnZtJa8E1haGW+26rs4hmoNdzw1MR\nyGJdiqTSRBsNTF+DeypxlJm4Rp0ceN7psgFsGEsEVUImZvHuaW+s8xKRGDmLSCzw\nLq87f7PCSUhv17RUa66EqAAP582wP2Xjtu0CzJz6lytPYcsJKnNpmDzEvwKBgFH8\nMMkjz6eH/CEk2BGmPm/JBURasXIzB2oxbhp4vbseEujvbFoOuZt8nI4t2V1hMaXE\nL8vG74+jWRxJivikrtaTk4d7LRStMj/IieCkri9kpeVlZiK/n/rvyQkqD18gOeyv\nD67POm7CrczN4Odz0xUA6sk24yg/ml8GCN7ur7jpAoGAGLfZFb1qaFWK3nbz7yww\n/BgJJCQkaNF3+7sRYAWDvi4KYODWUoAG234HAlQ8Tyr45zZ8m2J8SgKhIBJK+ULf\nzFfkJoBAHUfvVhbhwquMhpJtKe/+8JrJ1iGo7dMLODCY5CemOrkiMJHci+BJFg55\nWLd8hNJGMiKe90tmzsZOy5Q=\n-----END PRIVATE KEY-----\n",
//   "client_email": "words-bank@basic-archive-353912.iam.gserviceaccount.com",
//   "client_id": "104426291000691959392",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/words-bank%40basic-archive-353912.iam.gserviceaccount.com"
// }
//  ''';
//   static const _spreadSheetId = '1JNf5qSHVIo8AMAjt3LIeLaeSmYcvTp4r19fAWOWsIXk';
//   static final _gSheets = GSheets(_creadentials);
//   static Worksheet? _userSheet;
//
//   static Future<String?> init() async {
//     try {
//       final spreadSheet = await _gSheets.spreadsheet(_spreadSheetId);
//       //_userSheet = await getWorkSheet(spreadSheet, title: 'words bank');
//       _userSheet = spreadSheet.worksheetByTitle('words bank');
//
//       value = await _userSheet?.values.value(row: 1, column: 2);
//
//     } catch (e) {
//       print('Init Error :$e');
//     }
//   }
//
//   static Future<Worksheet> getWorkSheet(
//     Spreadsheet spreadsheet, {
//     required String title,
//   }) async {
//     try {
//       return await spreadsheet.addWorksheet(title);
//     } catch (e) {
//       return spreadsheet.worksheetByTitle(title)!;
//     }
//   }
//
// // static Future insert(List<Map<String, dynamic>> rowList) async {
// //   if (_userSheet == null) return;
// //   _userSheet!.values.map.appendRows(rowList);
// // }
//
// // static Future<int> getRowCount() async {
// //   if (_userSheet == null) return 0;
// //
// //   final lastRow = await _userSheet!.values.lastRow();
// //
// //   return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
// // }
// }
