//
//  DisplayCollections.swift
//  Project-Document-Management
//
//  Created by Matthew Harrilal on 10/31/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class DisplayCollections: UITableViewController {
    var collectionNames: [ImageFile] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let networkInstance = AccessJSONCollections()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkInstance.networking { (data) in
                let collection = try? JSONDecoder().decode([ImageFile].self, from: data)
            self.collectionNames = collection!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let collection = collectionNames[indexPath.row]
        cell.textLabel?.text = collection.collectionName
        cell.detailTextLabel?.text = collection.zippedImagesUrl
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionNames.count
    }
}
