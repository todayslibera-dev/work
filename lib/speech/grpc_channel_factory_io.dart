// lib/speech/grpc_channel_factory_io.dart
import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as grpc;

grpc.ClientChannel createClientChannel(String host, int port) {
  return ClientChannel(
    host,
    port: port,
    options: const ChannelOptions(
      credentials: ChannelCredentials.secure(),
    ),
  );
}
