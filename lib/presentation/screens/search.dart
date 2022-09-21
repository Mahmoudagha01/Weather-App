import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Color> currentColor = backColor[1];
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        decoration: BoxDecoration(
         color: Color.fromRGBO(127, 127, 127, 1),
        ),
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: Container(
          child: Scaffold(
                 backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              
              centerTitle: true,
              title: Text(
                "Weather App",
                style: TextStyle(color:Colors.white),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {},
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter City Name",
                        prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            )),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)))),
                  ),
                ),
                Image.asset(
                  'assets/images/search.gif',
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ));
  }
}
