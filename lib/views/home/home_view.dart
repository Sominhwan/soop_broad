
import 'package:flutter/material.dart';
import 'package:soop_broad/common/loading/skeleton_loading.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{
  // TabController 추가
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 탭 컨트롤러 초기화
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    // 탭 컨트롤러 정리
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
              const Center(child: Text('좋아요')),
              const Center(child: Text('프로필')),
            ],
          )
        )
      ],
    );
  }
}
