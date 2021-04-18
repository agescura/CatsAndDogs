//
//  Binding+.swift
//  CatsAndDogs
//
//  Created by Albert Gil Escura on 18/4/21.
//

import SwiftUI

extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}
