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
    
    var collectionName: String?
    var imageURL: String?
    
    let networkInstance = AccessJSONCollections()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        networkInstance.networking { (data) in
            let collection = try? JSONDecoder().decode([ImageFile].self, from: data)
            self.collectionNames = collection!
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Essentially since we put the code in the viewdidload we can download the images and have them show on the table view cells
        //So what we have to do is essentially store resource then move it to the temporary folder
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
