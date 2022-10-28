import CoreML

public class CDTClassifierInput: MLFeatureProvider {
    var image: CVPixelBuffer
    
    public var featureNames: Set<String> {
        get {
            return ["image"]
        }
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "image") {
            return MLFeatureValue(pixelBuffer: image)
        }
        return nil
    }
    
    public init(image: CVPixelBuffer) {
        self.image = image
    }
}

public class CDTClassifierOutput: MLFeatureProvider {
    private let provider: MLFeatureProvider
    
    public lazy var classLabelProbs: [String : Double] = {
        [unowned self] in return self.provider.featureValue(for: "classLabelProbs")!.dictionaryValue as! [String:Double]
    }()
    
    public lazy var classLabel: String = {
        [unowned self] in return self.provider.featureValue(for: "classLabel")!.stringValue
    }()
    
    public var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }
    
    public init(features: MLFeatureProvider) {
        self.provider = features
    }
    
    public init(classLabelProbs: [String:Double], classLabel: String) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["classLabelProbs":MLFeatureValue(dictionary: classLabelProbs as [AnyHashable:NSNumber]), "classLabel": MLFeatureValue(string: classLabel)])
    }
}

public class CDTClassifier {
    var model: MLModel
    
    public init() throws{
        self.model = try MLModel(contentsOf: MLModel.compileModel(at: #fileLiteral(resourceName: "CDTClassifier.mlmodel")), configuration: MLModelConfiguration())
    }
    
    public func prediction(input: CDTClassifierInput) throws -> CDTClassifierOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }
    
    public func prediction(input: CDTClassifierInput, options: MLPredictionOptions) throws -> CDTClassifierOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return CDTClassifierOutput(features: outFeatures)
    }
    
    public func prediction(image: CVPixelBuffer) throws -> CDTClassifierOutput {
        let input_ = CDTClassifierInput(image: image)
        return try self.prediction(input: input_)
    }
}
