//
//  FilmotekaViewModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

class FilmotekaViewModel: ObservableObject {
    @Published var movies: [FilmotekaModel.Movie] = []

    var toBeWatchedMovies: [FilmotekaModel.Movie]  {
        get { movies.filter { !$0.isWatched } }
        set { }
    }

    var watchedMovies: [FilmotekaModel.Movie] {
        get { movies.filter { $0.isWatched } }
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

    func addCategory(_ named: String) {
        if !checkIfCategoryExists(named) {
            uniqueCategoryId += 1
            categories.append(FilmotekaModel.Category(id: uniqueCategoryId, name: named))
        }
    }

    private func checkIfCategoryExists(_ named: String) -> Bool {
        categories.contains(where: { $0.name == named })
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
}
