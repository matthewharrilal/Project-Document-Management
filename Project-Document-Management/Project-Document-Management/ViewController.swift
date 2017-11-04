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
                let caches = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
                var new_extension = Zip.addCustomFileExtension("tmp")
                let cachesURL = URL(string: caches)
                let unzip = try? Zip.unzipFile(url!, destination: cachesURL!, overwrite: false, password: "password", progress: { (progress) in
                    
                })
                print(unzip)
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
                var new_extension = Zip.addCustomFileExtension("tmp")
                //So first what do we need to do what we have to do essentially is that we have to first get the file from the data which is what we are getting which is a url or a pathway now we have to unzip it to do that we have to have a place to write the documents
                let caches = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
                var cacheURL = URL(string: caches)
                
                let unzip = try? Zip.unzipFile(url!, destination: cacheURL!, overwrite: true, password: "password", progress: { (progress) in
                    
                })
                print(unzip)
            })
        }
        
    }
    
    @IBAction func swimmingButton(_ sender: Any) {
        self.instance.getCollections(route: .swimming(), requestRoute: .get) { (url) in
            var new_extension = Zip.addCustomFileExtension("tmp")
            //So first what do we need to do what we have to do essentially is that we have to first get the file from the data which is what we are getting which is a url or a pathway now we have to unzip it to do that we have to have a place to write the documents
            let caches = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
            var cacheURL = URL(string: caches)
            
            let unzip = try? Zip.unzipFile(url!, destination: cacheURL!, overwrite: true, password: "password", progress: { (progress) in
                
            })

        }
    }
    
}




