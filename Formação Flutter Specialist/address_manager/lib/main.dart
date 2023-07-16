import 'package:address_manager/pages/home_page.dart';
import 'package:address_manager/persistence/graphql.dart';
import 'package:address_manager/utils/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: GetMaterialApp(
          title: 'Address Manager',
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
