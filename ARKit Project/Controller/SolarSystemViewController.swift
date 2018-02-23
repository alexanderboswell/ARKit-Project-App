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
	@IBOutlet weak var playPauseButton: UIButton!
	
	//MARK: Public variables
	var fileName: String!
	
	//MARK: Private variables
	private let planets = Planets()
	private var longPressStartPosition: CGPoint!
	private var startingNodeStartPosition: SCNVector3!
	private let session = ARSession()
	private let sessionConfiguration: ARWorldTrackingConfiguration = {
		let config = ARWorldTrackingConfiguration()
		config.planeDetection = .horizontal
		return config
	}()
	private var focalNode: SCNNode?
	private var screenCenter: CGPoint!
	private var modelNode: SCNNode!
	private var sceneAdded = false
	private var paused = false
	private var startingPanPosition: SCNVector3!
	private var startingWorldPosition: SCNVector3!
    private struct ScaleLimits {
        static let torusMaxPipeRadius: CGFloat = 10.0
        static let torusMinPipeRadius: CGFloat = 0.002
        static let torusScalingFactor: CGFloat = 1.0
        static let totalMaxScale: Float = 10000.0
        static let totalMinScale: Float = 0.0001
        static let planetMaxScale: Float = 3200.0
        static let planetMinScale: Float = 1.0
        static let planetScalingFactor: Float = 1.0
    }
	
	//MARK: Viewcontroller lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let fileName = fileName else {
			return
		}
		
		// Store screen center here so it can be accessed off of the main thread
		screenCenter = view.center
		
		// Set the view's delegate
		sceneView.delegate = self
		
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
	
	@IBAction func playPause(_ button: UIButton) {
		button.setImage(UIImage(named: paused ? "PauseIcon" : "PlayIcon"), for: .normal) 
		if !paused {
			//TODO: stop rotations
		} else {
			//TODO enable rotations
		}
		paused = !paused
	}
	
	@IBAction func close(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func tap(_ gesture: UITapGestureRecognizer) {
		if !sceneAdded {
			
			// Hide the label
			UIView.animate(withDuration: 0.5, animations: {
				self.searchingLabel.alpha = 0.0
				self.playPauseButton.alpha = 1.0
			}, completion: nil)
			
			// Make sure we've found the floor
			guard let focalNode = focalNode else { return }
			
			// See if we tapped on a plane where a model can be placed
			let results = sceneView.hitTest(screenCenter, types: .existingPlane)
			guard let transform = results.first?.worldTransform else { return }
			
			// Find the position to place the model
			let position = float3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
			
			// Create a copy of the model set its position/rotation
			let newNode = modelNode.childNodes[0]
			newNode.simdPosition = position
			
			// Add the model to the scene
			sceneView.scene.rootNode.addChildNode(newNode)
			for node in focalNode.childNodes {
				node.removeFromParentNode()
			}
			sceneAdded = true
			setupPlanetAnimations(node: sceneView.scene.rootNode)
        } else if gesture.state == UIGestureRecognizerState.recognized {
            
            let location: CGPoint = gesture.location(in:gesture.view)
            saveLocations(tapLocation: location)
            
        }
	}
	
	@IBAction func pan(_ gesture: UIPanGestureRecognizer) {
        guard let node = sceneView.scene.rootNode.childNode(withName: "starting point", recursively: true) else {
            return
        }
		// Find the location in the view
		let location = gesture.location(in: sceneView)
        guard let result = sceneView.hitTest(location, types: .existingPlane).first else { return }
        let transform = result.worldTransform
		
		switch gesture.state {
        case .began:
            startingPanPosition = SCNVector3.init(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            startingWorldPosition = node.worldPosition
		case .changed:
			// Move the node based on the real world translation
			
			let diffPanPosition = SCNVector3.init(transform.columns.3.x - startingPanPosition.x,
                                                 transform.columns.3.y - startingPanPosition.y,
                                                 transform.columns.3.z - startingPanPosition.z)
            
            node.worldPosition = startingWorldPosition! + diffPanPosition
//            node.simdPosition = newPanPosition
		default:
			// Do nothing
            print("done moving")
		}
	}
	
	@IBAction func pinch(_ gesture: UIPinchGestureRecognizer) {
        guard let node = sceneView.scene.rootNode.childNode(withName: "starting point", recursively: true) else {
            return
        }
        
//
//  I need to change the scale to 1 for the planets and make them their real size and then make the max and min of the scales.
//  I might have a small struct that keeps track of the min and max scales. For the planets the min will be 1 and the max would be about 3,200
//  I also need to change the torus pipe radius by the same gesture.scale as I am the starting point.
//
//  Zooming to the center of the screen not the starting point.
//
        
        SCNTransaction.animationDuration = 0.5
        
        let pinchScaleX = Float(gesture.scale) * node.scale.x
        let pinchScaleY =  Float(gesture.scale) * node.scale.y
        let pinchScaleZ =  Float(gesture.scale) * node.scale.z
        
        let scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
        if scale.x < ScaleLimits.totalMaxScale && scale.x > ScaleLimits.totalMinScale {
            node.scale = scale
        }
        
        for torus in sceneView.scene.rootNode.childNodes(passingTest: isTorus) {
            if let torusGeo = torus.geometry as? SCNTorus {
                let pipeRadius = 1.0 / gesture.scale * torusGeo.pipeRadius * ScaleLimits.torusScalingFactor
                
                if pipeRadius < ScaleLimits.torusMaxPipeRadius && pipeRadius > ScaleLimits.torusMinPipeRadius {
                    torusGeo.pipeRadius = pipeRadius
                }
            }
        }
        
        for planet in sceneView.scene.rootNode.childNodes(passingTest: isPlanet) {
            let pinchScaleX = Float(1 / gesture.scale) * planet.scale.x * ScaleLimits.planetScalingFactor
            let pinchScaleY =  Float(1 / gesture.scale) * planet.scale.y * ScaleLimits.planetScalingFactor
            let pinchScaleZ =  Float(1 / gesture.scale) * planet.scale.z * ScaleLimits.planetScalingFactor
            let scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
            if scale.x < ScaleLimits.planetMaxScale && scale.x > ScaleLimits.planetMinScale {
                planet.scale = scale
            }
        }
        
        gesture.scale=1
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
    
    func isPlanet(childNode: SCNNode, stop: UnsafeMutablePointer<ObjCBool>) -> Bool {
        
        if let nodeName = childNode.name, nodeName.contains("Planet"), nodeName != "SunPlanet" {
            return true
        }
        return false
    }
    
    func isTorus(childNode: SCNNode, stop: UnsafeMutablePointer<ObjCBool>) -> Bool {
        
        if let nodeName = childNode.name, nodeName.contains("Torus") {
            return true
        }
        return false
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
		let node = SCNNode()
		node.addChildNode(modelNode)
		
		// Add it to the root of our current scene
		sceneView.scene.rootNode.addChildNode(node)
		
		// Store the focal node
		self.focalNode = node
		
		self.sceneView.debugOptions = []
		// Change the label (making sure we're on the main thread)
		DispatchQueue.main.async {
			UIView.animate(withDuration: 1, animations: {
				self.searchingLabel.text = "Tap to place model"
			}, completion: nil)
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

