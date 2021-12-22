//
//  NewMovieView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 26/10/2021.
//

import SwiftUI

struct NewMovieView: View {
    @EnvironmentObject var movieHandler: MoviesHandler
    @Environment(\.presentationMode) var presentationMode

    init() {
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    nameSection
                    yearSection
                    categorySection
                }
                .listStyle(GroupedListStyle())

                addButton

            }
            .navigationBarTitle("Add new movie", displayMode: .inline)
            .padding(.vertical)
            .background(Constants.Colors.detailsBackground)
        }
    }

    var addButton: some View {
        Button {
            movieHandler.addMovie(movieName, category: movieCategory)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Add")
        }
        .disabled(movieName == "" || movieYear == "" || movieCategory == "")
    }
    
    @State private var movieName: String = ""
    var nameSection: some View {
        Section {
            TextField("", text: $movieName)
        } header: {
            Text("Title")
        }
    }

    @State private var movieYear: String = ""
    var yearSection: some View{
        Section {
            TextField("", text: $movieYear)
                .keyboardType(.decimalPad)
        } header: {
            Text("Year")
        }
    }

    @State private var movieCategory: String = ""
    var categorySection: some View {
        NavigationLink(destination: CategoriesView(movieCategory: $movieCategory)) {
            HStack() {
                Text("Category")
                Spacer()
                TextField("Choose..", text: $movieCategory)
                    .disabled(true)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct NewMovieView_Previews: PreviewProvider {
    static var previews: some View {
        return NewMovieView()
    }
}
