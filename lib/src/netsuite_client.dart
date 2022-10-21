import 'package:http/http.dart' as http;
import 'package:netsuite_connector/src/handlers/request_handler.dart';

class NetsuiteClient extends http.BaseClient {
  final RequestHandler handler;
  final Duration timeLimit = Duration(seconds: 15);

  NetsuiteClient({required this.handler});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    var requestHandler = handler.handle(request);
    return requestHandler.send();
  }
}
