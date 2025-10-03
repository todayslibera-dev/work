import 'package:grpc/grpc_web.dart';
import 'package:grpc/service_api.dart' as grpc;

grpc.ClientChannel createClientChannel(String host, int port) {
  // For web, connect to the Netlify serverless function proxy.
  // The path is relative to the deployed web app.
  return GrpcWebClientChannel.xhr(Uri.parse('/.netlify/functions/proxy'));
}
