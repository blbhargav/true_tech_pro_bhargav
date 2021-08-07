import 'package:flutter/material.dart';
import 'package:true_tech_pro_bhargav/db/repository.dart';
import 'package:true_tech_pro_bhargav/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Repository _repository = Repository();
  runApp(MyApp(_repository));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Repository repository;
  MyApp(this.repository);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(repository: repository,),
    );
  }
}

