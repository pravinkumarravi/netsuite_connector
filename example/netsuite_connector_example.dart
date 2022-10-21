import 'package:netsuite_connector/netsuite_connector.dart';

void main() async {
  const Map<String, String> oauthCredentials = {
    'consumer_key':
        'your consumer_key',https://github.com/pravinkumarravi/netsuite_connector/blob/main/example/netsuite_connector_example.dart
    'consumer_secret':
        'your consumer_secret',
    'token': 'your token',
    'token_secret':
        'your token_secret',
  };

  Uri baseUri = Uri.parse(
      'https://<ACCOUNT_ID>.restlets.api.netsuite.com/app/site/hosting/restlet.nl');

  Credentials credentials = Credentials(oauthCredentials);
  RequestHandler handler = OAuthHandler(credentials: credentials);
  NetsuiteClient client = NetsuiteClient(handler: handler);

  var category = {'script': '215', 'deploy': '1'};
  await client
      .get(baseUri.replace(queryParameters: category))
      .then((value) => print(value.body));
}
