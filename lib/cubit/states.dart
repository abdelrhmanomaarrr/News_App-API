abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class GetBusinessLoadingState extends NewsStates{}

class GetBusinessSuccessState extends NewsStates{}

class GetBusinessErrorState extends NewsStates{
  GetBusinessErrorState(String string);
}


class GetSportLoadingState extends NewsStates{}

class GetSportSuccessState extends NewsStates{}

class GetSportErrorState extends NewsStates{
  GetSportErrorState(String string);
}

class GetScienceLoadingState extends NewsStates{}

class GetScienceSuccessState extends NewsStates{}

class GetScienceErrorState extends NewsStates{
  GetScienceErrorState(String string);
}
class NewsChangeMode extends NewsStates{}

class GetSearchLoadingState extends NewsStates{}

class GetSearchSuccessState extends NewsStates{}

class GetSearchErrorState extends NewsStates{
  final String error;
  GetSearchErrorState(this.error);

}

