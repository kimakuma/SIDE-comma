import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/mission_completion.dart';
import '../../domain/entities/mission_response.dart';

part 'mission_api.g.dart';

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
  }

  Future<MissionResponse> completeMission(String mission) async {
    try {
      final requestData = MissionCompletion(
        mission: mission,
        createDt: DateTime.now().toUtc(),
        userId: 'test',
      );
      
      print('API 요청 데이터: ${requestData.toJson()}');
      
      final response = await _dio.post(
        '/mission/mission_completed',
        data: requestData.toJson(),
      );
      
      print('API 응답 상태 코드: ${response.statusCode}');
      print('API 응답 데이터: ${response.data}');

      return MissionResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('API 에러 발생: $e');
      print('에러 타입: ${e.type}');
      print('에러 메시지: ${e.message}');
      if (e.response != null) {
        print('에러 응답 데이터: ${e.response?.data}');
        print('에러 상태 코드: ${e.response?.statusCode}');
      }
      throw Exception('미션 완료에 실패했습니다: ${e.message}');
    } catch (e) {
      print('예상치 못한 에러 발생: $e');
      throw Exception('미션 완료에 실패했습니다.');
    }
  }
}

@riverpod
MissionApi missionApi(MissionApiRef ref) {
  final dio = Dio();
  return MissionApi(dio);
} 