import 'package:contact_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'cubit/contact_cubit.dart';
import 'data/models/contact_model.dart';
import 'layouts/add_task_layout.dart';
import 'layouts/home_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  final myBox = await Hive.openBox<ContactModel>("contactBox");
  runApp(MyApp(contactBox: myBox));
}

class MyApp extends StatelessWidget {
  final Box<ContactModel> contactBox;

  MyApp({required this.contactBox});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          BlocProvider(create: (context) => ContactCubit(contactBox)),
      ],
      child: Builder(
          builder: (context){
           return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: Provider.of<ThemeProvider>(context).currentTheme,
              home:  Home(),
              routes: {
                "/AddTask" : (context)  => AddTask(),
                "/Home" : (context)  => Home(),
              },
            );
          }),
    );
  }
}

