// ignore_for_file: non_constant_identifier_names, camel_case_types

class HomeStates {}

class HomeInitState extends HomeStates {}

class VisibleState extends HomeStates {}

class RegisterLoadingState extends HomeStates {}

class RegisterSuccessState extends HomeStates {}

class RegisterErrorState extends HomeStates {}

class LoginUserLoadingState extends HomeStates {}

class LoginUserSuccessState extends HomeStates {
  final String? user_id;

  LoginUserSuccessState(this.user_id);
}

class LoginUserErrorState extends HomeStates {}

class CreatUserLoadingState extends HomeStates {}

class CreatUserSuccessState extends HomeStates {}

class CreatUserErrorState extends HomeStates {}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class GetProfileImageLoadingState extends HomeStates {}

class GetProfileImageSuccessState extends HomeStates {}

class GetProfileImageErrorState extends HomeStates {}

class uploadProfileImageLoadingState extends HomeStates {}

class uploadProfileImageSuccessState extends HomeStates {}

class uploadProfileImageErrorState extends HomeStates {}

class GetCoverImageLoadingState extends HomeStates {}

class GetCoverImageSuccessState extends HomeStates {}

class GetCoverImageErrorState extends HomeStates {}

class uploadCoverImageLoadingState extends HomeStates {}

class uploadCoverImageSuccessState extends HomeStates {}

class uploadCoverImageErrorState extends HomeStates {}

class updateUserDataLoadingState extends HomeStates {}

class updateUserDataSuccessState extends HomeStates {}

class updateUserDataErrorState extends HomeStates {}

//post
class CreatPostLoadingState extends HomeStates {}

class CreatPostSuccessState extends HomeStates {}

class CreatPostErrorState extends HomeStates {}

class GetPostImageLoadingState extends HomeStates {}

class GetPostImageSuccessState extends HomeStates {}

class GetPostImageErrorState extends HomeStates {}

class RemovePostImageState extends HomeStates {}

class GetAllPostsLoadingState extends HomeStates {}

class GetAllPostsSuccessState extends HomeStates {}

class GetAllPostsErrorState extends HomeStates {}

class uploadPostImageLoadingState extends HomeStates {}

class uploadPostImageSuccessState extends HomeStates {}

class uploadPostImageErrorState extends HomeStates {}

class LikePostLoadingState extends HomeStates {}

class LikePostSuccessState extends HomeStates {}

class LikePostErrorState extends HomeStates {}

class CommentPostLoadingState extends HomeStates {}

class CommentPostSuccessState extends HomeStates {}

class CommentPostErrorState extends HomeStates {}

class GetCommmentPostLoadingState extends HomeStates {}

class GetCommmentPostSuccessState extends HomeStates {}

class GetCommmentPostErrorState extends HomeStates {}

// * get all Users

class GetAllUsersLoadingState extends HomeStates {}

class GetAllUsersSuccessState extends HomeStates {}

class GetAllUsersErrorState extends HomeStates {}

class CreateMessageLoadingState extends HomeStates{}

class CreateMessageSuccessState extends HomeStates {}

class CreateMessageErrorState extends HomeStates {}

class GetMessageLoadingState extends HomeStates {}

class GetMessageSuccessState extends HomeStates {}

class ChangeTextMessage extends HomeStates {}



class ChangeButtonBarState extends HomeStates {}
