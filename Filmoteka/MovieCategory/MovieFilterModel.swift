//
//  MovieFilterModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 24/11/2021.
//

import Foundation

public struct MovieFilterModel {
    public enum Filter: String, CaseIterable, Identifiable {
        public var id: Int {
            get { hashValue }
        }
        case rating, year, alphabet, category
    }

    struct FilteredMovies: Identifiable {
        public var id: Int
        var filterName: String
        var filterMovies: [FilmotekaModel.Movie]
    }
}
