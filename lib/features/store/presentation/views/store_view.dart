import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/core/utils/api_service.dart';
import 'package:sawah/features/store/data/repo/procat_repo_imple.dart';
import 'package:sawah/features/store/presentation/manager/cubit/product_cat_cubit.dart';
import 'package:sawah/features/store/presentation/views/widgets/storeviewbody.dart';

class StoreView extends StatelessWidget {
  StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              ProductCatCubit(ProcatRepoImple(ApiService(Dio())))
                ..fetchCategories()),
    ], child: Storeviewbody());
  }
}
