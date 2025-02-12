import 'package:flutter/material.dart';

import 'package:proje4/providers/stok_providers.dart';
import 'package:proje4/widgets/stok_filter.dart';

import 'package:proje4/widgets/stok_list.dart';
import 'package:provider/provider.dart';

class StokList extends StatefulWidget {
  const StokList({super.key});

   @override
  State<StatefulWidget> createState() {
    return _StokListState();
  }
}

  class _StokListState extends State<StokList>{

  @override
  void initState() {
     super.initState();
      context.read<StokProvider>().getStokListesi();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StokProvider(),
      child: DefaultTabController(
        length: 2,
        child: Builder(
          builder: (context) {
               final TabController controller = DefaultTabController.of(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                   if (controller.index == 0) {
                    controller.animateTo(1);
                  } else if (controller.index == 1) {
                    controller.animateTo(0);
                  }
                  },
                ),
                actions: [
                  ElevatedButton(
                    
                    onPressed: () {
                       context.read<StokProvider>().showCustomDialog(context);
                      // Provider'dan getStokListesi metodunu çağır
                      context.read<StokProvider>().getStokListesi();
                       controller.animateTo(0);
                       
                    },
                    child: const Text('Listele'),
                  ),
                ],
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Liste'),
                    Tab(text: 'Filtre'),
                  ],
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.white,
                ),
              ),
              body: const TabBarView(
                children: [
                  Liste(),
                  StokFiltre(),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
  

}

