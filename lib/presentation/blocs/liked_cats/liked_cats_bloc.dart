import 'package:flutter_bloc/flutter_bloc.dart';
import 'liked_cats_event.dart';
import 'liked_cats_state.dart';

class LikedCatsBloc extends Bloc<LikedCatsEvent, LikedCatsState> {
  LikedCatsBloc() : super(LikedCatsState(likedCats: [])) {
    on<AddLikedCat>((event, emit) {
      final updated = List.of(state.likedCats)..add(event.cat);
      emit(state.copyWith(likedCats: updated));
    });

    on<RemoveLikedCat>((event, emit) {
      final updated =
          state.likedCats.where((c) => c.id != event.catId).toList();
      emit(state.copyWith(likedCats: updated));
    });

    on<FilterLikedCats>((event, emit) {
      emit(state.copyWith(filter: event.breed));
    });
  }
}
