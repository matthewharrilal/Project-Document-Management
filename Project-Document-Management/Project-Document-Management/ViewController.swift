//
//  ViewController.swift
//  Project-Document-Management
//
//  Created by Matthew Harrilal on 10/30/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import UIKit
import Zip

class ViewController: UIViewController {
    
    @IBOutlet weak var downloadUrlTextField: UITextField!
    
    var collectionName: String?
    var imageURL:String?
    
    let networkInstance = AccessJSONCollections()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let fileManager = FileManager.default
//        var temporaryDirectory:URL?
//        let urls = try? fileManager.url(for: .itemReplacementDirectory, in: .allDomainsMask, appropriateFor: temporaryDirectory , create: true)
//        if let tempDirectory = urls {
//            let tempURL = tempDirectory.appendingPathComponent(<#T##pathComponent: String##String#>)
//        }
        writeToTemporary()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        print("The download button is getting hit")
        networkInstance.networking { (data) in
            var collection = try? JSONDecoder().decode([ImageFile].self, from: data)
            print("this is the collection \(collection)")
            self.performSegue(withIdentifier: "toCollections", sender: nil)
            
        }
    }
    
    func writeToTemporary() {
        let url = URL(string: "https://www.mediafire.com/file/aands9xm93r35zk/forest.zip")
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            var documentsDirectory: String?
            var paths = NSSearchPathForDirectoriesInDomains(.itemReplacementDirectory, .allDomainsMask, true)
            if paths.count > 0 {
                documentsDirectory = paths[0]
                FileManager.default.createFile(atPath: documentsDirectory!, contents: data, attributes: nil)
                print("The download was succesful")
            }
        }
    }
    
}




