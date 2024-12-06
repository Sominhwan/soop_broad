
import '../../../utils/api/base_api.dart';

class MoreApi {
  MoreApi._internal();

  static final MoreApi _instance = MoreApi._internal();

  factory MoreApi() {
    return _instance;
  }

  final _dio = BaseApi.baseDio;

  Future<String> getNotice(Map<String, dynamic> params) async {
    try {
      await _dio.get('/api/m/getEmergencyGuideMapManage', queryParameters: params);

      return 'test';
    } finally {}
  }
}
