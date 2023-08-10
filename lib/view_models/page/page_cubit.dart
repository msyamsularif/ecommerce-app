import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(const PageState());

  void changeIndexPage(int index) {
    emit(PageState(currentIndexPage: index));
  }
}
