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
        var year: String
        var isWatched: Bool
        var category: Category
        var rating: Rating
        
        enum Rating: Int, CaseIterable, Codable, Equatable {
            case one = 1, two, three, four, five
            func name() -> String {
                switch self {
                case .one: return "One Star"
                case .two: return "Two Stars"
                case .three: return "Three Stars"
                case .four: return "Four Stars"
                case .five: return "Five Stars"
                }
            }
        }
        
        init(id: Int,
             name: String,
             year: String = "2011",
             isWatched: Bool,
             category: Category,
             rating: Rating = .three) {
            self.id = id
            self.name = name
            self.year = year
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
