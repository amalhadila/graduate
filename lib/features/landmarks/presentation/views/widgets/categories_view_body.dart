import 'package:flutter/material.dart';
import 'package:sawah/features/landmarks/presentation/views/widgets/cat_grid.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CategoriesGrid());
  }
}
