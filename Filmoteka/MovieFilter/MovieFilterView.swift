//
//  MovieFilterView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 24/11/2021.
//

import SwiftUI

struct MovieFilterView: View {
    @StateObject var filterViewModel: MovieFilterViewModel

    var body: some View {
        Menu {
            ForEach(filterViewModel.allFilters) { filter in
                Button {
                    filterViewModel.changeFilter(to: filter)
                } label: {
                    Label(filter.rawValue.firstLetterCapitalised(), systemImage: "plus")
                }
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down.square")
//                .foregroundColor(.pink)
        }
    }
}
