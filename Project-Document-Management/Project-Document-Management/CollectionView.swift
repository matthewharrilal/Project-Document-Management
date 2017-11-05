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
   
    
    var identifierPaths = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(identifierPaths)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let newPath = identifierPaths.replacingOccurrences(of: ".zip", with: "")
        print(newPath)
        
        let caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        var cacheURL = URL(fileURLWithPath: caches)
        let contentsOfDirectory = try? FileManager.default.contentsOfDirectory(at: cacheURL.appendingPathComponent("swimming"), includingPropertiesForKeys: nil, options: []).filter{ $0.pathExtension == "jpeg"}[1]
        
        let imageData = try? Data(contentsOf: contentsOfDirectory!)
        
        DispatchQueue.main.async {
            cell.zippedImageView.image = UIImage(data: imageData!)
            self.collectionView?.reloadData()
        }
        
        
        
        
        return cell
    }
}
