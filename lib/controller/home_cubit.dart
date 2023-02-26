// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors, unused_local_variable, avoid_function_literals_in_foreach_calls, unnecessary_brace_in_string_interps, curly_braces_in_flow_control_structures, await_only_futures

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_states.dart';
import 'package:myjob/module/chat_model.dart';
import 'package:myjob/module/comment_model.dart';
import 'package:myjob/module/post_model.dart';
import 'package:myjob/module/user_model.dart';
import 'package:myjob/screens/add_jop_screen.dart';
import 'package:myjob/screens/jop_screen.dart';
import 'package:myjob/screens/setting_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myjob/screens/caht/users_chat.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_off;
  bool showPassword = true;
  void ChangePasswordVisibility() {
    showPassword = !showPassword;
    suffix = showPassword ? Icons.visibility_off : Icons.visibility;
    emit(VisibleState());
  }

  Future registerUser({
    String? name,
    String? emailAddress,
    String? password,
    String? phone,
  }) async {
    emit(RegisterLoadingState());
    print("RegisterLoadingState");
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      )
          .then((value) {
        createUser(
            name: name,
            email: emailAddress,
            password: password,
            phone: phone,
            uid: value.user!.uid);
        emit(RegisterSuccessState());
        print("RegisterSuccessState");
        print(value.user);
        print(value.user!.uid);
        // uidUser = credential.user!.uid;
      }).catchError((error) {
        print("RegisterErrorState $error");
        emit(RegisterErrorState());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginUser({
    String? emailAddress,
    String? password,
  }) async {
    try {
      emit(LoginUserLoadingState());
      print("LoginUserLoadingState");
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      )
          .then((value) {
        print("Login User id ${value.user!.uid}");

        emit(LoginUserSuccessState(value.user!.uid));
        print("LoginUserSuccessState");
      }).catchError((error) {
        print("LoginUserErrorState $error");
        emit(LoginUserErrorState());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void createUser({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? uid,
  }) {
    emit(CreatUserLoadingState());
    print("CreatUserLoadingState");
    UserModel userModel = UserModel(
        name: name, mail: email, password: password, phone: phone, uid: uid);
    // final value =
    FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      emit(CreatUserSuccessState());
      print("CreatUserSuccessState");
    }).catchError((error) {
      print(error);
      emit(CreatUserErrorState());
      print("CreatUserErrorState");
    });
  }

  UserModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    print("GetUserDataLoadingState");

    FirebaseFirestore.instance
        .collection("user")
        .doc(uidUser)
        .get()
        .then((value) {
      print("User Data is : ${value.data()}");
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.mail);
      print("***********************");
      emit(GetUserDataSuccessState());
      print("GetUserDataSuccessState");
    }).catchError((error) {
      print(error);
      print("GetUserDataErrorState ${error.toString()}");
    });
  }

  File? profileImgeUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> getImageProfile() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImgeUrl = File(image.path);
      uploadProfileImage();
      emit(GetProfileImageSuccessState());
      print("GetProfileImageSuccessState");
    } else {
      print("no image sellected");
      emit(GetProfileImageErrorState());
    }
  }

  Future<void> uploadProfileImage() async {
    print("uploadProfileImageLoadingState");
    emit(uploadProfileImageLoadingState());
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child("images/${Uri.file(profileImgeUrl!.path).pathSegments.last}");
      final value = await storage.putFile(profileImgeUrl!);
      final lastValueUrl = await value.ref.getDownloadURL();
      print(lastValueUrl);
      updateUserData(profileImage: lastValueUrl);
      print("uploadProfileImageSuccessState");
      emit(uploadProfileImageSuccessState());
    } catch (e) {
      print("uploadProfileImageErrorState ${e.toString()}");
      emit(uploadProfileImageErrorState());
    }
  }

  File? converImgeUrl;
  Future<void> getCoverImage() async {
    emit(GetCoverImageLoadingState());
    print("GetCoverImageLoadingState");
    final coverImage = await _picker.pickImage(source: ImageSource.gallery);
    if (coverImage != null) {
      converImgeUrl = File(coverImage.path);
      uploadCoverImage();
      emit(GetCoverImageSuccessState());
      print("GetCoverImageSuccessState");
    } else {
      print("no image sellected");
      emit(GetCoverImageErrorState());
    }
  }

  Future<void> uploadCoverImage() async {
    print("uploadCoverImageLoadingState");
    emit(uploadCoverImageLoadingState());
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child("images/${Uri.file(converImgeUrl!.path).pathSegments.last}");
      final value = await storage.putFile(converImgeUrl!);
      final lastValueUrl = await value.ref.getDownloadURL();
      print(lastValueUrl);
      updateUserData(coverImage: lastValueUrl);
      print("uploadCoverImageSuccessState");
      emit(uploadCoverImageSuccessState());
    } catch (e) {
      print("uploadCoverImageErrorState ${e.toString()}");
      emit(uploadCoverImageErrorState());
    }
  }

  Future<void> updateUserData({
    String? name,
    String? phone,
    String? bio,
    String? profileImage,
    String? coverImage,
  }) async {
    emit(updateUserDataLoadingState());
    print("updateUserDataLoadingState");
    // ignore: prefer_conditional_assignment

    UserModel model = UserModel(
      name: name ?? userModel!.name,
      mail: userModel!.mail,
      password: userModel!.password,
      phone: phone ?? userModel!.phone,
      bio: bio ?? userModel!.bio,
      uid: userModel!.uid,
      coverImage: coverImage ?? userModel!.coverImage,
      profileImage: profileImage ?? userModel!.profileImage,
    );

    await FirebaseFirestore.instance
        .collection("user")
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(updateUserDataSuccessState());
      print("updateUserDataSuccessState");
    }).catchError((error) {
      print(error);
      emit(updateUserDataErrorState());
      print("updateUserDataErrorState");
    });
  }

// * Create Postes
  void creatPost({
    String? text,
    String? imagePost,
    String? time,
  }) async {
    try {
      emit(CreatPostLoadingState());
      print("CreatPostLoadingState");
      PostModel postModel = PostModel(
        name: userModel!.name,
        uid: userModel!.uid,
        imageProfile: userModel!.profileImage,
        dateTime: time,
        imagepost: imagePost,
        text: text,
      );
      final value = await FirebaseFirestore.instance
          .collection("posts")
          .add(postModel.toMap());
      print("post id : ${value.id}");
      emit(CreatPostSuccessState());
      print("CreatPostSuccessState");
    } catch (e) {
      print("CreatPostErrorState ${e.toString()}");
      emit(CreatPostErrorState());
    }
  }

  File? postImageUrl;
  Future<void> getPostImage() async {
    emit(GetPostImageLoadingState());
    print("GetPostImageLoadingState");
    final coverImage = await _picker.pickImage(source: ImageSource.gallery);
    if (coverImage != null) {
      postImageUrl = File(coverImage.path);
      uploadPostImage();
      emit(GetPostImageSuccessState());
      print("GetPostImageSuccessState");
    } else {
      print("no image post sellected");
      emit(GetPostImageErrorState());
    }
  }

  String? lastImagePostUrl;
  Future<void> uploadPostImage() async {
    print("uploadPostImageLoadingState");
    emit(uploadPostImageLoadingState());
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child("images/${Uri.file(postImageUrl!.path).pathSegments.last}");
      final value = await storage.putFile(postImageUrl!);
      lastImagePostUrl = await value.ref.getDownloadURL();
      print(lastImagePostUrl);
      print("uploadPostImageSuccessState");
      emit(uploadPostImageSuccessState());
    } catch (e) {
      print("uploadPostImageErrorState ${e.toString()}");
      emit(uploadPostImageErrorState());
    }
  }

  void removePostImage() {
    postImageUrl = null;
    print(postImageUrl);
    emit(RemovePostImageState());
  }

  Future likePost(String postid) async {
    try {
      emit(LikePostLoadingState());
      print("LikePostLoadingState");
      final value = await FirebaseFirestore.instance
          .collection("posts")
          .doc(postid)
          .collection("like")
          .doc(userModel!.uid)
          .set({"like": true});
      emit(LikePostSuccessState());
      print("LikePostSuccessState");
      getLike(postid);
    } catch (e) {
      emit(LikePostErrorState());
      print("LikePostErrorState");
    }
  }

  // get all postes

  List<PostModel> posts = [];
  List<int> countLikes = [];
  // List<int> countComments = [];
  List<String> postsId = [];
  // List<CommentModel> commentText = [];
  Future getAllPosts() async {
    // commentText = [];
    // countComments = [];
    emit(GetAllPostsLoadingState());
    posts = [];
    postsId = [];
    countLikes = [];
    await FirebaseFirestore.instance
        .collection("posts")
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        element.reference.collection("like").get().then((value) => {
              countLikes.add(value.docs.length),
              postsId.add(element.id),
              posts.add(PostModel.fromJson(element.data())),
              emit(GetAllPostsSuccessState()),
              emit(GetAllPostsSuccessState()),
              print("GetAllPostsSuccessState"),
              print("post of leanght ${postsId.length}"),
              print("post id ${postsId}"),
              print(countLikes),
            });
      });
    });
    // .then((value) {
    //   value.docs.forEach((items) {
    //     postsId.add(items.id);
    //     print("post id ${postsId}");
    //     print("post of leanght ${postsId.length}");
    //     posts.add(PostModel.fromJson(items.data()));
    //     emit(GetAllPostsSuccessState());
    //     print("GetAllPostsSuccessState");
    //   items.reference
    //       .collection("like")
    //       .get()
    //       .then((value) => {
    //             countLikes.add(value.docs.length),
    //             postsId.add(items.id),
    //             posts.add(PostModel.fromJson(items.data())),
    //             emit(GetAllPostsSuccessState()),
    //           })
    //       .catchError((error) {
    //     print("GetAllPostsErrorState 1 $error");
    //     emit(GetAllPostsErrorState());
    //   });
    //   items.reference.collection("comments").get().then((value) {
    //     countComments.add(value.docs.length);
    //     print("countComments : ${countComments}");
    //     value.docs.forEach((element) {
    //       commentText.add(CommentModel.fromJson(element.data()));
    //     });
    //     print("*commentText${commentText.length}");
    //   }).catchError((error) {
    //     print("GetAllPostsErrorState 2 ${error.toString()}");
    //     emit(GetAllPostsErrorState());
    //   });
    //   });
    // }).catchError((error) {
    //   print("GetAllPostsErrorState ${error.toString()}");
    //   emit(GetAllPostsErrorState());
    // });
  }

  // ! try test
  // Future creapost(D) {
  //   PostModel PM = PostModel(
  //     dateTime: dateTime,
  //     imageProfile: imagprofile,
  //     imagepost: imagepost,
  //     name: name,
  //     postsId: idpost,
  //     text: text,

  //   );
  // }
  // ! end try test
  // bool isLike = true;

  // List<int> countLikes = [];
  Future getLike(String postid) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postid)
        .collection("like")
        .snapshots()
        .listen((event) {
      // countLikes.add(event.docs.length);
      event.docs.forEach((element) {
        print("like data ${element.data()}");
      });
      // print("count of likes ${countLikes.length}");
    });
  }

  // Future updateLikePost(String postid) async {
  //   try {
  //     isLike = !isLike;
  //     emit(UpdateLikePostLoadingState());
  //     print("UpdateLikePostLoadingState");
  //     final value = await FirebaseFirestore.instance
  //         .collection("posts")
  //         .doc(postid)
  //         .collection("like")
  //         .doc(userModel!.uid)
  //         .update({"like": isLike});

  //     emit(UpdateLikePostSuccessState());
  //     print("UpdateLikePostSuccessState");
  //   } catch (error) {
  //     emit(UpdateLikePostErrorState());
  //     print("UpdateLikePostErrorState ${error.toString()}");
  //   }
  // }

  // Future getLikePost(String postid) async {
  //   try {
  //     emit(GetLikePostLoadingState());
  //     print("GetLikePostLoadingState");
  //     final value = await FirebaseFirestore.instance
  //         .collection("posts")
  //         .doc(postid)
  //         .collection("like")
  //         .doc(userModel!.uid)
  //         .get();
  //     print("Git Like Post ${value.data()}");
  //     emit(GetLikePostSuccessState());
  //     print("GetLikePostSuccessState");
  //   } catch (error) {
  //     emit(GetLikePostErrorState());
  //     print("GetLikePostErrorState ${error.toString()}");
  //   }
  // }

  // * create Comment
  void commentPosts(String postid, String text, String timeDate) async {
    print("CommentPostLoadingState");
    emit(CommentPostLoadingState());
    CommentModel commentModel = CommentModel(text: text, timeDate: timeDate);
    final value = FirebaseFirestore.instance
        .collection("posts")
        .doc(postid)
        .collection("comments")
        .add(commentModel.toMap());
    emit(CommentPostSuccessState());
    print("CommentPostSuccessState");
    //  getComments();
  }

  // Future getComments() async {
  //   print("GetCommmentPostLoadingState");
  //   emit(GetCommmentPostLoadingState());

  //   try {
  //     final value = await FirebaseFirestore.instance
  //         .collection("posts")
  //         .get()
  //         .then((value) {
  //       value.docs.forEach((element) {
  //         element.data();
  //       });
  //     });
  // value.docs.forEach((element) async {
  //   final item = await element.reference.collection("comments").get();
  //   item.docs.forEach((element) {
  //     commentText.add(CommentModel.fromJson(element.data()));
  //     print("comments Text ${commentText}");
  //   });
  // });
  //     print("My text${commentText}");

  //     emit(GetCommmentPostSuccessState());
  //     print("GetCommmentPostSuccessState");
  //   } catch (error) {
  //     print("GetCommmentPostErrorState ${error.toString()}");
  //     emit(GetCommmentPostErrorState());
  //   }
  // }

  // * chat user

  List<UserModel> users = [];
  void getAllUser() {
    emit(GetAllUsersLoadingState());
    print("GetAllUsersLoadingState");
    users = [];

    FirebaseFirestore.instance.collection("user").get().then((value) {
      value.docs.forEach((element) {
        if (element.id != userModel!.uid)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersSuccessState());
      print("GetAllUsersSuccessState");
    }).catchError((error) {
      emit(GetAllUsersErrorState());
      print("GetAllUsersErrorState");
    });
  }

// * Set or Storme Message in firebase
  Future creatChatting({
    String? dateTime,
    String? receiverId,
    String? text,
  }) async {
    emit(CreateMessageLoadingState());
    print("CreateMessageLoadingState");
    ChatModel chatModel = ChatModel(
        dateTime: dateTime,
        receiverId: receiverId,
        text: text,
        SenderId: userModel!.uid);

    await FirebaseFirestore.instance
        .collection("user")
        .doc(userModel!.uid)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .add(chatModel.toMap())
        .then((value) {
      emit(CreateMessageSuccessState());
      print("CreateMessageSuccessState");
    }).catchError((error) {
      print("CreateMessageErrorState ${error.toString()}");
      emit(CreateMessageErrorState());
    });

    await FirebaseFirestore.instance
        .collection("user")
        .doc(receiverId)
        .collection("chat")
        .doc(userModel!.uid)
        .collection("message")
        .add(chatModel.toMap())
        .then((value) {
      emit(CreateMessageSuccessState());
      print("CreateMessageSuccessState");
    }).catchError((error) {
      print("CreateMessageErrorState ${error.toString()}");
      emit(CreateMessageErrorState());
    });
  }
  //  * Get Message from Firebase to chatting screen

  List<ChatModel> message = [];

  Future? getMessage({
    @required String? receiverId,
  }) async {
    emit(GetMessageLoadingState());
    print("GetMessageLoadingState");
    await FirebaseFirestore.instance
        .collection("user")
        .doc(userModel!.uid)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(ChatModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
      print("GetMessageSuccessState");
    });
  }

  String? textMessage;
  void changTextMessage(String text) {
    textMessage = text;
    emit(ChangeTextMessage());
    print("ChangeTextMessage");
  }

  List<Widget> listScreens = [
    JopScreen(),
    AddJopScreen(),
    UsersChat(),
    SettingScreen(),
  ];
  List<String> titleScreen = [
    "My Job",
    "Add Post",
    "Chats",
    "Setting",
  ];

  int currenIndex = 0;
  void changeButtonBar(int index) {
    if (index == 2) getAllUser();
    if (index == 0) getAllPosts();
    currenIndex = index;
    emit(ChangeButtonBarState());
  }
}
