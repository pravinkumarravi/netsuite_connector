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

  var getReq = {'script': '100', 'deploy': '1', 'id': '100'};
  await client
      .get(baseUri.replace(queryParameters: getReq))
      .then((value) => print(value.body));

  var payload = {"id": 2, "title": "example", "body": "lorem ipsum"};

  var postReq = {'script': '101', 'deploy': '1'};
  await client
      .post(baseUri.replace(queryParameters: postReq),
          body: jsonEncode(payload))
      .then((value) => print(value.body));

  var delReq = {'script': '102', 'deploy': '1', 'id': '100'};
  await client
      .delete(baseUri.replace(queryParameters: delReq))
      .then((res) => print(res.body));
}
