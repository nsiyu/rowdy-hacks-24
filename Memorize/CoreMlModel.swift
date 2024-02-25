import CoreML
import Vision
import UIKit

class CoreMLClassifier {
    private var model: VNCoreMLModel
    
    init() {
        do {
            let coreMLModel = try CoreMLModel(configuration: MLModelConfiguration())
            self.model = try VNCoreMLModel(for: coreMLModel.model)
        } catch {
            fatalError("Failed to load CoreML model: \(error.localizedDescription)")
        }
    }
    
    func classify(image: UIImage, completion: @escaping (String) -> Void) {
        guard let ciImage = CIImage(image: image) else {
            fatalError("Could not convert UIImage to CIImage.")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNCoreMLFeatureValueObservation],
                  let firstResult = results.first,
                  let multiArray = firstResult.featureValue.multiArrayValue else {
                fatalError("Unexpected result type or missing multiArray from VNCoreMLRequest.")
            }
            print(multiArray)
            let probabilities = (0..<multiArray.count).map { multiArray[$0].floatValue }
            let maxIndex = probabilities.argmax()
            completion("Predicted class index: \(maxIndex), Probabilities: \(probabilities)")
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform classification.\n\(error.localizedDescription)")
        }
    }
}

extension Array where Element == Float {
    func argmax() -> Int? {
        guard let maxValue = self.max() else { return nil }
        return self.firstIndex(of: maxValue)
    }
}
