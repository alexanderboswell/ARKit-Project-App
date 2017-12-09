//
//  ActivitiesViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/8/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit
private let sectionInsets = UIEdgeInsets(top: 6.0, left: 4.0, bottom: 6.0, right: 4.0)
private let itemsPerRow: CGFloat = 1
private let reuseIdentifier = "ActivityCell"

class ActivitiesViewController: UICollectionViewController {
    
    private let activities = [Activity(title: "Earth", imageName: "EarthActivity"),
                              Activity(title: "Earth", imageName: "EarthActivity"),
                              Activity(title: "Earth", imageName: "EarthActivity"),
                              Activity(title: "Earth", imageName: "EarthActivity"),
                              Activity(title: "Earth", imageName: "EarthActivity"),
                              Activity(title: "Earth", imageName: "EarthActivity"),
                              Activity(title: "Earth", imageName: "EarthActivity"),
                              Activity(title: "Earth", imageName: "EarthActivity")]


	
	//MARK: View Controller lifecycle
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "OpenARSCNScene" {
			if let vc = segue.destination as? SolarSystemViewController {
				vc.fileName = "Earth"
			}
		}
	}
	
	
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ActivityCell else {
            return UICollectionViewCell()
        }
        let activity = activities[indexPath.row]
        cell.title.text = activity.title
        cell.image.image = activity.image
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        return cell
    }
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "OpenARSCNScene", sender: nil)
	}
}
extension ActivitiesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * ( itemsPerRow + 1)
        //        if UIDevice.current.orientation ==  UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: view.frame.width - paddingSpace, height: view.frame.height / 4)
        } else {
            return CGSize(width: view.frame.width - paddingSpace, height: view.frame.height / 8)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
