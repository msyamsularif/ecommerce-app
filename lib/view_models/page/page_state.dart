part of 'page_cubit.dart';

class PageState extends Equatable {
  final int currentIndexPage;
  const PageState({this.currentIndexPage = 0});

  @override
  List<Object> get props => [currentIndexPage];
}
