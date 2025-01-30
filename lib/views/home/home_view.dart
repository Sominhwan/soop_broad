
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soop_broad/common/loading/skeleton_loading.dart';
import 'package:soop_broad/utils/notification/local/local_notification.dart';
import 'package:soop_broad/utils/permission/permission_handler.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(child: Text('홈')),
            Tab(child: Text('좋아요')),
            Tab(child: Text('프로필')),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              SkeletonLoading().mainSkeletonLoader(),
              const LikeTab(),
              const Center(child: Text('프로필')),
            ],
          )
        )
      ],
    );
  }
}

class LikeTab extends StatefulWidget {
  const LikeTab({super.key});

  @override
  State<LikeTab> createState() => _LikeTabState();
}

class _LikeTabState extends State<LikeTab> with AutomaticKeepAliveClientMixin {
  final PermissionsHandler permissionsHandler = PermissionsHandler();

  void _permissionWithNotification() async {
    if (await Permission.notification.isDenied && !await Permission.notification.isPermanentlyDenied) {
      await permissionsHandler.requestNotificationPermission();
    }
  }

  void _permissionWithExactNotification() async {
    if (await Permission.scheduleExactAlarm.isDenied && !await Permission.scheduleExactAlarm.isPermanentlyDenied) {
      await permissionsHandler.requestExactNotificationPermission();
    }
  }
  
  @override
  void initState() {
    super.initState();
    LocalNotification().initialization();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _permissionWithNotification(),
          child: const Text('알림권한 허락'),
        ),
        ElevatedButton(
          onPressed: () {
            _permissionWithExactNotification();
          },
          child: const Text('정확한 알림권한 허락'),
        ),
        ElevatedButton(
          onPressed: () {
            LocalNotification().sendMessage(
              channelId: 'channel_id',
              id: 1,
              foregroundAlarm: false,
              ongoing: true,
              autoCancel: false,
              subText: '오늘의 알림',
              showWhen: false,
              title: '타이틀',
              content: '내용',
              payload: '텍스트 메시지 입니다.'
            );
          },
          child: const Text('메시지 전송'),
        ),
        ElevatedButton(
          onPressed: () async {
            LocalNotification().initializationTime();
          },
          child: const Text('시간별 메시지 전송'),
        ),
        ElevatedButton(
          onPressed: () async {
            await permissionsHandler.openAppSettingsScreen();
          },
          child: const Text('권한 설정 열기'),
        ),
        ElevatedButton(
          onPressed: () {
            LocalNotification().cancel(1);
          },
          child: const Text('알림 취소')
        ),
        ElevatedButton(
          onPressed: () {
            LocalNotification().cancelAll();
          },
          child: const Text('알림 전체 취소')
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

