import 'package:flutter/material.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/Navigations.dart';
import 'package:youtube_clone/screens/auth/login_screen.dart';
import 'package:youtube_clone/screens/home_screen.dart';
import 'package:youtube_clone/screens/profile_screen.dart';
import 'package:youtube_clone/screens/widgets/video_player.dart';

class RouteGenerator {
  static const String home = '/home';
  static const String login = '/login';
  static const String nav = '/nav';
  // static const String signup = '/signup';
  static const String video = '/video';

  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _getPageRoute(LoginScreen());
      case home:
        return _getPageRoute(const HomeScreen());
      case nav:
        return _getPageRoute(const NavigationScreen());

      case profile:
        return _getPageRoute(const ProfileScreen());
      case video:
        {
          final args = settings.arguments as Map<String, dynamic>;
          return _getPageRoute(VideoPlayer(video: args['video'] as VideoModel));
        }

      default:
        return _getPageRoute(errorScreen());
    }
  }

  static PageRouteBuilder _getPageRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static Widget errorScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error Screen'),
          ],
        ),
      ),
    );
  }
}
