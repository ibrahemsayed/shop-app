abstract class ShopStates{}

class InitialState extends ShopStates{}
class ChangeBottomNavigationState extends ShopStates{}


class GetHomeDataLoadingState extends ShopStates{}
class GetHomeDataSuccessState extends ShopStates{}
class GetHomeDataErrorState extends ShopStates{}


class GetCategoryDataLoadingState extends ShopStates{}
class GetCategoryDataSuccessState extends ShopStates{}
class GetCategoryDataErrorState extends ShopStates{}


//*****  FAVORITE STATES   *****/
class GetFavoriteDataLoadingState extends ShopStates{}
class GetFavoriteDataSuccessState extends ShopStates{}
class GetFavoriteDataErrorState extends ShopStates{}

//*****  TOGGLE FAVORITE STATES   *****/
class ToggleFavoriteLoadingState extends ShopStates{}
class ToggleFavoriteSuccessState extends ShopStates{}
class ToggleFavoriteErrorState extends ShopStates{}