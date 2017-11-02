//
//  DownloadingZipFile.swift
//  Project-Document-Management
//
//  Created by Matthew Harrilal on 11/1/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


struct Endpoint {
    static var endpoint = ""
}

enum CollectionRoutes {
    case forest()
    case lion()
    case swimming()
    
    func path() -> String {
        switch self {
        case .forest():
            return "/aands9xm93r35zk/forest.zip"
        case .lion():
            return "/8l0nldlhd97xcqa/lion.zip"
        case .swimming():
            return "/aisziyxj55859ob/swimming.zip"
        }
    }
}

enum DifferentHttpsMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class CollectionDownloadNetworkingLayer {
    var baseURL = "https://www.mediafire.com/file"
    let session = URLSession.shared
    func getCollections(route: CollectionRoutes, requestRoute: DifferentHttpsMethods, completionHandler: @escaping (URL?) -> Void) {
        var fullUrlString = URL(string: baseURL.appending(route.path()))
        var getRequest = URLRequest(url: fullUrlString!)
        getRequest.httpMethod = requestRoute.rawValue
        
        session.downloadTask(with: getRequest) { (url, response, error) in
            if let url = url {
//                print(response)
//                print(url)
                 completionHandler(url)
            }
           
        }.resume()
        
        
    }
}
