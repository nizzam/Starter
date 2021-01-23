//
//  ImagePicker.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit
import AVFoundation
import Photos
import PhotosUI

protocol ImagePickerDelegate: class {
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType)
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage)
    func imagePHPicker(selected images: [UIImage])
    func cancelButtonDidClick(on imageView: ImagePicker)
}

class ImagePicker: NSObject {
    
    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil
    
    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
    
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType, limitAvailability: Int = 0) {
        if #available(iOS 14, *) {
            setupPHPickerViewController(viewController, limitAvailability)
        } else {
            setupUIImagePickerController(viewController, sourceType)
        }
    }
    
    private func setupUIImagePickerController(_ viewController: UIViewController, _ sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller

        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    @available(iOS 14, *)
    private func setupPHPickerViewController(_ viewController: UIViewController, _ limitAvailability: Int) {
        /// Create configuration for photo picker
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images])
        configuration.selectionLimit = limitAvailability
        
        /// Create instance of PHPickerController
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

//  MARK:- PHPickerController Delegate
@available(iOS 14, *)
extension ImagePicker: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        let imageGroup = DispatchGroup()
        
        /// Get the reference of itemProvider from results
        var selectedImages = [UIImage]()
        
        for result in results {
            imageGroup.enter()
            
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                    if let err = error {
                        print("Error PHPickerController :", err)
                    }
                    
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            print("Selected image: \(image)")
                            selectedImages.append(image)
                        }
                    }
                    imageGroup.leave()
                })
            }
        }
        
        imageGroup.notify(queue: .main) {
            self.delegate?.imagePHPicker(selected: selectedImages)
        }
    }
}

//  MARK:- Picker
extension ImagePicker {
    
    private enum TargetName {
        case NoCamera, Camera, PhotoGallery
        
        var title: String {
            switch self {
            case .NoCamera: return "Camera not found"
            case .Camera: return "Camera"
            case .PhotoGallery: return "Photo Gallery"
            }
        }
    }
    
    private func showAlert(targetName: TargetName, completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            var alertVC: UIAlertController?
                
            
            if targetName == .NoCamera {
                alertVC = UIAlertController(title: targetName.title,
                                            message: nil,
                                            preferredStyle: .alert)
            } else {
                alertVC = UIAlertController(title: "Access to the \(targetName.title)",
                                            message: "Please provide access to your \(targetName.title)",
                                            preferredStyle: .alert)
                
                alertVC?.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                    
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                            UIApplication.shared.canOpenURL(settingsUrl) else {
                        completion?(false)
                        return
                    }
                    
                    UIApplication.shared.open(settingsUrl, options: [:]) { [weak self] _ in
                        self?.showAlert(targetName: targetName, completion: completion)
                    }
                }))
            }
            
            alertVC?.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion?(false) }))
            
            UIApplication.shared.windows
                .filter { $0.isKeyWindow }.first?
                .rootViewController?.present(alertVC ?? .init(), animated: true, completion: nil)
        }
    }
    
    func openImagePicker() {
        let pickerAlert = UIAlertController(title: "", message: "Choose Source", preferredStyle: .actionSheet)
        pickerAlert.addAction(UIAlertAction(title: "From Camera", style: .default, handler: { [weak self] (action) in
            DispatchQueue.main.async {
                self?.cameraAccessRequest()
            }
        }))

        pickerAlert.addAction(UIAlertAction(title: "From Gallery", style: .default, handler: { [weak self] (action) in
            DispatchQueue.main.async {
                self?.photoGalleryAccessRequest()
            }
        }))

        pickerAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] (action) in
            DispatchQueue.main.async {
                self?.dismiss()
            }
        }))
        
        DispatchQueue.main.async {
            UIApplication.shared.windows
                .filter { $0.isKeyWindow }.first?
                .rootViewController?.present(pickerAlert, animated: true, completion: nil)
        }
    }
    
    private func cameraAccessRequest() {
        if delegate == nil { return }
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            showAlert(targetName: .NoCamera, completion: nil)
            return
        }
        
        let source = UIImagePickerController.SourceType.camera
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch authStatus {
        case .denied, .restricted: showAlert(targetName: .Camera, completion: nil)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                
                if granted {
                    self.delegate?.imagePicker(self, grantedAccess: granted, to: source)
                } else {
                    self.showAlert(targetName: .Camera) { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
                }
            }
        default: delegate?.imagePicker(self, grantedAccess: true, to: source)
        }
    }

    private func photoGalleryAccessRequest() {
        let source = UIImagePickerController.SourceType.photoLibrary
        let authStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authStatus {
        case .denied, .restricted: showAlert(targetName: .PhotoGallery, completion: nil)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] result in
                guard let self = self else { return }

                if result == .authorized {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.delegate?.imagePicker(self, grantedAccess: result == .authorized, to: source)
                    }
                    
                } else {
                    self.showAlert(targetName: .PhotoGallery) { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
                }
            }
        default: delegate?.imagePicker(self, grantedAccess: true, to: source)
        }
    }
}

//  MARK:- UINavigationControllerDelegate
extension ImagePicker: UINavigationControllerDelegate { }

//  MARK:- UIImagePickerControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
            
        } else {
            print("Other source")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}
