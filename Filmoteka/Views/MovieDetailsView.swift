//
//  MovieDetailsView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 30/10/2021.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var movieHandler: MoviesHandler
    @Binding var movie: Movie

    @State private var isPresentingNewMoviePopover = false
    @State private var isWatched: Bool = false
    @State private var currentRating: Movie.Rating = .one
    @State private var currentCategoryName: String = ""
    @State private var currentNotes: String = ""
    @State private var isFavourite: Bool = false

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    ZStack(alignment: .topTrailing) {
                        ZStack(alignment: .bottomTrailing) {
                            Image("tombraider2")
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.width/2)
                                .scaledToFit()

                            ZStack(alignment: .bottomTrailing) {
                                Color.black
                                    .opacity(0.5)
                                VStack(alignment: .trailing) {
                                    Text(movie.name)
                                        .font(.bold(.largeTitle)())
                                    Text(movie.year)
                                        .font(.bold(.caption)())
                                }
                                .foregroundColor(.white)
                                .padding()
                            }
                            .frame(width: geometry.size.width, height: geometry.size.width / 2 / 3)
                        }
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                        .shadow(radius: 10)

                        FavouriteButton(isFavourite: $isFavourite)  { favourite in
                            isFavourite = !isFavourite
                        }
                        .padding()
                    }
                    HStack {
                        Text("Category: ")
                        Spacer()
                        HStack {
                            Text(currentCategoryName)
                            Image(systemName: "arrow.right.to.line.circle")
                        }
                        .onTapGesture {
                            isPresentingNewMoviePopover = true
                        }
                    }
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()

                    DividerWithText(text: "My Rating", lineColor: .gray, textColor: .black)

                    StarsView(currentRating: $currentRating, starSize: 50) { rating in
                        currentRating = rating
                    }
                    .padding()

                    DividerWithText(text: "My Notes", lineColor: .gray, textColor: .black)

                    ExpandableTextEditorWithPlaceholder(placeholderText: "Please add notes...", width: geometry.size.width - 50, bindingText: $currentNotes)
                        .cornerRadius(5)
                        .padding()

                    Divider()
                        .foregroundColor(.gray)
                        .padding()

                    Text(movie.description)
                        .padding(.horizontal)

                    WatchedButton(isWatched: $isWatched) { watched in
                        isWatched = !isWatched
                    }
                    .padding()

                    Rectangle()
                        .frame(width: 100, height: geometry.size.height / 8)
                        .foregroundColor(.clear)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 191/255, green: 209/255, blue: 229/255))
        .popover(isPresented: $isPresentingNewMoviePopover) {
            CategoriesView(movieCategory: $currentCategoryName)
        }
        .onAppear {
            currentCategoryName = movie.category
            isWatched = movie.isWatched
            isFavourite = movie.isFavourite
            currentRating = movie.rating
            currentNotes = movie.notes
        }
        .onDisappear {
            movieHandler.updateMovie(movieId: movie.id,
                                     isWatched: isWatched,
                                     isFavourite: isFavourite,
                                     category: currentCategoryName,
                                     rating: currentRating,
                                     notes: currentNotes)

        }
    }
}

struct WatchedButton: View {
    @Binding var isWatched: Bool
    var onGestureTap: (Bool) -> ()
    var body: some View {
        Button {
            onGestureTap(isWatched)
        } label: {
            if isWatched {
                Text("Mark as not watched")
            } else {
                Text("Mark as watched")
            }
        }
    }

}

