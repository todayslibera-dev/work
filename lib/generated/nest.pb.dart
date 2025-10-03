// This is a generated file - do not edit.
//
// Generated from nest.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'nest.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'nest.pbenum.dart';

class NestConfig extends $pb.GeneratedMessage {
  factory NestConfig({
    $core.String? config,
  }) {
    final result = create();
    if (config != null) result.config = config;
    return result;
  }

  NestConfig._();

  factory NestConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NestConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NestConfig',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'com.nbp.cdncp.nest.grpc.proto.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'config')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestConfig clone() => NestConfig()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestConfig copyWith(void Function(NestConfig) updates) =>
      super.copyWith((message) => updates(message as NestConfig)) as NestConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NestConfig create() => NestConfig._();
  @$core.override
  NestConfig createEmptyInstance() => create();
  static $pb.PbList<NestConfig> createRepeated() => $pb.PbList<NestConfig>();
  @$core.pragma('dart2js:noInline')
  static NestConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NestConfig>(create);
  static NestConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get config => $_getSZ(0);
  @$pb.TagNumber(1)
  set config($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => $_clearField(1);
}

class NestData extends $pb.GeneratedMessage {
  factory NestData({
    $core.List<$core.int>? chunk,
    $core.String? extraContents,
  }) {
    final result = create();
    if (chunk != null) result.chunk = chunk;
    if (extraContents != null) result.extraContents = extraContents;
    return result;
  }

  NestData._();

  factory NestData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NestData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NestData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'com.nbp.cdncp.nest.grpc.proto.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'chunk', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'extraContents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestData clone() => NestData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestData copyWith(void Function(NestData) updates) =>
      super.copyWith((message) => updates(message as NestData)) as NestData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NestData create() => NestData._();
  @$core.override
  NestData createEmptyInstance() => create();
  static $pb.PbList<NestData> createRepeated() => $pb.PbList<NestData>();
  @$core.pragma('dart2js:noInline')
  static NestData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NestData>(create);
  static NestData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get chunk => $_getN(0);
  @$pb.TagNumber(1)
  set chunk($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChunk() => $_has(0);
  @$pb.TagNumber(1)
  void clearChunk() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get extraContents => $_getSZ(1);
  @$pb.TagNumber(2)
  set extraContents($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExtraContents() => $_has(1);
  @$pb.TagNumber(2)
  void clearExtraContents() => $_clearField(2);
}

enum NestRequest_Part { config, data, notSet }

class NestRequest extends $pb.GeneratedMessage {
  factory NestRequest({
    RequestType? type,
    NestConfig? config,
    NestData? data,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (config != null) result.config = config;
    if (data != null) result.data = data;
    return result;
  }

  NestRequest._();

  factory NestRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NestRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, NestRequest_Part> _NestRequest_PartByTag = {
    2: NestRequest_Part.config,
    3: NestRequest_Part.data,
    0: NestRequest_Part.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NestRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'com.nbp.cdncp.nest.grpc.proto.v1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..e<RequestType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: RequestType.CONFIG,
        valueOf: RequestType.valueOf,
        enumValues: RequestType.values)
    ..aOM<NestConfig>(2, _omitFieldNames ? '' : 'config',
        subBuilder: NestConfig.create)
    ..aOM<NestData>(3, _omitFieldNames ? '' : 'data',
        subBuilder: NestData.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestRequest clone() => NestRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestRequest copyWith(void Function(NestRequest) updates) =>
      super.copyWith((message) => updates(message as NestRequest))
          as NestRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NestRequest create() => NestRequest._();
  @$core.override
  NestRequest createEmptyInstance() => create();
  static $pb.PbList<NestRequest> createRepeated() => $pb.PbList<NestRequest>();
  @$core.pragma('dart2js:noInline')
  static NestRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NestRequest>(create);
  static NestRequest? _defaultInstance;

  NestRequest_Part whichPart() => _NestRequest_PartByTag[$_whichOneof(0)]!;
  void clearPart() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  RequestType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(RequestType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  NestConfig get config => $_getN(1);
  @$pb.TagNumber(2)
  set config(NestConfig value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasConfig() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfig() => $_clearField(2);
  @$pb.TagNumber(2)
  NestConfig ensureConfig() => $_ensure(1);

  @$pb.TagNumber(3)
  NestData get data => $_getN(2);
  @$pb.TagNumber(3)
  set data(NestData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);
  @$pb.TagNumber(3)
  NestData ensureData() => $_ensure(2);
}

class NestResponse extends $pb.GeneratedMessage {
  factory NestResponse({
    $core.String? contents,
  }) {
    final result = create();
    if (contents != null) result.contents = contents;
    return result;
  }

  NestResponse._();

  factory NestResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NestResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NestResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'com.nbp.cdncp.nest.grpc.proto.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestResponse clone() => NestResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestResponse copyWith(void Function(NestResponse) updates) =>
      super.copyWith((message) => updates(message as NestResponse))
          as NestResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NestResponse create() => NestResponse._();
  @$core.override
  NestResponse createEmptyInstance() => create();
  static $pb.PbList<NestResponse> createRepeated() =>
      $pb.PbList<NestResponse>();
  @$core.pragma('dart2js:noInline')
  static NestResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NestResponse>(create);
  static NestResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contents => $_getSZ(0);
  @$pb.TagNumber(1)
  set contents($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContents() => $_has(0);
  @$pb.TagNumber(1)
  void clearContents() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
