//
//  NewMovieView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 26/10/2021.
//

import SwiftUI

struct NewMovieView: View {
    @EnvironmentObject var filmotekaModel: FilmotekaViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("Add new movie to collection!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                Form {
                    nameSection
                    yearSection
                    categorySection
                }
                addButton

            }
            .navigationBarTitle("Back")
            .navigationBarHidden(true)
        }
        .padding()
    }

    var addButton: some View {
        Button {
            filmotekaModel.addMovie(movieName, category: filmotekaModel.category(named: movieCategory))
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

    @State private var movieCategory: String = "Choose.."
    var categorySection: some View {
        NavigationLink(destination: CategoriesView(movieCategory: $movieCategory)) {
            HStack() {
                Text("Category")
                Spacer()
                TextField("", text: $movieCategory)
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
