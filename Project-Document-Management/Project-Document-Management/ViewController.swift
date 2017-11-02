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
    let instance = CollectionDownloadNetworkingLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unzipButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.instance.getCollections(route: .forest(), requestRoute: .get) { (url) in
                //                let filePath = Bundle.main.url(forResource: "forest", withExtension: "zip")!
                //                let temporaryDirectory = FileManager.default.temporaryDirectory
                //                do {
                //                    let unzipDirectory = try? Zip.unzipFile(filePath, destination: temporaryDirectory, overwrite: true, password: "password", progress: { (progress) in
                //                        print(progress)
                //                    })
                //                    print(unzipDirectory)
                //                }
                //                catch {
                //                    print("could not unzip the document")
                //                }
                let temporaryDirectory = FileManager.default.temporaryDirectory
                do {
                    let unzipDirectory = try? Zip.unzipFile(url!, destination: temporaryDirectory, overwrite: true, password: "password", progress: { (progress) in
                        print(progress)
                    })
                    print(unzipDirectory)
                }
            }
        }
        
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
    
    @IBAction func lionButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.instance.getCollections(route: .lion(), requestRoute: .get, completionHandler: { (url) in
               
                //                let temporaryDirectory = FileManager.default.temporaryDirectory
                //                    let destination = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let urlPath = "file:///Users/matthewharrilal/Library/Developer/CoreSimulator/Devices/4D11677B-358D-44A2-8D76-AA4A833AD2A1/data/Containers/Data/Application/D77E2098-56C0-400C-9D69-0D5E21025755/Library/Caches"
                
                do {
                    let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .allDomainsMask)[0]
//                    let datapath = libraryDirectory.appendingPathComponent(String(describing: urlPath))
                    let dataPath = libraryDirectory.appendingPathComponent("lion.zip")
                    
                    
                    let createdDirectory = try? FileManager.default.createDirectory(at: dataPath, withIntermediateDirectories: true, attributes: nil)
                    

                    
                    let unzipDirectory = try? Zip.unzipFile(url!, destination: libraryDirectory , overwrite: true, password: "password", progress: { (progress) in
                        print(progress)
                    })
                    print(createdDirectory)
                
                }
            })
        }
        
    }
    
    @IBOutlet weak var swimmingButton: UIButton!
    
}




