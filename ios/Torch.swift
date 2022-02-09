//
//  Torch.swift
//  documentDeneme
//
//  Created by Alper Salık on 7.02.2022.


//import Foundation
//@objc(Torch)
//class Torch: NSObject {
//  @objc static func requiresMainQueueSetup() -> Bool {return true}
//
//  @objc static var isOn = false
//
//  @objc func turnOn() {
//    Torch.isOn = true
//
//  }
//
//  @objc func turnOff() {
//    Torch.isOn = false
//
//  }
//
//
//
//
//  @objc func getTorchStatus(_ callback: RCTResponseSenderBlock) {
//    callback([NSNull(), Torch.isOn])
//  }
//}


import Foundation
import VisionKit
import Vision
import UIKit

@objc(Torch)
class Torch : RCTEventEmitter, VNDocumentCameraViewControllerDelegate {

  @objc
  static override func requiresMainQueueSetup() -> Bool {
    return false
  }
  
  @objc
    func finishScan() {
      
      print("finished")
      sendEvent(withName: "finishScan", body: ["imageData": Torch.imagedata])
    }
  
  @objc
    override func supportedEvents() -> [String]! {
      return ["open","getTorchImageData", "getTorchImageText", "finishScan"];
    }
  
  @objc var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
  
  @objc private let textRecognitionWorkQueue = DispatchQueue(label: "MyVisionScannerQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
  
  @objc static var imagedata = ""
  @objc static var data = ""
  
  @objc static var detectedText = [String]()
  
  // Reference to use main thread
  @objc func open() -> Void {
    DispatchQueue.main.async {
      self._open()
      
    }
  }
  
  @objc func getTorchImageData(_ callback: RCTResponseSenderBlock) {
      callback([NSNull(), Torch.imagedata])
  }
  
  @objc func getTorchImageText(_ callback: RCTResponseSenderBlock) {
      callback([NSNull(), Torch.detectedText])
  }

  func _open() -> Void {
    setupVision()
    let controller = RCTPresentedViewController();
    let scanner = VNDocumentCameraViewController()
    scanner.delegate = self
    controller?.present(scanner, animated: true, completion: nil)
    
  }
  
  @objc
  func compressedImage(_ originalImage: UIImage) -> UIImage {
      guard let imageData = originalImage.jpegData(compressionQuality: 1),
          let reloadedImage = UIImage(data: imageData) else {
              return originalImage
      }
      return reloadedImage
  }
  
  @objc
  private func recognizeTextInImage(_ image: UIImage) {
      guard let cgImage = image.cgImage else { return }

      textRecognitionWorkQueue.async {
          let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
          do {
              try requestHandler.perform([self.textRecognitionRequest])
          } catch {
              print(error)
          }
      }
    
  }
  
    
  func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
   
            controller.dismiss(animated: true) { [weak self] in
              //self?.imageView.image = scan.imageOfPage(at: 0)
              let originalImage = scan.imageOfPage(at: 0)
              let newImage = self?.compressedImage(originalImage)
              //self?.recognizeTextInImage(newImage!)
              let imagedata = originalImage.jpegData(compressionQuality: 1)?.base64EncodedString()
              Torch.imagedata = imagedata ?? ""
              self?.finishScan()
            
              self?.recognizeTextInImage(newImage!)
              //guard let strongSelf = self else { return }
//              UIAlertController.present(title: "Success!", message: "Document \(scan.title) scanned with \(scan.pageCount) pages.", on: strongSelf)
          }
      }
  
//  func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
//      controller.dismiss(animated: true) { [weak self] in
//
//      }
//  }
//
//  func documentCameraViewControllerWithError(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
//      controller.dismiss(animated: true) { [weak self] in
//
//      }
//  }
  
 
  
  private func setupVision() {
      textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
          guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

          
          for observation in observations {
            print("observationssssss \(observation)")
              guard let topCandidate = observation.topCandidates(1).first else { return }
              print("text \(topCandidate.string) has confidence \(topCandidate.confidence)")

            Torch.detectedText.append(topCandidate.string)
            //Torch.detectedText += "\n"
            print(Torch.detectedText)
          }
      }

      textRecognitionRequest.recognitionLevel = .accurate
  }
 
  
  
}


  



