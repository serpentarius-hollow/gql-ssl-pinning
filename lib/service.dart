// import 'dart:io';

// import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:http/io_client.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

/// Using certificate
class Service {
  // final ByteData _certData;
  final List<String> _allowedSHAFingerprints;

  late GraphQLClient _gqlClient;
  GraphQLClient get gqlClient => _gqlClient;

  // late IOClient _httpClient;
  // IOClient get httpClient => _httpClient;

  late SecureHttpClient _secureHttpClient;
  SecureHttpClient get secureHttpClient => _secureHttpClient;

  Service(this._allowedSHAFingerprints) {
    // This is useless
    // SecurityContext context = SecurityContext.defaultContext;
    // context.setTrustedCertificatesBytes(_certData.buffer.asUint8List());
    // final http = HttpClient(context: context);

    // http.badCertificateCallback = (cert, host, port) {
    //   print("!!!Bad certificate!!!");
    //   return false;
    // };

    // _httpClient = IOClient(http);

    _secureHttpClient = SecureHttpClient.build(_allowedSHAFingerprints);

    final httpLink = HttpLink(
      'https://core.setoko-test.com/v1/graphql/',
      httpClient: _secureHttpClient,
    );

    _gqlClient = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }
}
