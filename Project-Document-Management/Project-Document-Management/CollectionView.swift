//
//  CollectionView.swift
//  Project-Document-Management
//
//  Created by Matthew Harrilal on 11/3/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class DisplayImages: UICollectionViewController {
    
    var pathways: [ImageFile] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
   
    
    var identifierPathz: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(identifierPathz)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getCount() -> Int {
        let newPath = identifierPathz?.replacingOccurrences(of: ".zip", with: "")
        
        print(newPath)
        
        let caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        var cacheURL = URL(fileURLWithPath: caches)
        let contentsOfDirectory = try? FileManager.default.contentsOfDirectory(at: cacheURL.appendingPathComponent(newPath!), includingPropertiesForKeys: nil, options: []).filter{ $0.pathExtension == "jpeg"}
        return (contentsOfDirectory?.count)!
    }
    
    func getImages() -> [URL] {
        let newPath = identifierPathz?.replacingOccurrences(of: ".zip", with: "")
        
        print(newPath)
        
        let caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        var cacheURL = URL(fileURLWithPath: caches)
        let contentsOfDirectory = try? FileManager.default.contentsOfDirectory(at: cacheURL.appendingPathComponent(newPath!), includingPropertiesForKeys: nil, options: []).filter{ $0.pathExtension == "jpeg"}
        return contentsOfDirectory!
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return getCount()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let newPath = identifierPathz?.replacingOccurrences(of: ".zip", with: "")
        
        print(newPath)
        
        let caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        var cacheURL = URL(fileURLWithPath: caches)
        let contentsOfDirectory = try? FileManager.default.contentsOfDirectory(at: cacheURL.appendingPathComponent(newPath!), includingPropertiesForKeys: nil, options: []).filter{ $0.pathExtension == "jpeg"}
        DispatchQueue.main.async {
            print(contentsOfDirectory)
            
            let imageURL = self.getImages()[indexPath.row]
            print(imageURL)
            
            
                let imageData = try? Data(contentsOf: imageURL)
            
//
            cell.zippedImageView.image = UIImage(data: imageData!)
                self.collectionView?.reloadData()
                
            
        }
      
        
        
        
        return cell
    }
}
