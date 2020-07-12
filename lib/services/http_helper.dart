import 'package:http/http.dart' as http;

const url = 'http://jsonplaceholder.typicode.com/todos';

class HttpHelper {
  static Future<String> getData() async {
    http.Response response = await http.get(url);
    String data = response.body;
    if (response.statusCode == 200)
      return data;
    else
      return null;
  }
}
