//
//  Movie.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import Foundation

struct Movie: Hashable, Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var year: String
    var description: String
    var notes: String
    var isWatched: Bool
    var isFavourite: Bool
    var category: Category
    var rating: Rating
    let logoImageURL: String
    let detailsImageURL: String
    
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
    
    init(name: String,
         year: String = "2011",
         isWatched: Bool,
         isFavourite: Bool = false,
         category: Category,
         rating: Rating = .three) {
        self.name = name
        self.year = year
        self.isWatched = isWatched
        self.isFavourite = isFavourite
        self.category = category
        self.rating = rating
        self.notes = ""
        self.description = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis eleifend quam adipiscing vitae proin sagittis nisl rhoncus. Ut sem viverra aliquet eget. Pharetra sit amet aliquam id diam. Diam maecenas sed enim ut sem viverra aliquet eget. Varius sit amet mattis vulputate enim nulla. Sit amet venenatis urna cursus eget nunc scelerisque viverra mauris. Tincidunt ornare massa eget egestas purus. Lectus urna duis convallis convallis tellus. Orci phasellus egestas tellus rutrum tellus pellentesque eu. Non consectetur a erat nam at lectus urna duis convallis.
"""
        self.logoImageURL = "https://dummyimage.com/150x200/752d75/15ff00.png&text=\(name.onlyFirstLetters())"
        self.detailsImageURL = "https://dummyimage.com/500x250/752d75/15ff00.png&text=\(name.replacingOccurrences(of: " ", with: "+"))"
    }
}

typealias Category = String


