
import 'dart:developer';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../views/app_constants.dart';
import '../navigation_service.dart';

class BaseApi {
  static final baseDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 3),
      baseUrl: appEnv.url,
    )
  ) ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('onResponse');
        return switch (response) {
          Response(
          requestOptions: RequestOptions(responseType: ResponseType.json),
          data: {'code': != 200}
          ) =>
          throw DioException(
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
            response: response,
          ),
          _ => handler.next(response)
        };
      },
      onError: (error, handler) async {
        if (error
        case DioException(
        requestOptions: RequestOptions(extra: {'retried': != true}),
        response: Response(data: {'code': 401})
        )) {}
        log('onError');
        log('${error.message}');
        log('${error.response?.data}');
        final context = NavigationService.globalCtx!;
        final String message = switch (error) {
          DioException(response: Response(data: {'msg': String msg}))
          when msg.trim().isNotEmpty => msg.trim(),
          DioException(
          type: DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.connectionError) =>
          '네트워크 연결이 불안정합니다.',
          DioException(
          type: DioExceptionType.receiveTimeout) =>
          '서버 응답 시간을 초과하였습니다.',
          _ => error.message ?? '서버 연결이 불안정합니다.'
        };
        // FirebaseCrashlytics.instance.recordError(error, error.stackTrace);
        // TODO 추후 수정 api 에러시 메시지 출력함

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: message,
          ),
          displayDuration: const Duration(seconds: 10),
        );
        return handler.next(error);
      },
    ));

  // static final _refreshDio = Dio(BaseOptions(
  //   connectTimeout: const Duration(seconds: 30),
  //   receiveTimeout: const Duration(minutes: 3),
  //   baseUrl: appEnv.url,
  // ));

  // static final _refreshCache = AsyncCache<void>.ephemeral();

  // static Future<void> _tokenRefresh() {
  //   return _refreshCache.fetch(
  //         () => _refreshDio.post(
  //       '/com/reissueToekn',
  //       data: {
  //         'userCd': UserInfo().userCd,
  //         'refreshToken': UserInfo().refreshToken,
  //       },
  //     ).then(
  //           (response) {
  //         if (response.data
  //         case {
  //         'accessToken': String accessToken,
  //         'refreshToken': String refreshToken,
  //         }) {
  //           UserInfo().tokenRefresh(accessToken, refreshToken);
  //         } else {
  //           throw DioException(
  //             type: DioExceptionType.badResponse,
  //             requestOptions: response.requestOptions,
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  // static Future<Response> _retry(RequestOptions requestOptions) {
  //   return baseDio.fetch(requestOptions..extra['retried'] = true);
  // }
}
