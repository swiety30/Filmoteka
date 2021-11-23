//
//  FilmotekaModel.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import Foundation

struct FilmotekaModel {
    struct Movie: Hashable, Identifiable, Codable, Equatable {
        var id: Int
        var name: String
        var year: String = "2011"
        var isWatched: Bool
        var category: Category
        var rating: Rating

        enum Rating: Int, CaseIterable, Codable, Equatable {
            case one = 1, two, three, four, five
        }

        init(id: Int, name: String, isWatched: Bool, category: Category, rating: Rating = .three) {
            self.id = id
            self.name = name
            self.isWatched = isWatched
            self.category = category
            self.rating = rating
        }
    }

    struct Category: Hashable, Identifiable, Codable, Equatable {
        var id: Int
        var name: String

        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }
}
