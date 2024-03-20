import 'package:cinema_app/ui/widgets/app/my_app.dart';
import 'package:cinema_app/ui/widgets/app/my_app_model.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  final app = MyApp(model: model);
  runApp(app);
}
