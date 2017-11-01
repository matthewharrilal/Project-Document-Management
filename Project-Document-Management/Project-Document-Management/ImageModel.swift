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
    var collectionName: String?
    var zippedImagesUrl: String?
    init(collectionName: String?, zippedImagesUrl: String?) {
        self.collectionName = collectionName
        self.zippedImagesUrl = zippedImagesUrl
    }
}

extension ImageFile: Decodable {
    enum Keys: String, CodingKey {
        case collectionName = "collection_name"
        case zippedImagesUrl = "zipped_images_url"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        var collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName)
        var zippedImagesUrl = try container.decodeIfPresent(String.self, forKey: .zippedImagesUrl)
        self.init(collectionName: collectionName, zippedImagesUrl: zippedImagesUrl)
    }
}
