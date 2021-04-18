//
//  CatsAndDogsApp.swift
//  CatsAndDogs
//
//  Created by Albert Gil Escura on 18/4/21.
//

import SwiftUI

@main
struct CatsAndDogsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
