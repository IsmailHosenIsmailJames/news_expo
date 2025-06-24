import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_expo/src/screens/cubit/home_cubit.dart';
import 'package:news_expo/src/screens/cubit/home_state.dart';
import 'package:news_expo/src/screens/home/home_page.dart';
import 'package:news_expo/src/theme/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => HomeCubit())],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => MaterialApp(
          theme: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
          ),
          themeMode: ThemeMode.light,
          home: HomePage(initSearchKeyword: "tesla"),
        ),
      ),
    );
  }
}
