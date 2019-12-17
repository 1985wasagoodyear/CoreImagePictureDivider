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

final class ImageGridViewController: UIViewController {

    // MARK: - Storyboard Outlets
    
    @IBOutlet var im1: UIImageView!
    @IBOutlet var im2: UIImageView!
    @IBOutlet var im3: UIImageView!
    @IBOutlet var im4: UIImageView!
    @IBOutlet var im5: UIImageView!
    @IBOutlet var im6: UIImageView!
    @IBOutlet var im7: UIImageView!
    @IBOutlet var im8: UIImageView!
    @IBOutlet var im9: UIImageView!
    
    // MARK: - Custom Action Methods
    
    @IBAction func uploadButtonAction(_ sender: Any) {
        let imPicker = UIImagePickerController()
        imPicker.delegate = self
        imPicker.sourceType = .photoLibrary
        present(imPicker, animated: true, completion: nil)
    }
    
    // MARK: - Touch Override
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let rot = CABasicAnimation(keyPath: "transform.rotation")
        rot.duration = 5
        rot.fromValue = 0.0
        rot.toValue = (.pi * 2.0) * 5.0
        im1.layer.add(rot, forKey: "rot")
        im2.layer.add(rot, forKey: "rot")
        im3.layer.add(rot, forKey: "rot")
        im4.layer.add(rot, forKey: "rot")
        im5.layer.add(rot, forKey: "rot")
        im6.layer.add(rot, forKey: "rot")
        im7.layer.add(rot, forKey: "rot")
        im8.layer.add(rot, forKey: "rot")
        im9.layer.add(rot, forKey: "rot")
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
        // dismiss the picker when done
        defer { picker.dismiss(animated: true, completion: nil) }
        
        // fill the imageViews with a split image, if one exists
        guard let data = info[.originalImage],
            let im = data as? UIImage else {
            emptyAll()
            return
        }
        let croppedImages = im.divide(width: 3)
        fill(with: croppedImages)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
