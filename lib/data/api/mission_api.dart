import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/mission_response.dart';
import '../../domain/entities/mission_completion.dart';

part 'mission_api.g.dart';

@riverpod
MissionApi missionApi(MissionApiRef ref) {
  final dio = Dio();
  return MissionApi(dio);
}

class MissionApi {
  final Dio _dio;

  MissionApi(this._dio) {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      validateStatus: (status) => status != null && status < 500,
      baseUrl: 'https://izzmxmcjs5.execute-api.us-east-1.amazonaws.com/default',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // print('API 요청 URL: \\${options.uri}');
        // print('API 요청 메서드: \\${options.method}');
        // print('API 요청 헤더: \\${options.headers}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // print('API 응답 상태 코드: \\${response.statusCode}');
        // print('API 응답 데이터: \\${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // print('API 에러 발생: \\${e.message}');
        // print('API 에러 타입: \\${e.type}');
        // if (e.response != null) {
        //   print('API 에러 응답: \\${e.response?.data}');
        // }
        return handler.next(e);
      },
    ));
  }

  Future<MissionResponse> completeMission(String mission) async {
    try {
      final completion = MissionCompletion(
        mission: mission,
        createDt: DateTime.now().toUtc(),
        userId: 'test',
      );

      final response = await _dio.post(
        '/mission/mission_completed',
        data: completion.toJson(),
        options: Options(
          followRedirects: true,
          maxRedirects: 5,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 201) {
        return MissionResponse.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: '미션 완료에 실패했습니다',
        );
      }
    } on DioException catch (e) {
      throw Exception('미션 완료에 실패했습니다: \\${e.message}');
    } catch (e) {
      throw Exception('미션 완료에 실패했습니다.');
    }
  }
} 