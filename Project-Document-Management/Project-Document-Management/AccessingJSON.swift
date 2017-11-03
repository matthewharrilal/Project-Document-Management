//
//  ZippingFile.swift
//  Project-Document-Management
//
//  Created by Matthew Harrilal on 10/30/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import Zip
import UIKit


class AccessJSONCollections {
    let session = URLSession.shared
    func networking(completionHandler: @escaping (Data) -> Void) {
        var getRequest = URLRequest(url: URL(string: "https://api.myjson.com/bins/17ge17")!)
        getRequest.httpMethod = "GET"
        session.dataTask(with: getRequest) { (data, response, error) in
            if let data = data {
                print(response)
               completionHandler(data)
            }
        }.resume()
    }
}


