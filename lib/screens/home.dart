import 'package:flutter/material.dart';
import 'package:swapi_dev/services/api.dart';
import 'package:swapi_dev/models/apiResultModel.dart';
import 'package:swapi_dev/widgets/constants/errork.dart';
import 'package:swapi_dev/widgets/constants/loadingk.dart';
import 'package:swapi_dev/widgets/species.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController controller = ScrollController();
  ApiResult? apiResult;
  bool _isFirstLoadRunning = true;
  String firstLink = "https://swapi.dev/api/species/?page=1&format=json";
  String? nextLink;
  bool _isLoadMoreRunning = false;
  bool _isError = false;

  void _firstLoad() async {
    getSpecies(link: firstLink).then((exceptionOrResult) {
      exceptionOrResult.fold(
        (exception) {
          setState(() {
            _isError = true;
          });
        },
        (result) {
          setState(() {
            apiResult = result;
            _isFirstLoadRunning = false;
            nextLink = result.next as String;
          });
        },
      );
    });
  }

  void _loadMore() async {
    if (nextLink != null && controller.position.pixels == controller.position.maxScrollExtent && _isLoadMoreRunning == false) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      getSpecies(link: nextLink!).then((exceptionOrResult) {
        exceptionOrResult.fold(
          (exception) {
            setState(() {
              _isError = true;
            });
          },
          (result) {
            setState(() {
              apiResult!.results!.addAll(result.results ?? []);
              nextLink = result.next;
              _isLoadMoreRunning = false;
            });
          },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    controller.addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _isFirstLoadRunning
          ? LoadingK()
          : SafeArea(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  Text(apiResult!.results!.length.toString()),
                  SizedBox(height: screenHeight * 0.025),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _firstLoad();
                      },
                      child: ListView.builder(
                        controller: controller,
                        itemCount: apiResult!.results!.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                apiResult!.results![index].color == Colors.white ? apiResult!.results![index].color = Colors.green : apiResult!.results![index].color = Colors.white;
                              });
                            },
                            child: Species(apiResult: apiResult, index: index),
                          );
                        },
                      ),
                    ),
                  ),
                  if (_isLoadMoreRunning == true) LoadingK(),
                  if (_isError == true) ErrorK(),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_loadMore);
    super.dispose();
  }
}
