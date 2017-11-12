//
//  LaunchViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 11/11/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.loadGif(name: "Rocket")
    }
    
    @IBAction func showMainScreen(_ sender: Any) {
        performSegue(withIdentifier: "showMainScreenSegue", sender: sender)
    }
    
}

