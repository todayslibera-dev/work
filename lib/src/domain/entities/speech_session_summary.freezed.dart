// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speech_session_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SpeechSessionSummary _$SpeechSessionSummaryFromJson(Map<String, dynamic> json) {
  return _SpeechSessionSummary.fromJson(json);
}

/// @nodoc
mixin _$SpeechSessionSummary {
  String? get audioPath => throw _privateConstructorUsedError;
  String? get transcriptPath => throw _privateConstructorUsedError;
  Uri? get webAudioUrl => throw _privateConstructorUsedError;
  Uri? get webTranscriptUrl => throw _privateConstructorUsedError;

  /// Serializes this SpeechSessionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpeechSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpeechSessionSummaryCopyWith<SpeechSessionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeechSessionSummaryCopyWith<$Res> {
  factory $SpeechSessionSummaryCopyWith(
    SpeechSessionSummary value,
    $Res Function(SpeechSessionSummary) then,
  ) = _$SpeechSessionSummaryCopyWithImpl<$Res, SpeechSessionSummary>;
  @useResult
  $Res call({
    String? audioPath,
    String? transcriptPath,
    Uri? webAudioUrl,
    Uri? webTranscriptUrl,
  });
}

/// @nodoc
class _$SpeechSessionSummaryCopyWithImpl<
  $Res,
  $Val extends SpeechSessionSummary
>
    implements $SpeechSessionSummaryCopyWith<$Res> {
  _$SpeechSessionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpeechSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioPath = freezed,
    Object? transcriptPath = freezed,
    Object? webAudioUrl = freezed,
    Object? webTranscriptUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            audioPath: freezed == audioPath
                ? _value.audioPath
                : audioPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            transcriptPath: freezed == transcriptPath
                ? _value.transcriptPath
                : transcriptPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            webAudioUrl: freezed == webAudioUrl
                ? _value.webAudioUrl
                : webAudioUrl // ignore: cast_nullable_to_non_nullable
                      as Uri?,
            webTranscriptUrl: freezed == webTranscriptUrl
                ? _value.webTranscriptUrl
                : webTranscriptUrl // ignore: cast_nullable_to_non_nullable
                      as Uri?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpeechSessionSummaryImplCopyWith<$Res>
    implements $SpeechSessionSummaryCopyWith<$Res> {
  factory _$$SpeechSessionSummaryImplCopyWith(
    _$SpeechSessionSummaryImpl value,
    $Res Function(_$SpeechSessionSummaryImpl) then,
  ) = __$$SpeechSessionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? audioPath,
    String? transcriptPath,
    Uri? webAudioUrl,
    Uri? webTranscriptUrl,
  });
}

/// @nodoc
class __$$SpeechSessionSummaryImplCopyWithImpl<$Res>
    extends _$SpeechSessionSummaryCopyWithImpl<$Res, _$SpeechSessionSummaryImpl>
    implements _$$SpeechSessionSummaryImplCopyWith<$Res> {
  __$$SpeechSessionSummaryImplCopyWithImpl(
    _$SpeechSessionSummaryImpl _value,
    $Res Function(_$SpeechSessionSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpeechSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioPath = freezed,
    Object? transcriptPath = freezed,
    Object? webAudioUrl = freezed,
    Object? webTranscriptUrl = freezed,
  }) {
    return _then(
      _$SpeechSessionSummaryImpl(
        audioPath: freezed == audioPath
            ? _value.audioPath
            : audioPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        transcriptPath: freezed == transcriptPath
            ? _value.transcriptPath
            : transcriptPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        webAudioUrl: freezed == webAudioUrl
            ? _value.webAudioUrl
            : webAudioUrl // ignore: cast_nullable_to_non_nullable
                  as Uri?,
        webTranscriptUrl: freezed == webTranscriptUrl
            ? _value.webTranscriptUrl
            : webTranscriptUrl // ignore: cast_nullable_to_non_nullable
                  as Uri?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpeechSessionSummaryImpl implements _SpeechSessionSummary {
  const _$SpeechSessionSummaryImpl({
    this.audioPath,
    this.transcriptPath,
    this.webAudioUrl,
    this.webTranscriptUrl,
  });

  factory _$SpeechSessionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpeechSessionSummaryImplFromJson(json);

  @override
  final String? audioPath;
  @override
  final String? transcriptPath;
  @override
  final Uri? webAudioUrl;
  @override
  final Uri? webTranscriptUrl;

  @override
  String toString() {
    return 'SpeechSessionSummary(audioPath: $audioPath, transcriptPath: $transcriptPath, webAudioUrl: $webAudioUrl, webTranscriptUrl: $webTranscriptUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeechSessionSummaryImpl &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.transcriptPath, transcriptPath) ||
                other.transcriptPath == transcriptPath) &&
            (identical(other.webAudioUrl, webAudioUrl) ||
                other.webAudioUrl == webAudioUrl) &&
            (identical(other.webTranscriptUrl, webTranscriptUrl) ||
                other.webTranscriptUrl == webTranscriptUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    audioPath,
    transcriptPath,
    webAudioUrl,
    webTranscriptUrl,
  );

  /// Create a copy of SpeechSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeechSessionSummaryImplCopyWith<_$SpeechSessionSummaryImpl>
  get copyWith =>
      __$$SpeechSessionSummaryImplCopyWithImpl<_$SpeechSessionSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SpeechSessionSummaryImplToJson(this);
  }
}

abstract class _SpeechSessionSummary implements SpeechSessionSummary {
  const factory _SpeechSessionSummary({
    final String? audioPath,
    final String? transcriptPath,
    final Uri? webAudioUrl,
    final Uri? webTranscriptUrl,
  }) = _$SpeechSessionSummaryImpl;

  factory _SpeechSessionSummary.fromJson(Map<String, dynamic> json) =
      _$SpeechSessionSummaryImpl.fromJson;

  @override
  String? get audioPath;
  @override
  String? get transcriptPath;
  @override
  Uri? get webAudioUrl;
  @override
  Uri? get webTranscriptUrl;

  /// Create a copy of SpeechSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpeechSessionSummaryImplCopyWith<_$SpeechSessionSummaryImpl>
  get copyWith => throw _privateConstructorUsedError;
}
