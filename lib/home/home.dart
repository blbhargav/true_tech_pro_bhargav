
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_tech_pro_bhargav/db/repository.dart';
import 'package:true_tech_pro_bhargav/home/home_bloc.dart';
import 'package:true_tech_pro_bhargav/models/comment.dart';

class HomePage extends StatefulWidget {
  final Repository repository;
  HomePage({Key? key, required this.repository}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  late HomeBloc _bloc;
  var scalingWidth =1.0;
  @override
  void initState() {
    super.initState();
    _bloc=HomeBloc(widget.repository)..add(InitEvent());
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    scalingWidth=screenWidth/360;
    return BlocProvider(
        create: (_) => _bloc,
        child: Scaffold(
          appBar: AppBar(title: Text("True Tech Pro Bhargav"),),
          backgroundColor: Color(0xfff2f2f2),
          body: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {

            },
            child: RefreshIndicator(
              child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: _bloc,
                  builder: (BuildContext context, HomeState state) {
                    if(state is HomeInitial){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(state is ErrorState){
                      return getErrorScreen();
                    }

                    if(state is NoDataState){
                      return Center(
                        child: Text("No Data Found"),
                      );
                    }
                    if(state is DisplayDataState){
                      return getUserCommentsView(state.comments);
                    }

                    return SizedBox();
                  }
              ),
              onRefresh: onScreenPullDown,
            ),
          ),
        )
    );
    
  }

  Widget getUserCommentsView(List<Comment> comments) {
    return ListView.separated(
      itemCount: comments.length,
      padding: EdgeInsets.only(bottom: 100,top: 20),
      separatorBuilder: (BuildContext context,int index){
        return Container(
          height: 1,
          color: Colors.black12,
          margin: EdgeInsets.only(top: 10,bottom: 10,left: 32,right: 32),
        );
      },
      itemBuilder: (BuildContext context,int index){
        Comment comment=comments[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 328*scalingWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(Icons.person),
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Expanded(
                        child: Text("${comment.name}",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    child: Text("${comment.email}",style: TextStyle(fontSize: 12,color: Colors.blue),),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text("${comment.body}"),
                  )

                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> onScreenPullDown() {
    _bloc.add(InitEvent());
    return Future.value(true);
  }

  Widget getErrorScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 32,right: 32,bottom: 20),
          child: Text("Error Fetching Data. Please ensure your internet connection and try again later",
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(onPressed: (){
          onScreenPullDown();
        },
            child: Text("RETRY"),
        )
      ],
    );
  }
}