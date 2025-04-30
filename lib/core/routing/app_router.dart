import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../routing/routes.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../screens/error_route_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return _createRoute(const OnboardingScreen());
      case Routes.loginScreen:
        return _createRoute(BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignUpScreen(),
        ));
      case Routes.homeScreen:
        return _createRoute(BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomeScreen(),
        ));

      default:
        return _createRoute(const ErrorRoute());
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
