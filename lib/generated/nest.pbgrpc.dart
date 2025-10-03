// This is a generated file - do not edit.
//
// Generated from nest.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'nest.pb.dart' as $0;

export 'nest.pb.dart';

@$pb.GrpcServiceName('com.nbp.cdncp.nest.grpc.proto.v1.NestService')
class NestServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  NestServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$0.NestResponse> recognize(
    $async.Stream<$0.NestRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$recognize, request, options: options);
  }

  // method descriptors

  static final _$recognize =
      $grpc.ClientMethod<$0.NestRequest, $0.NestResponse>(
          '/com.nbp.cdncp.nest.grpc.proto.v1.NestService/recognize',
          ($0.NestRequest value) => value.writeToBuffer(),
          $0.NestResponse.fromBuffer);
}

@$pb.GrpcServiceName('com.nbp.cdncp.nest.grpc.proto.v1.NestService')
abstract class NestServiceBase extends $grpc.Service {
  $core.String get $name => 'com.nbp.cdncp.nest.grpc.proto.v1.NestService';

  NestServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.NestRequest, $0.NestResponse>(
        'recognize',
        recognize,
        true,
        true,
        ($core.List<$core.int> value) => $0.NestRequest.fromBuffer(value),
        ($0.NestResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.NestResponse> recognize(
      $grpc.ServiceCall call, $async.Stream<$0.NestRequest> request);
}
