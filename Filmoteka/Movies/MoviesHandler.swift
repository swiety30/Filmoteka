//
//  MoviesHandler.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import Foundation

class MoviesHandler: ObservableObject {
    @Published private var movies: [Movie] = [
        Movie(name: "Tomb Raider", year: "2018", isWatched: false, category: "Action", rating: .three),
        Movie(name: "High School Musical", year: "2000", isWatched: false, category: "Teen Drama", rating: .one),
        Movie(name: "Mamma Mia!", year: "2005", isWatched: false, category: "Musical", rating: .five),
        Movie(name: "Avengers: Infinity War", year: "2020", isWatched: false, isFavourite: true, category: "Marvel", rating: .five)]
    var allMovies: [Movie] { movies }
    var allCategories: [Category] { movies.map { $0.category }.uniqued() }

    // Intensions for Movies Repository
    func addMovie(_ named: String, isWatched: Bool = false, category: Category) {
        movies.append(Movie(name: named, isWatched: isWatched, category: category))
    }

    func updateMovie(movieId: Movie.ID, isWatched: Bool, isFavourite: Bool, category: Category, rating: Movie.Rating, notes: String) {
        guard let index = getIndexOfMovie(with: movieId) else { return }
        movies[index].isWatched = isWatched
        movies[index].isFavourite = isFavourite
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
