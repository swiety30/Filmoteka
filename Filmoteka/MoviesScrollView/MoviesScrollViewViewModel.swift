//
//  MoviesScrollViewViewModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

class MoviesScrollViewViewModel: ObservableObject {
    @Published private var moviesHandler: MoviesHandler
    @Published var movieFilterViewModel: MovieFilterViewModel
    
    var isWatched: Bool
    var filteredMovies: [MovieFilterModel.FilteredMovies] {
        get { moviesHandler.allMovies.applyFiler(movieFilterViewModel: movieFilterViewModel, moviesHandler: moviesHandler, isWatched: isWatched) }
        set { }
    }

    private var viewTitle: String
    var title: String { viewTitle }

    // MARK: - Intentions
    init(isWatched: Bool, moviesHandler: MoviesHandler, movieFilterViewModel: MovieFilterViewModel) {
        self.isWatched = isWatched
        if isWatched { viewTitle = "Watched" } else { viewTitle = "To be watched" }
        self.moviesHandler = moviesHandler
        self.movieFilterViewModel = movieFilterViewModel
    }
}

fileprivate extension Array where Element == Movie  {
    func applyFiler(movieFilterViewModel: MovieFilterViewModel, moviesHandler: MoviesHandler, isWatched: Bool) -> [MovieFilterModel.FilteredMovies] {
        movieFilterViewModel.filtered(self.filter { $0.isWatched == isWatched }, moviesHandler.allCategories)
    }
}
