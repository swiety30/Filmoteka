//
//  FilmotekaViewModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

class FilmotekaViewModel: ObservableObject {
    @Published var movies: [FilmotekaModel.Movie] = [FilmotekaModel.Movie(id: 0, name: "Movie Name", isWatched: false, category: FilmotekaModel.Category(id: 0, name: "Default"))]

    var toBeWatchedMovies: [FilmotekaModel.Movie] {
        get { movies.filter { !$0.isWatched } }
        set { }
    }

    var watchedMovies: [FilmotekaModel.Movie] {
        get { movies.filter { $0.isWatched } }
        set { }
    }

    var filteredByCategoryToBeWatchedMovies: [String: [FilmotekaModel.Movie]] {
        get {
            var filtered = [String: [FilmotekaModel.Movie]]()
            categories.forEach { category in
                filtered[category.name] = toBeWatchedMovies.filter { $0.category.name == category.name }
            }
            return filtered
        }
        set { }
    }

    @Published var categories: [FilmotekaModel.Category] = [FilmotekaModel.Category(id: 0, name: "Default")]

    init() {}

    // MARK: - Intentions
    private var uniqueMovieId = 0
    private var uniqueCategoryId = 0

    func addMovie(_ named: String, isWatched: Bool = false, category: FilmotekaModel.Category) {
        uniqueMovieId += 1
        movies.append(FilmotekaModel.Movie(id: uniqueMovieId, name: named, isWatched: isWatched, category: category))
    }

    func updateMovie(movieId: FilmotekaModel.Movie.ID, isWatched: Bool, category: FilmotekaModel.Category, rating: FilmotekaModel.Movie.Rating) {
        guard let index = getIndexOfMovie(with: movieId) else { return }
        movies[index].isWatched = isWatched
        movies[index].category = category
        movies[index].rating = rating
    }

    private func getIndexOfMovie(with id: FilmotekaModel.Movie.ID) -> Array<FilmotekaModel.Movie>.Index? {
        movies.firstIndex(where: { $0.id == id })
    }

    func addCategory(_ named: String) {
        if !checkIfCategoryExists(named) {
            uniqueCategoryId += 1
            categories.append(FilmotekaModel.Category(id: uniqueCategoryId, name: named))
        }
    }

    func removeCategory(at atOffsets: IndexSet) {
        if categories.count > 1 {
            categories.remove(atOffsets: atOffsets)
        }
    }

    func category(named: String) -> FilmotekaModel.Category {
        categories.first(where: { $0.name.lowercased() == named.lowercased() }) ?? categories.first!
    }

    func isCategoryEmpty(_ category: FilmotekaModel.Category, for movies: [FilmotekaModel.Movie]) -> Bool {
        !movies.contains(where: { $0.category  == category })
    }

    private func checkIfCategoryExists(_ named: String) -> Bool {
        categories.contains(where: { $0.name.lowercased() == named.lowercased() })
    }

    func changeWatched(_ movieId: Int) {
        guard let index = movies.firstIndex(where: { $0.id == movieId} ) else { return }
        movies[index].isWatched = !movies[index].isWatched
    }

    func changeCategory(_ movieId: Int, to category: FilmotekaModel.Category) {
        guard let index = movies.firstIndex(where: { $0.id == movieId}) else { return }
        movies[index].category = category
    }

    func changeRating(for movieId: Int, to rating: FilmotekaModel.Movie.Rating) {
        guard let index = movies.firstIndex(where: { $0.id == movieId }) else { return }
        movies[index].rating = rating
    }

    func movie(with id: Int) -> FilmotekaModel.Movie? {
        movies.first(where: { $0.id == id }) ?? nil
    }

    func filter(movies: [FilmotekaModel.Movie], for category: FilmotekaModel.Category) -> [FilmotekaModel.Movie] {
        movies.filter { $0.category == category }
    }
}
