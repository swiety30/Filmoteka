//
//  FilmotekaViewModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

class FilmotekaViewModel: ObservableObject {
    typealias Movie = FilmotekaModel.Movie
    typealias Category = FilmotekaModel.Category
    typealias FilteredMovies = MovieFilterModel.FilteredMovies
    @ObservedObject var filterViewModel = MovieFilterViewModel()
    
    @Published var movies: [Movie] = [
        Movie(id: 0, name: "Movie Name", isWatched: false, category: Category(id: 0, name: "Default"), rating: .two),
        Movie(id: 1, name: "Movie Name2", year: "2022", isWatched: false, category: Category(id: 0, name: "Default"), rating: .one),
        Movie(id: 2, name: "Palma", isWatched: false, category: Category(id: 1, name: "New"), rating: .five),
        Movie(id: 3, name: "Palmama", year: "2022", isWatched: false, category: Category(id: 3, name: "Newer"), rating: .five)]

    @Published var categories: [Category] = [Category(id: 0, name: "Default")]

    var toBeWatchedMovies: [MovieFilterModel.FilteredMovies] {
        get { filterViewModel.filterMovies(movies.filter { !$0.isWatched }, categories) }
        set { }
    }

    var watchedMovies: [MovieFilterModel.FilteredMovies] {
        get { filterViewModel.filterMovies(movies.filter { $0.isWatched }, categories) }
        set { }
    }

    // MARK: - Intentions
    private var uniqueMovieId = 0
    private var uniqueCategoryId = 0

    func addMovie(_ named: String, isWatched: Bool = false, category: Category) {
        uniqueMovieId += 1
        movies.append(Movie(id: uniqueMovieId, name: named, isWatched: isWatched, category: category))
    }

    func updateMovie(movieId: Movie.ID, isWatched: Bool, category: Category, rating: Movie.Rating) {
        guard let index = getIndexOfMovie(with: movieId) else { return }
        movies[index].isWatched = isWatched
        movies[index].category = category
        movies[index].rating = rating
    }

    private func getIndexOfMovie(with id: Movie.ID) -> Array<Movie>.Index? {
        movies.firstIndex(where: { $0.id == id })
    }

    func addCategory(_ named: String) {
        if !checkIfCategoryExists(named) {
            uniqueCategoryId += 1
            categories.append(Category(id: uniqueCategoryId, name: named))
        }
    }

    func removeCategory(at atOffsets: IndexSet) {
        if categories.count > 1 {
            categories.remove(atOffsets: atOffsets)
        }
    }

    func category(named: String) -> Category {
        categories.first(where: { $0.name.lowercased() == named.lowercased() }) ?? categories.first!
    }

    func isCategoryEmpty(_ category: Category, for movies: [Movie]) -> Bool {
        !movies.contains(where: { $0.category  == category })
    }

    private func checkIfCategoryExists(_ named: String) -> Bool {
        categories.contains(where: { $0.name.lowercased() == named.lowercased() })
    }

    func changeWatched(_ movieId: Int) {
        guard let index = movies.firstIndex(where: { $0.id == movieId} ) else { return }
        movies[index].isWatched = !movies[index].isWatched
    }

    func changeCategory(_ movieId: Int, to category: Category) {
        guard let index = movies.firstIndex(where: { $0.id == movieId}) else { return }
        movies[index].category = category
    }

    func changeRating(for movieId: Int, to rating: Movie.Rating) {
        guard let index = movies.firstIndex(where: { $0.id == movieId }) else { return }
        movies[index].rating = rating
    }

    func movie(with id: Int) -> Movie? {
        movies.first(where: { $0.id == id }) ?? nil
    }
}
