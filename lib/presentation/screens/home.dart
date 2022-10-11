import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/business_logic/weather_cubit.dart';
import 'package:weatherapp/business_logic/weather_state.dart';
import 'package:weatherapp/presentation/widgets/city_card.dart';
import 'package:weatherapp/utilities/routes.dart';
import '../../data/models/weather.dart';
import '../../utilities/constants.dart';
import '../../utilities/greeting.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _fetchInitial();
    super.initState();
  }

  Future<void> _fetchInitial() async {
    BlocProvider.of<CityWeatherCubit>(context).getTopCities();
  }

  Weather? cityWeather;
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _cityName;
  bool isValidating = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final _pageScroll = PageController(viewportFraction: 0.85, keepPage: true);
  List<Color> currentColor = backColor[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     BlocBuilder<CityWeatherCubit, CityWeatherState>(
      builder: (context, state) {
        List<Weather> cities =
            BlocProvider.of<CityWeatherCubit>(context).dataList;
        if (state is CityWeatherloading) {
          return Center(
            child: Image.asset("assets/images/loading.gif"),
          );
        } else if (state is CityWeatherSuccess) {
          
          return SafeArea(
            child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: currentColor),),
                   
                
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Form(
                            key: _formKey,
                            autovalidateMode: autovalidateMode,
                            child: TextFormField(
                              controller: controller,
                              onChanged: (value) {},
                              cursorColor: Theme.of(context).primaryColor,
                              validator: (String? input) {
                                if (input!.isEmpty ||
                                    input.trim().length < 2) {
                                  return 'Please enter a valid city name';
                                }
                                return null;
                              },
                              onSaved: (String? input) {
                                _cityName = input!;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(15)),
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Enter City Name",
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      if (_formKey.currentState!
                                          .validate()) {
                                        _formKey.currentState!.save();
                                        _cityName = controller.text;
                                        BlocProvider.of<CityWeatherCubit>(
                                                context)
                                            .getCityWeather(
                                                city: _cityName);
          
                                        final city = BlocProvider.of<
                                                CityWeatherCubit>(context)
                                            .cityWeather;
                                        Navigator.pushNamed(
                                            context, AppRoutes.details,
                                            arguments: city);
                                      } else {
                                        setState(() {
                                          autovalidateMode =
                                              AutovalidateMode.always;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.search)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good ${greeting()} ,Mr Mahmoud",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 22),
                                child: Text(
                                  DateFormat.yMMMEd()
                                      .format(DateTime.now()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: Padding(
                              padding: EdgeInsets.zero,
                              child: PageView.builder(
                                allowImplicitScrolling: true,
                                controller: _pageScroll,
                                itemCount: cities.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    currentColor = backColor[index];
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return CityCard(
                                    size: MediaQuery.of(context).size,
                                    weather: cities[index],
                                    press: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.details,
                                          arguments: cities[index]);
                                    },
                                  );
                                },
                              )),
                        )
                      ],
                    ),
                  ),
                ),
          );
        } else if (state is CityWeatherError) {
          return Center(
            child: Text("fail"),
          );
        } else {
          return Center(
            child: Text(""),
          );
        }
      },
    ));
  }
}
