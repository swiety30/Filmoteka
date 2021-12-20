//
//  MoviesScrollViewView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

struct MoviesScrollView: View {
    @StateObject var viewModel: MoviesScrollViewViewModel
    @Binding var showTabBar: Bool

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 84/255, green: 35/255, blue: 68/255), Color(red: 191/255, green: 209/255, blue: 229/255), Color(red: 235/255, green: 245/255, blue: 238/255)]), startPoint: .bottomLeading, endPoint: .topTrailing)
                ScrollView {
                    if $viewModel.filteredMovies.isEmpty {
                        ZStack(alignment: .center) {
                            Text("No movies to display!")
                                .font(.largeTitle)
                        }
                        .padding()
                    } else {
                        ForEach($viewModel.filteredMovies) { filter in
                            Section {
                                ForEach(filter.filterMovies) { movie in
                                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                        MovieCell(movie: movie)
                                    }
                                }
                            } header: {
                                HStack {
                                    TextField("", text: filter.filterName)
                                        .frame(alignment: .leading)
                                        .font(.title)
                                        .padding(.horizontal)
                                        .background(Color(red: 235/255, green: 245/255, blue: 238/255))
                                        .cornerRadius(5)
                                }
                                .padding(.top)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItem() {
                    MovieFilterView(filterViewModel: viewModel.movieFilterViewModel)
                }
            }

        }
        .navigationAppearance(backgroundColor: UIColor(red: 84/255, green: 35/255, blue: 68/255, alpha: 0.6),
                              foregroundColor: .systemBackground,
                              tintColor: .systemBackground,
                              hideSeparator: true)
    }
}