import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nawgati_calc/controller/notifier.dart';
import 'package:nawgati_calc/models/provider_models/history.dart';
import 'package:nawgati_calc/utils/consts.dart';
import 'package:provider/provider.dart';

import '../utils/buttonUtils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final ScrollController _controller = ScrollController();

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Consumer<CalProvider>(builder: (context, provider, child) {
                    return SizedBox(
                      height: height * .35,
                      // width: 30,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () {
                              provider.deleteHistory();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, bottom: 10),
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.grey[700],
                              ),
                            ),
                          )),
                    );
                  }),
                  Expanded(
                    child: SizedBox(
                        height: height * .35,
                        child: Consumer<CalProvider>(
                          builder: (context, provider, child) {
                            return ListView.separated(
                              controller: _controller,
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(10.0),
                              itemCount: provider.history.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 10),
                              itemBuilder: (BuildContext context, int i) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0, top: 8),
                                            child: Text(
                                              provider.history[i].res,
                                              textAlign: TextAlign.end,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(fontSize: 18),
                                            ),
                                          ),
                                          Text(
                                            provider.history[i].calculations,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )),
                  ),
                ],
              ),
              Container(
                color: Colors.black,
                width: width,
                // height: 130,
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: width * 0.06,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20.0,
                      child: ListView(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Consumer<CalProvider>(
                            builder: (context, ex, child) => Text(
                              ex.expression,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 21),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Consumer<CalProvider>(
                      builder: (context, ex, child) => Text(
                        ex.result,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  width: double.infinity,
                  color: greyish,
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    // physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 1.15,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 4,
                    children: buttons,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
