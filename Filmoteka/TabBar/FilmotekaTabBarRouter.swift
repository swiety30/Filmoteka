//
//  FilmotekaTabBarRouter.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 04/11/2021.
//

import SwiftUI

enum ViewToDisplay: Equatable {
     case notWatched
     case watched
 }

class ViewRouter: ObservableObject {
    @Published var currentView: ViewToDisplay = .notWatched
}
