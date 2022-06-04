

import 'package:bloc/bloc.dart';
import 'package:final_pro/modules/successlistcubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SucessListCubit extends Cubit<SuccessListStates>{
  SucessListCubit() : super(SuccessListInitialStates());


  static SucessListCubit get(context)=>BlocProvider.of(context);
  bool ispassword=true;
  bool ispassword2=true;

  bool checkfirst(){
    ispassword=!ispassword;
  emit(SuccessListChangePasswordFirstState());
  print('ispassword: '+ispassword.toString());
  return ispassword;
  }

  void checksecond(){
    ispassword2=!ispassword2;
  emit(SuccessListChangePasswordSecondState());
    print('ispassword2: '+ispassword2.toString());
  }

}