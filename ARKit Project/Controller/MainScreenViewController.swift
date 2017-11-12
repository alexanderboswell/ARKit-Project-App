//
//  MainScreenViewController.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 11/11/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    let solarSystemItems = ["Solar System", "Sun", "Moon", "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let solarSystemVC = segue.destination as? SolarSystemViewController, let fileName = sender as? String {
            solarSystemVC.fileName = fileName
        }
    }
    
}

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlanetSegue", sender: solarSystemItems[indexPath.row].withoutWhitespaces())
    }
    
}

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return solarSystemItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath)
        cell.textLabel?.text = solarSystemItems[indexPath.row]
        return cell
    }
    
}

