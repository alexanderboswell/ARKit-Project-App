//
//  ModuleViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/7/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

private let sectionInsets = UIEdgeInsets(top: 1.0, left: 2.0, bottom: 1.0, right: 2.0)
private let itemsPerRow: CGFloat = 2
private let reuseIdentifier = "ModuleCell"

class ModuleViewController: UICollectionViewController {

	private var modules = [Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 176/255, green: 0/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 3/255, green: 176/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 176/255, green: 0/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 3/255, green: 176/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 176/255, green: 0/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
						   Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 3/255, green: 176/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem")]

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modules.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ModuleCell else {
			return UICollectionViewCell()
		}
		let module = modules[indexPath.row]
		cell.titleLabel.text = module.title
		cell.descriptionLabel.text = module.description
		cell.backgroundColor = module.backgroundColor
		cell.image.image = module.image
    	cell.layer.cornerRadius = 10
        return cell
    }
}
extension ModuleViewController : UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let paddingSpace = sectionInsets.left * ( itemsPerRow + 1)
//		if UIDevice.current.orientation ==  UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
		if UIDevice.current.orientation.isLandscape {
			return CGSize(width: view.frame.width / 2 - 10, height: view.frame.height / 2.8)
		} else {
			return CGSize(width: view.frame.width - paddingSpace, height: view.frame.height / 5)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return sectionInsets
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return sectionInsets.left
	}
}
