//
//  MainScreenViewController.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 11/11/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBAction func showSolarSystem(_ sender: Any) {
        performSegue(withIdentifier: "showSolarSystemSegue", sender: sender)
    }
    

}
