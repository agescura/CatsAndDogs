//
//  ViewModel.swift
//  CatsAndDogs
//
//  Created by Albert Gil Escura on 18/4/21.
//

import CoreML
import Vision
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var result: String?
    
    private lazy var classificationRequest: VNCoreMLRequest = {
      do {
        let multiSnacks = try CatsAndDogs(configuration: MLModelConfiguration())
        let visionModel = try VNCoreMLModel(for: multiSnacks.model)

        let request = VNCoreMLRequest(model: visionModel, completionHandler: { [weak self] request, error in
          self?.processObservations(for: request, error: error)
        })

        request.imageCropAndScaleOption = .centerCrop
        return request
      } catch {
        fatalError("Failed to create VNCoreMLModel: \(error)")
      }
    }()
    
    func classify(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            print("Unable to create CIImage")
            return
        }
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification: \(error)")
            }
        }
    }
    
    private func processObservations(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if let results = request.results as? [VNClassificationObservation] {
                if results.isEmpty {
                    self?.result = "nothing found"
                } else {
                    let top3 = results.prefix(2).map { observation in
                        String(format: "%@ %.1f%%", observation.identifier, observation.confidence * 100)
                    }
                    self?.result = top3.joined(separator: "\n")
                }
            } else if let error = error {
                self?.result = "error: \(error.localizedDescription)"
            } else {
                self?.result = "???"
            }
        }
    }
}
