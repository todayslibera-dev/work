import 'package:get_it/get_it.dart';

import '../../application/usecases/cancel_session.dart';
import '../../application/usecases/complete_session.dart';
import '../../application/usecases/get_transcription_stream.dart';
import '../../application/usecases/push_audio_chunk.dart';
import '../../application/usecases/save_transcript.dart';
import '../../application/usecases/start_session.dart';
import '../../domain/repositories/i_document_repository.dart';
import '../../domain/repositories/i_speech_streaming_repository.dart';
import '../../domain/services/i_audio_recording_service.dart'; // Added
import '../../infrastructure/datasources/clova_api_datasource.dart';
import '../../infrastructure/datasources/i_clova_api_datasource.dart';
import '../../infrastructure/datasources/i_local_file_datasource.dart';
import '../../infrastructure/datasources/local_file_datasource.dart';
import '../../infrastructure/repositories/document_repository.dart';
import '../../infrastructure/repositories/speech_streaming_repository.dart';
import '../../infrastructure/services/audio_recording_service.dart'; // Added

import '../../presentation/state/controllers/speech_session_controller.dart';

final sl = GetIt.instance;

void setupLocator(String apiKey) {
  // Controllers
  sl.registerFactory(
    () => SpeechSessionController(
      apiKey: apiKey,
      startSessionUseCase: sl(),
      getTranscriptionStreamUseCase: sl(),
      pushAudioChunkUseCase: sl(),
      completeSessionUseCase: sl(),
      cancelSessionUseCase: sl(),
      saveTranscriptUseCase: sl(),
      audioRecordingService: sl(), // Modified
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => StartSessionUseCase(sl()));
  sl.registerLazySingleton(() => GetTranscriptionStreamUseCase(sl()));
  sl.registerLazySingleton(() => PushAudioChunkUseCase(sl()));
  sl.registerLazySingleton(() => CompleteSessionUseCase(sl()));
  sl.registerLazySingleton(() => CancelSessionUseCase(sl()));
  sl.registerLazySingleton(() => SaveTranscriptUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ISpeechStreamingRepository>(
      () => SpeechStreamingRepository(sl()));
  sl.registerLazySingleton<IDocumentRepository>(() => DocumentRepository(sl()));

  // Data Sources
  sl.registerLazySingleton<IClovaApiDataSource>(
      () => ClovaApiDataSource(apiKey: apiKey));
  sl.registerLazySingleton<ILocalFileDataSource>(() => LocalFileDataSource());

  // Services
  sl.registerLazySingleton<IAudioRecordingService>(() => AudioRecordingService()); // Added
}
