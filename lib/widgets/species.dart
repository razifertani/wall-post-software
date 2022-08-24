import 'package:flutter/material.dart';
import 'package:swapi_dev/models/apiResultModel.dart';

class Species extends StatefulWidget {
  const Species({
    Key? key,
    required this.apiResult,
    required this.index,
  }) : super(key: key);

  final ApiResult? apiResult;
  final int index;

  @override
  State<Species> createState() => _SpeciesState();
}

class _SpeciesState extends State<Species> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.apiResult!.results![widget.index].color,
      elevation: 1.5,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text('Name: ${widget.apiResult!.results![widget.index].name}'),
        subtitle: Text('Designation: ${widget.apiResult!.results![widget.index].designation}\nClassification: ${widget.apiResult!.results![widget.index].classification}'),
      ),
    );
  }
}
