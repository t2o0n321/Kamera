//
//  frameHandler.swift
//  Kamera
//
//  Created by Lian Lin on 2024/3/4.
//
import AVFoundation

class frameHandler: ObservableObject{
    /*
        Variables
     */
    @Published var frame: CGImage?
    private var isPermissionGranted: Bool = false
    private var captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    init(){
        self.checkPermission()
        self.sessionQueue.async({
            [unowned self] in self.setupCaptureSession()
        })
    }
    
    /*
        Request for permission
     */
    private func requestPermission(){
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {
            [unowned self] granted in self.isPermissionGranted = granted
        })
    }
    
    /*
        Check Camera Permission
     */
    private func checkPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            self.isPermissionGranted = true
            break
        case .notDetermined:
            self.requestPermission()
            break
        default:
            self.isPermissionGranted = false
        }
    }
    
    func setupCaptureSession(){
        let videoOutput = AVCaptureVideoDataOutput()
        // Return if permission not granted
        guard self.isPermissionGranted else {return}
        guard let videoDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) else {return}
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {return}
    }
}
