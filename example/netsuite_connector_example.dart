import 'dart:convert';
import 'package:netsuite_connector/netsuite_connector.dart';

void main() async {
  const Map<String, String> oauthCredentials = {
    'consumer_key': 'your consumer_key',
    'consumer_secret': 'your consumer_secret',
    'token': 'your token',
    'token_secret': 'your token_secret',
  };

  Uri baseUri = Uri.parse(
      'https://<ACCOUNT_ID>.restlets.api.netsuite.com/app/site/hosting/restlet.nl');

  Credentials credentials = Credentials(oauthCredentials);
  RequestHandler handler = OAuthHandler(credentials: credentials);
  NetsuiteClient client = NetsuiteClient(handler: handler);

  var getReq = {'script': '201', 'deploy': '1', 'MaterialRequestID': '3373'};
  await client
      .get(baseUri.replace(queryParameters: getReq))
      .then((value) => print(value.body));

  var payload = {"id": 2, "title": "example", "body": "lorem ipsum"};

  var postReq = {'script': '211', 'deploy': '1'};
  await client
      .post(baseUri.replace(queryParameters: postReq),
          body: jsonEncode(payload))
      .then((value) => print(value.body));

  var delReq = {'script': '213', 'deploy': '1', 'TransferOrderId': '3575'};
  await client
      .delete(baseUri.replace(queryParameters: delReq))
      .then((res) => print(res.body));
}
