//
//  MediaButton.swift
//  CatsAndDogs
//
//  Created by Albert Gil Escura on 18/4/21.
//

import SwiftUI

struct MediaButton: View {
    
    var systemName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .font(.system(size: 20))

            Text(text)
                .font(.headline)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
