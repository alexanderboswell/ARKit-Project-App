//
//  EditProfileViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/13/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController {

    //MARK: Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    //MARK: Viewcontroller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: Custom methods
    
    private func setupUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }
    
    //MARK: Actions
    
    @IBAction func editProfileImage(_ sender: UIButton) {
    }
    
    @IBAction func endEditingName(_ sender: UITextField) {
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        //TODO: save user profile
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
