

import 'package:bloc/bloc.dart';
import 'package:final_pro/modules/successlistcubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SucessListCubit extends Cubit<SuccessListStates>{
  SucessListCubit() : super(SuccessListInitialStates());


  static SucessListCubit get(context)=>BlocProvider.of(context);

bool isDark=false;

void changeappmode(){
  isDark=!isDark;
emit(SuccessListAppModeChangeState());
}




}