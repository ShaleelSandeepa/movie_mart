import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/models/movie_model.dart';
import 'package:movie_mart/screens/movie_screen.dart';
import 'package:movie_mart/services/api_services.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key, required this.query});
  final String query;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    Color darkBlue = const Color(0xFF0d253f);
    Color lightBlue = const Color(0xFF01b4e4);
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        backgroundColor: darkBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.query,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiServices().searchMovie(keyword: widget.query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CupertinoActivityIndicator(
              color: Colors.white,
            ));
          }
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              "Something went wrong !",
              style: TextStyle(
                color: Colors.white,
              ),
            ));
          }
          List<MovieModel>? movies = snapshot.data!;
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.7),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieScreen(movie: movies[index]),
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
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(5)),
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
          );
        },
      ),
    );
  }
}
