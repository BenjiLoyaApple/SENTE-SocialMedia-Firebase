//
//  Post.swift
//  UPapp
//
//  Created by Benji Loya on 26/12/2022.
//

import SwiftUI

extension UIImage{
    func resizeImage(to: CGSize) -> UIImage? {
        let size = self.size
        let targetSize = CGSize(width: size.width < to.width ? size.width : to.width, height: size.height < to.height ? size.height : to.height)
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        /// - Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        /// - This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        /// - Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize,false,1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
