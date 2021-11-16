//
//  PausableObservableObject.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 07/11/2021.
//

import Foundation

class PausableObservableObject: ObservableObject {
    private var isPaused: Bool = false
    private var hasPendingUpdates = false
    var onResume: (() -> ())? = nil
    func publishWillUpdate() {
        if (!isPaused) {
            self.objectWillChange.send()
        } else {
            hasPendingUpdates = true
        }
    }
    func pause() {
        isPaused = true
    }
    func resume() {
        isPaused = false
        if hasPendingUpdates {
            hasPendingUpdates = false
            self.objectWillChange.send()
        }
        onResume?()
    }
}
