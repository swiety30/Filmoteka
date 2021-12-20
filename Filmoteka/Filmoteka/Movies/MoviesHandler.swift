//
//  MoviesHandler.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

class MoviesHandler: ObservableObject {
    @Published private var movies: [Movie] = [
        Movie(name: "Movie Name", isWatched: false, category: "Default", rating: .two),
        Movie(name: "Movie Name2", year: "2022", isWatched: false, category: "Default", rating: .one),
        Movie(name: "Palma", isWatched: false, category: "New", rating: .five),
        Movie(name: "Palmama", year: "2022", isWatched: false, category: "Newer", rating: .five)]


    var allMovies: [Movie] {
        movies
    }

    var allCategories: [Category] {
        movies.map { $0.category }.uniqued()
    }

    // Intensions for Movies Repository
    func addMovie(_ named: String, isWatched: Bool = false, category: Category) {
        movies.append(Movie(name: named, isWatched: isWatched, category: category))
    }

    func updateMovie(movieId: Movie.ID, isWatched: Bool, category: Category, rating: Movie.Rating, notes: String) {
        guard let index = getIndexOfMovie(with: movieId) else { return }
        movies[index].isWatched = isWatched
        movies[index].category = category
        movies[index].rating = rating
        movies[index].notes = notes
    }

    private func getIndexOfMovie(with id: Movie.ID) -> Array<Movie>.Index? {
        movies.firstIndex(where: { $0.id == id })
    }

    func changeWatched(_ movieId: Movie.ID) {
        guard let index = getIndexOfMovie(with: movieId) else { return }
        movies[index].isWatched = !movies[index].isWatched
    }

    func changeCategory(_ movieId: Movie.ID, to category: Category) {
        guard let index = getIndexOfMovie(with: movieId) else { return }
        movies[index].category = category
    }

    func changeRating(for movieId: Movie.ID, to rating: Movie.Rating) {
        guard let index = getIndexOfMovie(with: movieId) else { return }
        movies[index].rating = rating
    }
}
