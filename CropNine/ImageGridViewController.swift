//
//  ImageGridViewController.swift
//  CropNine
//
//  Created by K Y on 11/18/19.
//  Copyright © 2019 K Y. All rights reserved.
//

/*
 1 2 3
 4 5 6
 7 8 9
 
 */
import UIKit

class ImageGridViewController: UIViewController {

    @IBOutlet var im1: UIImageView!
    @IBOutlet var im2: UIImageView!
    @IBOutlet var im3: UIImageView!
    @IBOutlet var im4: UIImageView!
    @IBOutlet var im5: UIImageView!
    @IBOutlet var im6: UIImageView!
    @IBOutlet var im7: UIImageView!
    @IBOutlet var im8: UIImageView!
    @IBOutlet var im9: UIImageView!
    
    @IBAction func uploadButtonAction(_ sender: Any) {
        let imPicker = UIImagePickerController()
        imPicker.delegate = self
        imPicker.sourceType = .photoLibrary
        present(imPicker, animated: true, completion: nil)
    }
    
    // MARK: - Utility Methods
    
    func emptyAll() {
        for v in view.subviews {
            if let imView = v as? UIImageView {
                imView.image = nil
            }
        }
    }
    
    func fill(with images: [UIImage]) {
        guard images.count == 9 else { return }
        im1.image = images[0]
        im2.image = images[1]
        im3.image = images[2]
        im4.image = images[3]
        im5.image = images[4]
        im6.image = images[5]
        im7.image = images[6]
        im8.image = images[7]
        im9.image = images[8]
    }
    
}

extension ImageGridViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer { picker.dismiss(animated: true, completion: nil) }
        guard let data = info[.originalImage],
            let im = data as? UIImage else {
            emptyAll()
            return
        }
        let croppedImages = im.divideIntoNine()
        fill(with: croppedImages)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        emptyAll()
    }
}
