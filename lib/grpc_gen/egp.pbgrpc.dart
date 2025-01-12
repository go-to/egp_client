//
//  Generated code. Do not modify.
//  source: egp.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'egp.pb.dart' as $0;

export 'egp.pb.dart';

@$pb.GrpcServiceName('egp.EgpService')
class EgpServiceClient extends $grpc.Client {
  static final _$getShops = $grpc.ClientMethod<$0.ShopsRequest, $0.ShopsResponse>(
      '/egp.EgpService/GetShops',
      ($0.ShopsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ShopsResponse.fromBuffer(value));

  EgpServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ShopsResponse> getShops($0.ShopsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getShops, request, options: options);
  }
}

@$pb.GrpcServiceName('egp.EgpService')
abstract class EgpServiceBase extends $grpc.Service {
  $core.String get $name => 'egp.EgpService';

  EgpServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ShopsRequest, $0.ShopsResponse>(
        'GetShops',
        getShops_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ShopsRequest.fromBuffer(value),
        ($0.ShopsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ShopsResponse> getShops_Pre($grpc.ServiceCall call, $async.Future<$0.ShopsRequest> request) async {
    return getShops(call, await request);
  }

  $async.Future<$0.ShopsResponse> getShops($grpc.ServiceCall call, $0.ShopsRequest request);
}
