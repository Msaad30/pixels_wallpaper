import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/wallpaper_repository.dart';
import '../../../models/wallpaper_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  WallPaperRepository wallPaperRepository;

  SearchCubit({required this.wallPaperRepository}) : super(SearchInitialState());

  void getSearchWallpaper({required String query, String color = "", int page = 1}) async {
    emit(SearchLoadingState());
    try{
      var mData = await wallPaperRepository.getSearchWallpapers(query, mColor: color, mPage : page);
      WallpaperModel wallpaperModel = WallpaperModel.fromJson(mData);
      emit(SearchLoadedState(listPhotos: wallpaperModel.photos!, totalWallpaper: wallpaperModel.totalResults));
    } catch(e) {
      emit(SearchErrorState(
          errorMsg: e.toString()
      ));
    }
  }
}
