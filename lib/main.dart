import 'package:agtech/core/inject/inject.dart';
import 'package:flutter/material.dart';

import 'myapp.dart';

void main() {
  Inject.init();
  runApp(const MyApp());
}
