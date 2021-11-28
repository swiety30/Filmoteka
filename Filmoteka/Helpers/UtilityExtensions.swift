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
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
