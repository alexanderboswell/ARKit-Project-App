//
//  SignInViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/9/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

	//MARK: Outlets
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	//MARK: Viewcontroller lifecycle
	
	override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	//MARK: Actions
	
	@IBAction func signIn(_ sender: UIButton) {
	
	}
	
	@IBAction func signInGoogle(_ sender: UIButton) {
	
	}
	
	@IBAction func signInFacebook(_ sender: UIButton) {
	}
	
	@IBAction func close(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	
}
