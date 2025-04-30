import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqqas/core/extensions/navigation_extensions.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/strings_constants.dart';
import '../../../../core/routing/routes.dart';
import '../cubit/auth_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    context.pushNamed(Routes.homeScreen);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            context.read<AuthCubit>().authWithGoogle();
                          },
                    child: state is AuthLoading
                        ? const Text(AppStrings.loading)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(AppStrings.signIn),
                              SvgPicture.asset(
                                Assets.assetsSvgsIconsGoogleIcon,
                                width: 35.w,
                              )
                            ],
                          ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
