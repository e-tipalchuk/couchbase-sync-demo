//
//  ImageModel.swift
//  CouchbaseSyncDemo
//
//  Created by Сергей Петунин on 15.04.15.
//  Copyright (c) 2015 Центр ИТ. All rights reserved.
//

import Foundation

@objc
class ImageModel: CBLModel {
    
    @NSManaged var timestamp_added: NSString
    
    var imageInternal: UIImage?
    
    var image: UIImage? {
        if (imageInternal == nil) {
            imageInternal = UIImage(data: self.attachmentNamed("image").content)
        }
        return imageInternal
    }
    
}