import 'package:firebase_project/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static GoRouter get router => GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, state) => const HomeScreen(),
          ),
        ],
      );
}
