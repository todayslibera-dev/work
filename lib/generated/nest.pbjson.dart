// This is a generated file - do not edit.
//
// Generated from nest.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use requestTypeDescriptor instead')
const RequestType$json = {
  '1': 'RequestType',
  '2': [
    {'1': 'CONFIG', '2': 0},
    {'1': 'DATA', '2': 1},
  ],
};

/// Descriptor for `RequestType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List requestTypeDescriptor =
    $convert.base64Decode('CgtSZXF1ZXN0VHlwZRIKCgZDT05GSUcQABIICgREQVRBEAE=');

@$core.Deprecated('Use nestConfigDescriptor instead')
const NestConfig$json = {
  '1': 'NestConfig',
  '2': [
    {'1': 'config', '3': 1, '4': 1, '5': 9, '10': 'config'},
  ],
};

/// Descriptor for `NestConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nestConfigDescriptor =
    $convert.base64Decode('CgpOZXN0Q29uZmlnEhYKBmNvbmZpZxgBIAEoCVIGY29uZmln');

@$core.Deprecated('Use nestDataDescriptor instead')
const NestData$json = {
  '1': 'NestData',
  '2': [
    {'1': 'chunk', '3': 1, '4': 1, '5': 12, '10': 'chunk'},
    {'1': 'extra_contents', '3': 2, '4': 1, '5': 9, '10': 'extraContents'},
  ],
};

/// Descriptor for `NestData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nestDataDescriptor = $convert.base64Decode(
    'CghOZXN0RGF0YRIUCgVjaHVuaxgBIAEoDFIFY2h1bmsSJQoOZXh0cmFfY29udGVudHMYAiABKA'
    'lSDWV4dHJhQ29udGVudHM=');

@$core.Deprecated('Use nestRequestDescriptor instead')
const NestRequest$json = {
  '1': 'NestRequest',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.com.nbp.cdncp.nest.grpc.proto.v1.RequestType',
      '10': 'type'
    },
    {
      '1': 'config',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.com.nbp.cdncp.nest.grpc.proto.v1.NestConfig',
      '9': 0,
      '10': 'config'
    },
    {
      '1': 'data',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.com.nbp.cdncp.nest.grpc.proto.v1.NestData',
      '9': 0,
      '10': 'data'
    },
  ],
  '8': [
    {'1': 'part'},
  ],
};

/// Descriptor for `NestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nestRequestDescriptor = $convert.base64Decode(
    'CgtOZXN0UmVxdWVzdBJBCgR0eXBlGAEgASgOMi0uY29tLm5icC5jZG5jcC5uZXN0LmdycGMucH'
    'JvdG8udjEuUmVxdWVzdFR5cGVSBHR5cGUSRgoGY29uZmlnGAIgASgLMiwuY29tLm5icC5jZG5j'
    'cC5uZXN0LmdycGMucHJvdG8udjEuTmVzdENvbmZpZ0gAUgZjb25maWcSQAoEZGF0YRgDIAEoCz'
    'IqLmNvbS5uYnAuY2RuY3AubmVzdC5ncnBjLnByb3RvLnYxLk5lc3REYXRhSABSBGRhdGFCBgoE'
    'cGFydA==');

@$core.Deprecated('Use nestResponseDescriptor instead')
const NestResponse$json = {
  '1': 'NestResponse',
  '2': [
    {'1': 'contents', '3': 1, '4': 1, '5': 9, '10': 'contents'},
  ],
};

/// Descriptor for `NestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nestResponseDescriptor = $convert
    .base64Decode('CgxOZXN0UmVzcG9uc2USGgoIY29udGVudHMYASABKAlSCGNvbnRlbnRz');
