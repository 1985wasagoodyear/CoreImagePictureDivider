//
//  UIImage+Crop.swift
//  CropNine
//
//  Created by K Y on 11/18/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

extension CGFloat {
    static func *(lhs: CGFloat, rhs: Int) -> CGFloat {
        return lhs * CGFloat(rhs)
    }
    static func /(lhs: CGFloat, rhs: Int) -> CGFloat {
        return lhs / CGFloat(rhs)
    }
}

extension UIImage {
    /// 'width'' is the number of images along one axis
    /// ex: a width of 3 returns 9 images
    func divide(width w: Int) -> [UIImage] {
        let sz = self.size
        var images = [UIImage]()
        
        // 1. make the image a square
        //    this handles rectangular images
        var width = min(sz.width, sz.height)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width),false, 0)
        
        // Remark: CIImage uses an inverted coordinate system, thus requires negatives
        self.draw(at: CGPoint(x: -(self.size.width - width) / 2.0,
                              y: -(self.size.height - width) / 2.0))
        let sqIm = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        // 2. Draw the divided square from that image
        width = width / w
        for i in 0..<w {
            for j in 0..<w {
                UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width),false, 0)
                let point = CGPoint(x: -(width * j),
                                    y: -(width * i))
                sqIm.draw(at: point)
                let square = UIGraphicsGetImageFromCurrentImageContext()
                
                images.append(square!)
                UIGraphicsEndImageContext()
            }
        }
        
        return images
    }
}
