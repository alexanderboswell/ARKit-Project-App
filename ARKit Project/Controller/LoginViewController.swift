//
//  LoginViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/8/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	//MARK: Outlets
	
	@IBOutlet weak var googleButton: UIButton!
	@IBOutlet weak var facebookButton: UIButton!
	@IBOutlet weak var emailButton: UIButton!
	
	//MARK: Viewcontroller lifecycle
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	//MARK: Actions
	
	@IBAction func googleSignUp(_ sender: UIButton) {
	}
	
	@IBAction func facebookSignUp(_ sender: UIButton) {
	}
	
	@IBAction func emailSignUp(_ sender: UIButton) {
		
	}
	
	@IBAction func signIn(_ sender: UIButton) {
	
	}
	
	@IBAction func close(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
