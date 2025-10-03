// lib/speech/grpc_channel_factory.dart
import 'package:grpc/grpc.dart';

// Conditional import for platform-specific channel creation
// This will import either grpc_channel_factory_io.dart or grpc_channel_factory_web.dart
// and expose their 'createClientChannel' function.
export 'grpc_channel_factory_io.dart' if (dart.library.html) 'grpc_channel_factory_web.dart';

// The actual function signature is defined in the exported files.
// This file just acts as a switcher.
