//
//  CategoriesView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 30/10/2021.
//

import SwiftUI

struct CategoriesView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var movieCategory: String
    @EnvironmentObject var movieHandler: MoviesHandler
    @State private var newCategory: String = ""

    var body: some View {
        List {
            Section(header: CategoryHeader(), footer: CategoryFooter()) {
                ForEach(movieHandler.allCategories, id: \.self) { item in
                    Button {
                        movieCategory = item
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text(item)
                            if item == movieCategory {
                                Spacer()
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .foregroundColor(.primary)
                }

//                .onDelete { index in
//                    filmotekaModel.removeCategory(at: index)
//                }

                TextField("New Category", text: $newCategory, onCommit: {
                    //                    filmotekaModel.addCategory(newCategory)
                    movieCategory = newCategory
                    newCategory = ""
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(red: 191/255, green: 209/255, blue: 229/255))
    }
}

struct CategoryHeader: View {
    var body: some View {
        Text("Categories List")
    }
}

struct CategoryFooter: View {
    var body: some View {
        Text("Please pick category for your movie")
    }
}
