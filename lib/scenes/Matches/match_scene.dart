import 'package:arqmvvm/resources/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

 class _MatchesPageState extends State<MatchesPage> {

   @override
   void initState() {
     super.initState();
   }

   @override
   Widget build(BuildContext context) {
     return Stack(
       children: [
         Scaffold(
           backgroundColor: dividerColorLight,
           body: SafeArea(child: SingleChildScrollView(
               padding: const EdgeInsets.all(16.0),
               child: Column(
                 children: [
                   Text("Matches Page"),
                 ],
               )
           )),
         )
       ],
     );
   }
 }