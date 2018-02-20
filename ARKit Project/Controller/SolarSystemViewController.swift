//
//  ViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 11/11/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class SolarSystemViewController: UIViewController {
	
	//MARK: Outlets
	@IBOutlet var sceneView: ARSCNView!
	@IBOutlet weak var searchingLabel: UILabel!
	
	
	let planets = Planets()
	var fileName: String!
	var longPressStartPosition: CGPoint!
	var startingNodeStartPosition: SCNVector3!
	
	let session = ARSession()
	let sessionConfiguration: ARWorldTrackingConfiguration = {
		let config = ARWorldTrackingConfiguration()
		config.planeDetection = .horizontal
		return config
	}()
	
	var focalNode: FocalNode?
	private var screenCenter: CGPoint!
	private var modelNode: SCNNode!
	private var selectedNode: SCNNode?
	private var sceneAdded = false
	
	
	//MARK: Viewcontroller lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let fileName = fileName else {
			return
		}
		title = fileName
		
		// Store screen center here so it can be accessed off of the main thread
		screenCenter = view.center
		
		// Set the view's delegate
		sceneView.delegate = self
		
		// Show statistics such as fps and timing information
		sceneView.showsStatistics = true
		sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
		
		// Update at 60 frames per second (recommended by Apple)
		sceneView.preferredFramesPerSecond = 60
		
		// Make sure that ARKit is supported
		if ARWorldTrackingConfiguration.isSupported {
			session.run(sessionConfiguration, options: [.removeExistingAnchors, .resetTracking])
		} else {
			print("Sorry, your device doesn't support ARKit")
		}
		
		// Use the session that we created
		sceneView.session = session
		
		// Create a new scene
		guard let modelScene = SCNScene(named: "art.scnassets/\(fileName).scn") else {
			return
		}
		
		// Get the model from the root node of the scene
		modelNode = modelScene.rootNode
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		// Pause the view's session
		sceneView.session.pause()
	}
	
	//MARK: Actions
	@IBAction func tap(_ gesture: UITapGestureRecognizer) {
		if !sceneAdded {
			// Make sure we've found the floor
			guard let focalNode = focalNode else { return }
			
			// See if we tapped on a plane where a model can be placed
			let results = sceneView.hitTest(screenCenter, types: .existingPlane)
			guard let transform = results.first?.worldTransform else { return }
			
			// Find the position to place the model
			let position = float3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
			
			// Create a copy of the model set its position/rotation
			let newNode = modelNode.flattenedClone()
			newNode.simdPosition = position
			
			// Add the model to the scene
			sceneView.scene.rootNode.addChildNode(newNode)
			for node in focalNode.childNodes {
				node.removeFromParentNode()
			}
			sceneAdded = true
			setupPlanetAnimations(node: sceneView.scene.rootNode)
		}
	}
	
	@IBAction func pan(_ gesture: UIPanGestureRecognizer) {
		// Find the location in the view
		let location = gesture.location(in: sceneView)
		
		switch gesture.state {
		case .began:
			// Choose the node to move
			selectedNode = node(at: location)
		case .changed:
			// Move the node based on the real world translation
			guard let result = sceneView.hitTest(location, types: .existingPlane).first else { return }
			
			let transform = result.worldTransform
			let newPosition = float3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
			selectedNode?.simdPosition = newPosition
		default:
			// Remove the reference to the node
			selectedNode = nil
		}
	}
	
	@IBAction func pinch(_ gesture: UIPinchGestureRecognizer) {
		for node in sceneView.scene.rootNode.childNodes {
			SCNTransaction.animationDuration = 0.1
			let pinchScaleX = Float(gesture.scale) * node.scale.x
			let pinchScaleY =  Float(gesture.scale) * node.scale.y
			let pinchScaleZ =  Float(gesture.scale) * node.scale.z
			
			let scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
			if scale.x > 0.01 && scale.x < 0.15 {
				node.scale = scale
			}
			gesture.scale = 1
		}
	}
	
	@IBAction func longPressTranslate(_ sender: UILongPressGestureRecognizer) {
		guard let startingNode = sceneView.scene.rootNode.childNode(withName: "starting point", recursively: true) else {
			return
		}
		
		let location: CGPoint = sender.location(in: sender.view)
		
		if let rootLocation = startingNodeStartPosition, longPressStartPosition != nil {
			SCNTransaction.animationDuration = 1.0
			let yDiff: Float = Float(location.y - longPressStartPosition.y) * 0.1
			startingNode.position = SCNVector3.init(rootLocation.x,
													rootLocation.y - yDiff,
													rootLocation.z)
		}
		
	}
	
	//MARK: Custom Methods
	private func node(at position: CGPoint) -> SCNNode? {
		return sceneView.hitTest(position, options: nil)
			.first(where: { $0.node !== focalNode && $0.node !== modelNode })?
			.node
	}
	
	private func setupPlanetAnimations(node parentNode: SCNNode) {
		for node in parentNode.childNodes {
			if let nodeName = node.name, nodeName.contains("Planet") {
				let planet = planets[nodeName]
				if let orbitNode = node.parent, let orbitNodeName = orbitNode.name, orbitNodeName.contains("Orbit") {
					orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: planet.revolutionSpeed)))
					print("\(orbitNodeName) revolution was set")
				}
				node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: planet.rotationSpeed)))
				print("\(nodeName) rotation was set")
			}
			setupPlanetAnimations(node: node)
		}
	}
	
	private func show() {
		sceneView.scene.rootNode.isHidden = false
	}
	
	private func hide() {
		sceneView.scene.rootNode.isHidden = true
	}
	
	private func saveLocations(tapLocation: CGPoint) {
		guard let startingNode = sceneView.scene.rootNode.childNode(withName: "starting point", recursively: true) else {
			return
		}
		longPressStartPosition = tapLocation
		startingNodeStartPosition = startingNode.position
	}
	
	static func makeFromStoryboard() -> SolarSystemViewController {
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SolarSystemViewController") as! SolarSystemViewController
	}
}

extension SolarSystemViewController: ARSCNViewDelegate {
	func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
		// If we have already created the focal node we should not do it again
		guard focalNode == nil else { return }
		
		// Create a new focal node
		let node = FocalNode()
		node.addChildNode(modelNode)
		
		// Add it to the root of our current scene
		sceneView.scene.rootNode.addChildNode(node)
		
		// Store the focal node
		self.focalNode = node
		
		// Hide the label (making sure we're on the main thread)
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.5, animations: {
				self.searchingLabel.alpha = 0.0
				self.sceneView.debugOptions = []
			}, completion: { _ in
				self.searchingLabel.isHidden = true
			})
		}
	}
	
	func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
		// If we haven't established a focal node yet do not update
		guard let focalNode = focalNode else { return }
		
		// Determine if we hit a plane in the scene
		let hit = sceneView.hitTest(screenCenter, types: .existingPlane)
		
		// Find the position of the first plane we hit
		guard let positionColumn = hit.first?.worldTransform.columns.3 else { return }
		
		// Update the position of the node
		focalNode.position = SCNVector3(x: positionColumn.x, y: positionColumn.y, z: positionColumn.z)
	}
}

