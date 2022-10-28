import UIKit
import SwiftUI
import PlaygroundSupport
import Foundation

public class CameraView:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    let model = try! CDTClassifier()
    var imageView = UIImageView()
    var shootButton = UIButton()
    let picker = UIImagePickerController()
    
    public var screenType = false {
        didSet {
            if screenType {
                print("true")
                PlaygroundPage.current.setLiveView(self)
            } else {
                let predictionLabel = self.getPredictionFromModel()
                PlaygroundPage.current.setLiveView(ResultsView(predictionLabel: predictionLabel))
            }
        }
    }
    
    
    @IBAction func shootPhoto(){
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    //: Delegates
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        //print("passed dissmissal")
        
    }
    
    public struct ProgressResults: View {
        public var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    Text("Analyzing Results")
                }
            }
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let newImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ?? <#default value#>] as! UIImage
        imageView.image = newImage
        PlaygroundPage.current.setLiveView(ProgressResults())
        screenType = false
        
    }
    
    public func buffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    public func getPredictionFromModel() -> String{
        
        let image = imageView.image!
        
        var imageColors = averageColor(image: image)
        let sumImageColors = imageColors![0] + imageColors![1] + imageColors![2]
        
        if sumImageColors < 150+145+137 {
            return("NIL")
        }
        
        let pixelBuffer = buffer(from: image)
        
        do {
            print("before")
            let clock = try model.prediction(image: pixelBuffer!)
            print("after")
            return clock.classLabel
        } catch {
            print(error)
        }
        return ""
    }
    
    public func averageColor(image: UIImage) -> Array<CGFloat>? {
        
        guard let inputImage = CIImage(image: image) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return [CGFloat(bitmap[0]), CGFloat(bitmap[1]), CGFloat(bitmap[2])]
    }
}


