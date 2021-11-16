//
//  VisibilityAwareObservables.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 07/11/2021.
//

import SwiftUI

struct VisibilityAwareObservables: ViewModifier {
    let observables: [PausableObservableObject]
    func body(content: Content) -> some View {
        AnyView(content)
            .onAppear {
                for observable in observables {
                    observable.resume()
                }
            }
            .onDisappear {
                for observable in observables {
                    observable.pause()
                }
            }
    }
}
extension View {
    func visibilityAwareObservables(observables: [PausableObservableObject]) -> some View {
        ModifiedContent(content: self, modifier: VisibilityAwareObservables(observables: observables))
    }
}
