//
//  UtilityExtensions.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 24/11/2021.
//

import Foundation

extension String {
    func firstLetterCapitalised() -> String {
        self.prefix(1).capitalized + dropFirst()
    }
    
    var numberOfLines: Int {
        self.components(separatedBy: "\n").count
    }

    func onlyFirstLetters() -> String {
        let components = self.components(separatedBy: " ")
        var firstLetters = ""
        for component in components {
            firstLetters += component.prefix(1).capitalized
        }
        return firstLetters
    }

    func isNumeric() -> Bool {
        guard self.count > 0 else { return false }
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
