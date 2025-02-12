
import 'package:get_it/get_it.dart';
import 'package:proje4/services/stok_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<StokService>(StokService());
}