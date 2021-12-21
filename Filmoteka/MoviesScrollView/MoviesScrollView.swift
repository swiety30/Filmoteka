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
            Group {
                if $viewModel.filteredMovies.isEmpty {
                    GeometryReader { geometry in
                        Text("No movies to display!")
                            .font(.largeTitle)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach($viewModel.filteredMovies) { filter in
                            VStack(alignment: .leading) {
                                Section {
                                    ForEach(filter.filterMovies) { movie in
                                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                            MovieCell(movie: movie)
                                        }
                                    }
                                } header: {
                                    Text(filter.filterName.wrappedValue)
                                        .padding(.horizontal)
                                        .font(.title)
                                        .background(Color(red: 235/255, green: 245/255, blue: 238/255))
                                        .cornerRadius(5)
                                        .padding(.top)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 84/255, green: 35/255, blue: 68/255), Color(red: 191/255, green: 209/255, blue: 229/255), Color(red: 235/255, green: 245/255, blue: 238/255)]), startPoint: .bottomLeading, endPoint: .topTrailing)
            )

            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItem() {
                    MovieFilterView(filterViewModel: viewModel.movieFilterViewModel)
                }
            }
        }
        .navigationAppearance(backgroundColor: UIColor(red: 84/255, green: 35/255, blue: 68/255, alpha: 0.6),
                              foregroundColor: .systemBackground,
                              tintColor: .systemBackground)
    }
}
