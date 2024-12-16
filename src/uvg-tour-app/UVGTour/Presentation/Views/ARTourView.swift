//
//  ARTourView.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/29/24.
//

import SwiftUI
import UIKit
import ARKit
import RealityKit
import Combine

struct ARTourView: UIViewRepresentable {
    @Binding var angle: Float
    @Binding var showArrow: Bool
    
    let framePublisher = PassthroughSubject<Void, Never>()
    
    init(angle: Binding<Float>, showArrow: Binding<Bool>) {
        self._angle = angle
        self._showArrow = showArrow
    }
    
    
    // MARK: Lifecycle methods
    
    
    func makeUIView(context: Context) -> some UIView {
        return createSceneExperience(in: context)
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        let newScale = arrowScale()
//        let rotation = context.coordinator.worldAnchor.transform.rotation
//        let translation = context.coordinator.worldAnchor.transform.translation
//        context.coordinator.worldAnchor.move(
//            to: Transform(
//                scale: newScale
//            ),
//            relativeTo: context.coordinator.cameraAnchor,
//            duration: 0.2,
//            timingFunction: .easeInOut
//        )
    }
    
    func arrowScale() -> SIMD3<Float> {
        if showArrow {
            return SIMD3<Float>(0.4,0.4,0.4)
        } else {
            return SIMD3<Float>(0.001,0.001,0.001)
        }
    }
    
    
    // MARK: AR Tour
    
    
    /// Creates the AR experience using ``SCNView``.
    func createSceneExperience(in context: Context) -> some UIView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.environmentTexturing = .automatic
        
        // Create an AR session with the configuration
        arView.session.run(config)
        
        // Create a test cube
        //        let boxMesh = MeshResource.generateBox(size: 0.1) // 10 cm cube
        let boxMaterial = UnlitMaterial(color: .uvgGreen) // Use unlit material for consistent color
        //        let boxEntity = ModelEntity(mesh: boxMesh, materials: [boxMaterial])
        let arrowEntity = try! ModelEntity.loadModel(named: "arrow.usdz")
        arrowEntity.model?.materials = [boxMaterial]
        // Rotate the arrow 90 degrees around the Z-axis
        let zRotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 1]) // 90 degrees on Z-axis
        let xRotation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0]) // 45 degrees on X-axis
        let orientationRotation = simd_quatf(angle: -.pi / 4, axis: [0, 0, 1]) // Lower de arrow
        // Combine the rotations
        
        
        // Create an anchor entity to attach to the camera
        let cameraAnchor = AnchorEntity(.camera)
        
        
        // Add the anchor to the AR scene
        let worldAnchor = AnchorEntity(world: [0, 0, 0])
        worldAnchor.addChild(arrowEntity)
        arView.scene.anchors.append(worldAnchor)
        arView.scene.anchors.append(cameraAnchor)
        
        // Rotate and transform
        let combinedRotations = zRotation * xRotation * orientationRotation
        let targetPosition = SIMD3<Float>(0, -0.10, -2)
        let scale = arrowScale()
        worldAnchor.position = targetPosition
        worldAnchor.scale = scale
        worldAnchor.orientation = combinedRotations
        
        context.coordinator.worldAnchor = worldAnchor
        context.coordinator.cameraAnchor = cameraAnchor
        
        
        // Continuously update the position of the cube to always be in front of the camera
        framePublisher
            .throttle(for: .milliseconds(200), scheduler: DispatchQueue.main, latest: true)
            .sink { _ in
                // Define the target position and rotation
                let scale = arrowScale()
                // Animate the position and orientation change
                worldAnchor.move(
                    to: Transform(
                        scale: scale,
                        rotation: combinedRotations * simd_quatf(angle: angle, axis: [0, 1, 0]),
                        translation: targetPosition
                    ),
                    relativeTo: cameraAnchor,
                    duration: 0.2,
                    timingFunction: .easeInOut
                )
            }
            .store(in: &context.coordinator.cancellables)
        
        // Trigger the frame updates
        arView.scene.subscribe(to: SceneEvents.Update.self) { _ in
            framePublisher.send()
        }.store(in: &context.coordinator.cancellables)
        
        return arView
    }
    
    
    
    class Coordinator: NSObject {
        var cameraAnchor: AnchorEntity! = nil
        var worldAnchor: AnchorEntity! = nil
        var cancellables = Set<AnyCancellable>()
    }
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    
}
