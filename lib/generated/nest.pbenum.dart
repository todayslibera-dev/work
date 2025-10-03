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

class RequestType extends $pb.ProtobufEnum {
  static const RequestType CONFIG =
      RequestType._(0, _omitEnumNames ? '' : 'CONFIG');
  static const RequestType DATA =
      RequestType._(1, _omitEnumNames ? '' : 'DATA');

  static const $core.List<RequestType> values = <RequestType>[
    CONFIG,
    DATA,
  ];

  static final $core.List<RequestType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static RequestType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RequestType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
