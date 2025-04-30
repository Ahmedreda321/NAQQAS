import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqqas/core/extensions/navigation_extensions.dart';
import '../../../../core/routing/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) =>
                    setState(() => isLastPage = index == 2),
                children: const [
                  OnboardPage(
                      title: 'Welcome', description: 'This is onboarding 1'),
                  OnboardPage(
                      title: 'Explore', description: 'This is onboarding 2'),
                  OnboardPage(
                      title: 'Start', description: 'This is onboarding 3'),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isLastPage) {
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                  context.pushNamed(Routes.loginScreen);
                },
                child: Text(isLastPage ? 'Get Started' : 'Next'),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String title;
  final String description;
  const OnboardPage(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flutter_dash, size: 120.r),
          SizedBox(height: 20.h),
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
