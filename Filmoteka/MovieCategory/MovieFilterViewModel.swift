//
//  MovieCategoryViewModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 24/11/2021.
//

import SwiftUI

class MovieFilterViewModel: ObservableObject {
    typealias Movie = FilmotekaModel.Movie
    typealias Category = FilmotekaModel.Category

    @Published var currentFilter: MovieFilterModel.Filter = .category
    var allFilters: [MovieFilterModel.Filter] = MovieFilterModel.Filter.allCases

    init() {}

    // MARK: - Intentions
    func changeFilter(to filter: MovieFilterModel.Filter) {
        if currentFilter != filter {
            currentFilter = filter
        }
    }

    func filterMovies(_ movies: [Movie], _ categories: [Category] = []) -> [MovieFilterModel.FilteredMovies] {
        return filtered(movies, categories)
    }

    private func filtered(_ movies: [Movie], _ categories: [Category] = []) -> [MovieFilterModel.FilteredMovies] {
        var filteredDict: [MovieFilterModel.FilteredMovies] = []
        var uniqueId = 0
        switch currentFilter {
        case .rating:
            Movie.Rating.allCases.sorted { $0.rawValue > $1.rawValue }
            .uniqued()
            .forEach { rating in
                let filteredMovies = movies.filter { $0.rating == rating }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(id: uniqueId, filterName: rating.name(), filterMovies: filteredMovies))
                    uniqueId += 1
                }
            }
        case .category:
            categories.sorted { $0.name < $1.name }
            .uniqued()
            .forEach { category in
                let filteredMovies = movies.filter { $0.category.id == category.id }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(id: uniqueId, filterName: category.name, filterMovies: filteredMovies))
                    uniqueId += 1
                }
            }
        case .year:
            movies.sorted { $0.year.lowercased() > $1.year.lowercased() }
            .map { $0.year }
            .uniqued()
            .forEach { year in
                let filteredMovies = movies.filter { $0.year == year }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(id: uniqueId, filterName: year, filterMovies: filteredMovies))
                    uniqueId += 1
                }
            }

        case .alphabet:
            movies.sorted { $0.name.lowercased() < $1.name.lowercased() }
            .compactMap { $0.name.first }
            .uniqued()
            .forEach { letter in
                let filteredMovies = movies.filter { $0.name.starts(with: String(letter)) }
                if !filteredMovies.isEmpty {
                    filteredDict.append(MovieFilterModel.FilteredMovies(id: uniqueId, filterName: String(letter).capitalized, filterMovies: filteredMovies))
                    uniqueId += 1
                }
            }
        }

        return filteredDict
    }
}
