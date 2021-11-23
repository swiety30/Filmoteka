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
    @EnvironmentObject var filmotekaModel: FilmotekaViewModel
    @State private var newCategory: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(filmotekaModel.categories) { item in
                    HStack {
                        Text(item.name)
                        if item.name == movieCategory {
                            Spacer()
                            Rectangle()
                                .foregroundColor(.green)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .onTapGesture {
                        movieCategory = item.name
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .onDelete { index in
                    filmotekaModel.removeCategory(at: index)
                }

                TextField("New Category", text: $newCategory, onCommit: {
                    filmotekaModel.addCategory(newCategory)
                    movieCategory = newCategory
                    newCategory = ""
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
}
