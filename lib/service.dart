import 'package:dio/dio.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class Service {
  final List<String> _allowedSHAFingerprints;

  late GraphQLClient _secureGqlClient;
  GraphQLClient get secureGqlClient => _secureGqlClient;

  late Dio _secureDioClient;
  Dio get secureDioClient => _secureDioClient;

  Service(this._allowedSHAFingerprints) {
    _secureDioClient = Dio(BaseOptions(baseUrl: 'https://core.setoko-test.com'))
      ..interceptors.add(CertificatePinningInterceptor(
          allowedSHAFingerprints: _allowedSHAFingerprints));

    final link = Link.from([
      DioLink(
        '/v1/graphql',
        client: _secureDioClient,
      ),
    ]);

    _secureGqlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }
}
