//
//  MovieCategoryViewModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 24/11/2021.
//

import SwiftUI

class MovieFilterViewModel: ObservableObject {
    @Published var currentFilter: MovieFilterModel.Filter = .category
    var allFilters: [MovieFilterModel.Filter] = MovieFilterModel.Filter.allCases

    init() {}

    // MARK: - Intentions
    func changeFilter(to filter: MovieFilterModel.Filter) {
        if currentFilter != filter {
            currentFilter = filter
        }
    }

    public func filtered(_ movies: [Movie], _ categories: [Category]) -> [MovieFilterModel.FilteredMovies] {
        var filteredDict: [MovieFilterModel.FilteredMovies] = []
        switch currentFilter {
        case .rating:
            Movie.Rating.allCases.sorted { $0.rawValue > $1.rawValue }
            .uniqued()
            .forEach { rating in
                let filteredMovies = movies.filter { $0.rating == rating }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(filterName: rating.name(), filterMovies: filteredMovies))
                }
            }
        case .category:
            categories.sorted { $0 < $1 }
            .uniqued()
            .forEach { category in
                let filteredMovies = movies.filter { $0.category == category }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(filterName: category, filterMovies: filteredMovies))
                }
            }
        case .year:
            movies.sorted { $0.year.lowercased() > $1.year.lowercased() }
            .map { $0.year }
            .uniqued()
            .forEach { year in
                let filteredMovies = movies.filter { $0.year == year }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(filterName: year, filterMovies: filteredMovies))
                }
            }

        case .alphabet:
            movies.sorted { $0.name.lowercased() < $1.name.lowercased() }
            .compactMap { $0.name.first }
            .uniqued()
            .forEach { letter in
                let filteredMovies = movies.filter { $0.name.starts(with: String(letter)) }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(filterName: String(letter).capitalized, filterMovies: filteredMovies))
                }
            }

        case .favourite:
            let filteredMovies = movies.filter { $0.isFavourite }
            filteredDict.append(MovieFilterModel.FilteredMovies(filterName: "Favourites", filterMovies: filteredMovies))
        }
        return filteredDict
    }
}
