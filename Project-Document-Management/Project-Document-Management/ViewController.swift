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
    
    let networkInstance = AccessJSONCollections()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        print("The download button is getting hit")
        networkInstance.networking { (data) in
            let collection = try? JSONDecoder().decode([ImageFile].self, from: data)
            self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        }
    }
    
}

