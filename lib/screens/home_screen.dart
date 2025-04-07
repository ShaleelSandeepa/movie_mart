import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../services/api_services.dart';
import 'movie_screen.dart';
import 'search_results.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices services = ApiServices();
  List<MovieModel>? movies = [];
  TextEditingController quaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    Color darkBlue = const Color(0xFF0d253f);
    Color lightBlue = const Color(0xFF01b4e4);
    quaryController.clear();
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Movie Mart",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'SplashScreenFont',
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Image.asset(
                            "assets/images/logo-rounded.png",
                            width: size.width * 0.09,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.white38)),
                          cursorColor: lightBlue,
                          controller: quaryController,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchResults(query: quaryController.text),
                              ));
                          quaryController.clear();
                        },
                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: services.getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    movies = snapshot.data!.cast();
                    return CarouselSlider(
                      options: CarouselOptions(
                          height: size.height * 0.225, autoPlay: true),
                      items: movies!.map((movie) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MovieScreen(movie: movie),
                                    ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            movie.backdropPath.toString()),
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.2),
                                            BlendMode.darken)),
                                    color: lightBlue.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Stack(children: [
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 4),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    movie.voteAverage!
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  const Icon(
                                                    Icons.star_rate_rounded,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            movie.title
                                                .toString()
                                                .replaceAll(": ", " :\n"),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: lightBlue,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 6),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Watch now",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }
                  return SizedBox(
                    height: size.height * 0.225,
                    child: const CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Top Rated Movies",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              FutureBuilder(
                future: services.getTopRatedMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 150,
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text(
                      "Something went wrong !",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }
                  final List<MovieModel> movies = snapshot.data!.cast();
                  return SizedBox(
                    height: size.height * 0.225,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieScreen(movie: movies[index]),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.275,
                              height: size.height * 0.225,
                              decoration: BoxDecoration(
                                color: lightBlue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    movies[index].posterPath!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 3),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                movies[index]
                                                    .voteAverage!
                                                    .toStringAsFixed(1),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const Icon(
                                                Icons.star_rate_rounded,
                                                color: Colors.amber,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Upcoming Movies",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              FutureBuilder(
                future: services.getUpcomingMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 150,
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text(
                      "Something went wrong !",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }
                  final List<MovieModel> movies = snapshot.data!.cast();
                  return SizedBox(
                    height: size.height * 0.225,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieScreen(movie: movies[index]),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.275,
                              height: size.height * 0.225,
                              decoration: BoxDecoration(
                                color: lightBlue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    movies[index].posterPath!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 3),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                movies[index]
                                                    .voteAverage!
                                                    .toStringAsFixed(1),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const Icon(
                                                Icons.star_rate_rounded,
                                                color: Colors.amber,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
