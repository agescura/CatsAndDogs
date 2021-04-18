//
//  ContentView.swift
//  CatsAndDogs
//
//  Created by Albert Gil Escura on 18/4/21.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    
    @State var isShowPhotoLibrary = false
    @State var isShowCamera = false
    @State var image = UIImage()
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10) {
                if viewModel.result != nil {
                    VStack {
                        Text(viewModel.result ?? "")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(20)
                }
                Spacer()
                Button(action: {
                    isShowCamera = true
                }) {
                    MediaButton(
                        systemName: "camera",
                        text: "Camera")
                }
                .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
                .opacity(!UIImagePickerController.isSourceTypeAvailable(.camera) ? 0.5 : 1.0)
                .sheet(isPresented: $isShowCamera) {
                    ImagePicker(selectedImage: $image.onUpdate(classify),
                                sourceType: .camera)
                }
                Button(action: {
                    isShowPhotoLibrary = true
                }) {
                    MediaButton(
                        systemName: "photo",
                        text: "Photo library")
                }
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(selectedImage: $image.onUpdate(classify),
                                sourceType: .photoLibrary)
                }
            }
        }
    }
    
    private func classify() {
        viewModel.classify(image: image)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
