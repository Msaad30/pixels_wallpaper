import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/wallpaper_repository.dart';
import '../../../models/wallpaper_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  WallPaperRepository wallPaperRepository;

  HomeCubit({required this.wallPaperRepository}) : super(HomeInitialState());

  void getTrandingWallpaper() async{
    emit(HomeLoadingState());
    try{
      var data = await wallPaperRepository.getTrandingWallpapers();
      var wallpaperModel = WallpaperModel.fromJson(data);
      emit(HomeLoadedState(listPhotos: wallpaperModel.photos!));
    } catch (e){
      emit(HomeErrorState(errorMsg: e.toString()));
    }
  }

}
