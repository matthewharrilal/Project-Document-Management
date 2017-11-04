//
//  DisplayCollections.swift
//  Project-Document-Management
//
//  Created by Matthew Harrilal on 10/31/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Zip

class DisplayCollections: UITableViewController {
    var collectionNames: [ImageFile] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var collectionName: String?
    var imageURL: String?
    
    let networkInstance = AccessJSONCollections()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        networkInstance.networking { (data) in
            let collection = try? JSONDecoder().decode([ImageFile].self, from: data)
            self.collectionNames = collection!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let collection = collectionNames[indexPath.row]
        cell.textLabel?.text = collection.collectionName
        cell.detailTextLabel?.text = collection.identifierPath
        
        let caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        
        let cacheURL = URL(fileURLWithPath: caches)
        
        let newPath = collection.identifierPath.replacingOccurrences(of: ".zip", with: "")
        
        let contentsOfDirectory = try? FileManager.default.contentsOfDirectory(at: (cacheURL.appendingPathComponent(newPath)), includingPropertiesForKeys: nil, options: []).filter{ $0.pathExtension == "png"}[0]
        print(contentsOfDirectory)
        let imageData = try? Data(contentsOf: contentsOfDirectory!)
        
        
        DispatchQueue.main.async {
            
            cell.imageView?.image = UIImage(data: imageData!)
            self.tableView.reloadData()
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionNames.count
    }
    
    
}
