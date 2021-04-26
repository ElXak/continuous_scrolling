import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../view_models/home_view_model.dart';
import '../widgets/creation_aware_list_item.dart';
import '../widgets/list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(
          builder: (context, model, child) => ListView.builder(
              itemCount: model.items.length,
              itemBuilder: (context, index) => CreationAwareListItem(
                    itemCreated: () {
                      SchedulerBinding.instance.addPostFrameCallback(
                          (duration) => model.handleItemCreated(index));
                    },
                    child: ListItem(
                      title: model.items[index],
                    ),
                  )),
        ),
      ),
    );
  }
}
