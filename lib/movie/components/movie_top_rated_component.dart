import 'package:duplikat_applikasi/movie/pages/movie_detail_page.dart';
import 'package:duplikat_applikasi/movie/providers/movie_get_top_rated_provider.dart';
import 'package:duplikat_applikasi/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieTopRatedComponent extends StatefulWidget {
  const MovieTopRatedComponent({super.key});

  @override
  State<MovieTopRatedComponent> createState() => _MoviePopularComponentState();
}

class _MoviePopularComponentState extends State<MovieTopRatedComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<MovieGetTopRatedProvider>().getTopRated(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Consumer<MovieGetTopRatedProvider>(
                  builder: (
                    _, provider ,__
                    ) {
                      if (provider.isLoading){
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12.0)),
                        );
                      }

                      if (provider.Movies.isNotEmpty){
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index){
                          return ImageNetworkWidget(
                            imageSrc: provider.Movies[index].posterPath, 
                            height: 200, 
                            width: 120,
                            radius: 12.0,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (_) {
                                return MovieDetailPage(id: provider.Movies[index].id);
                             },
                            ));
                           }, 
                         );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 8.0,
                        ), 
                        itemCount: provider.Movies.length,);
                      }

                   return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: const Center(
                          child: Text('Not found top rated movies'),
                        ),
                        );
                    },
                    ),
                ),
            );

  }
}