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
        case rating, year, alphabet, category, favourite
    }

    struct FilteredMovies: Identifiable {
        var id = UUID()
        var filterName: String
        var filterMovies: [Movie]
    }
}
