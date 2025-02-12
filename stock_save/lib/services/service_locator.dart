import 'package:get_it/get_it.dart';
import 'package:stok_takip/services/stok_service.dart';


final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<StokService>(StokService());
}