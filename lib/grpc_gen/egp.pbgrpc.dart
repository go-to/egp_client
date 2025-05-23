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
  static final _$getShopsTotal = $grpc.ClientMethod<$0.ShopsTotalRequest, $0.ShopsTotalResponse>(
      '/egp.EgpService/GetShopsTotal',
      ($0.ShopsTotalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ShopsTotalResponse.fromBuffer(value));
  static final _$getShops = $grpc.ClientMethod<$0.ShopsRequest, $0.ShopsResponse>(
      '/egp.EgpService/GetShops',
      ($0.ShopsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ShopsResponse.fromBuffer(value));
  static final _$getShop = $grpc.ClientMethod<$0.ShopRequest, $0.ShopResponse>(
      '/egp.EgpService/GetShop',
      ($0.ShopRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ShopResponse.fromBuffer(value));
  static final _$addStamp = $grpc.ClientMethod<$0.StampRequest, $0.StampResponse>(
      '/egp.EgpService/AddStamp',
      ($0.StampRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.StampResponse.fromBuffer(value));
  static final _$deleteStamp = $grpc.ClientMethod<$0.StampRequest, $0.StampResponse>(
      '/egp.EgpService/DeleteStamp',
      ($0.StampRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.StampResponse.fromBuffer(value));

  EgpServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ShopsTotalResponse> getShopsTotal($0.ShopsTotalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getShopsTotal, request, options: options);
  }

  $grpc.ResponseFuture<$0.ShopsResponse> getShops($0.ShopsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getShops, request, options: options);
  }

  $grpc.ResponseFuture<$0.ShopResponse> getShop($0.ShopRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getShop, request, options: options);
  }

  $grpc.ResponseFuture<$0.StampResponse> addStamp($0.StampRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStamp, request, options: options);
  }

  $grpc.ResponseFuture<$0.StampResponse> deleteStamp($0.StampRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteStamp, request, options: options);
  }
}

@$pb.GrpcServiceName('egp.EgpService')
abstract class EgpServiceBase extends $grpc.Service {
  $core.String get $name => 'egp.EgpService';

  EgpServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ShopsTotalRequest, $0.ShopsTotalResponse>(
        'GetShopsTotal',
        getShopsTotal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ShopsTotalRequest.fromBuffer(value),
        ($0.ShopsTotalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ShopsRequest, $0.ShopsResponse>(
        'GetShops',
        getShops_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ShopsRequest.fromBuffer(value),
        ($0.ShopsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ShopRequest, $0.ShopResponse>(
        'GetShop',
        getShop_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ShopRequest.fromBuffer(value),
        ($0.ShopResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StampRequest, $0.StampResponse>(
        'AddStamp',
        addStamp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StampRequest.fromBuffer(value),
        ($0.StampResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StampRequest, $0.StampResponse>(
        'DeleteStamp',
        deleteStamp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StampRequest.fromBuffer(value),
        ($0.StampResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ShopsTotalResponse> getShopsTotal_Pre($grpc.ServiceCall call, $async.Future<$0.ShopsTotalRequest> request) async {
    return getShopsTotal(call, await request);
  }

  $async.Future<$0.ShopsResponse> getShops_Pre($grpc.ServiceCall call, $async.Future<$0.ShopsRequest> request) async {
    return getShops(call, await request);
  }

  $async.Future<$0.ShopResponse> getShop_Pre($grpc.ServiceCall call, $async.Future<$0.ShopRequest> request) async {
    return getShop(call, await request);
  }

  $async.Future<$0.StampResponse> addStamp_Pre($grpc.ServiceCall call, $async.Future<$0.StampRequest> request) async {
    return addStamp(call, await request);
  }

  $async.Future<$0.StampResponse> deleteStamp_Pre($grpc.ServiceCall call, $async.Future<$0.StampRequest> request) async {
    return deleteStamp(call, await request);
  }

  $async.Future<$0.ShopsTotalResponse> getShopsTotal($grpc.ServiceCall call, $0.ShopsTotalRequest request);
  $async.Future<$0.ShopsResponse> getShops($grpc.ServiceCall call, $0.ShopsRequest request);
  $async.Future<$0.ShopResponse> getShop($grpc.ServiceCall call, $0.ShopRequest request);
  $async.Future<$0.StampResponse> addStamp($grpc.ServiceCall call, $0.StampRequest request);
  $async.Future<$0.StampResponse> deleteStamp($grpc.ServiceCall call, $0.StampRequest request);
}
