import 'package:flutter/material.dart';

import 'package:flutter_music/common/music_store.dart';

import 'package:flutter_music/base_music/music_app_bar.dart';

import 'package:flutter_music/pages/library_page/library_list_widget.dart';
import 'package:flutter_music/public_widget/music_submit_button.dart';
import 'package:flutter_music/pages/library_page/library_state/library_list_state.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


 return  MultiProvider(
   providers: [
     ChangeNotifierProvider(

       create: (context)=>LibraryListState(),

     )
   ],
   child: Builder(
     builder: (context){


       return Selector<UserSate,bool>(
         selector: (context,userState){
           return  userState.isLogin;
         },
         shouldRebuild: (pre,next){
           return pre != next;
         },
         builder: (context,isLogin,_){

           return MusicScaffold(
             showFloatingActionButton: false,
             appBar: MusicAppBar(
               title: "歌单",
               rightIconData: isLogin == false ? null : Icons.edit,
               rightSelectedIconData: Icons.delete_sweep ,
               rightOnTap: (){
                 LibraryListState.libraryState(context).deleteAction();

               },
             ),
             body: isLogin  == false ? _unLogin() : LibraryListWidget() ,
           );
         },
       );

     },
   )

 );
  }


  Widget _unLogin(){
    return Center(
      child: MusicSubmitButton(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        onTap: (state){
          Navigator.of(context).pushNamed(RouterPageName.LoginPage);
        },
        title: "登录查看歌单",
      ),

    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
