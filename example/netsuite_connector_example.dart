import 'package:netsuite_connector/netsuite_connector.dart';

void main() async {
  const Map<String, String> oauthCredentials = {
    'consumer_key':
        '9363a82abf93a9a6c7e1ec39a5f115c1fa1e898b761351fb804f63b116ca095f',
    'consumer_secret':
        '98829b488b5694aaab6b92b46a8102316c3c3c7a8b8e71a2e8d49309f9d23e3b',
    'token': 'f446dd6ce19a62fcdf8e2319d3ff993d5f3928a40aeceeac5f6f11ae0ae024ff',
    'token_secret':
        'b9ad063a4ff67bc1c098aca19cab52f98f3080900f80f8e4fab7cfef0a22fa54',
  };

  Uri baseUri = Uri.parse(
      'https://7460472-sb1.restlets.api.netsuite.com/app/site/hosting/restlet.nl');

  Credentials credentials = Credentials(oauthCredentials);
  RequestHandler handler = OAuthHandler(credentials: credentials);
  NetsuiteClient client = NetsuiteClient(handler: handler);

  var category = {'script': '215', 'deploy': '1'};
  await client
      .get(baseUri.replace(queryParameters: category))
      .then((value) => print(value.body));

  print('\n');

  var materials = {'script': '202', 'deploy': '1'};
  await client
      .get(baseUri.replace(queryParameters: materials))
      .then((value) => print(value.body));

  print('\n');

  var locations = {'script': '207', 'deploy': '1'};
  await client
      .get(baseUri.replace(queryParameters: locations))
      .then((value) => print(value.body));
}
