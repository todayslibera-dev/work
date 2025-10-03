/// Domain event representing a piece of transcribed text.
/// - [text]: recognized text (may be partial or final)
/// - [isFinal]: true when the piece is finalized by the ASR service
/// - [timestamp]: optional logical time for the end of this piece
/// - [position]: optional ordering hint when service sends segmented chunks
class TranscriptionPiece {
  const TranscriptionPiece({
    required this.text,
    required this.isFinal,
    this.timestamp,
    this.position,
  });

  final String text;
  final bool isFinal;
  final Duration? timestamp;
  final int? position;
}

