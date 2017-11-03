//
//  ImageModel.swift
//  Project-Document-Management
//
//  Created by Matthew Harrilal on 10/30/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

struct ImageFile {
    var collectionName: String
    var zippedImagesUrl: URL
    var images = [String]()
    var identifierPath: String
    
    init(collectionName: String, zippedImagesUrl: URL, identifierPath: String) {
        self.collectionName = collectionName
        self.zippedImagesUrl = zippedImagesUrl
        self.identifierPath = identifierPath
    }
}

extension ImageFile: Decodable {
    enum Keys: String, CodingKey {
        case collectionName = "collection_name"
        case zippedImagesUrl = "zipped_images_url"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let collectionName = try container.decode(String.self, forKey: .collectionName)
        let zippedImagesUrl = try container.decode(URL.self, forKey: .zippedImagesUrl)
        
        let identifierPath = zippedImagesUrl.lastPathComponent
        self.init(collectionName: collectionName, zippedImagesUrl: zippedImagesUrl, identifierPath: identifierPath)
        
    }
}
