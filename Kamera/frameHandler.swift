//
//  frameHandler.swift
//  Kamera
//
//  Created by Lian Lin on 2024/3/4.
//
import AVFoundation
import CoreImage

class frameHandler: NSObject, ObservableObject{
    /*
        Variables
     */
    @Published var frame: CGImage?
    private var isPermissionGranted: Bool = false
    private var captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()
    
    override init(){
        super.init()
        self.checkPermission()
        self.sessionQueue.async { [unowned self] in
            self.setupCaptureSession()
            self.captureSession.startRunning()
        }
    }
    
    /*
        Request for permission
     */
    func requestPermission(){
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {
            [unowned self] granted in self.isPermissionGranted = granted
        })
    }
    
    /*
        Check Camera Permission
     */
    func checkPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            self.isPermissionGranted = true
        case .notDetermined:
            self.requestPermission()
        default:
            self.isPermissionGranted = false
        }
    }
    
    func setupCaptureSession(){
        let videoOutput = AVCaptureVideoDataOutput()
        // Return if permission not granted
        guard self.isPermissionGranted else {return}
        guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else {return}
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {return}
        guard captureSession.canAddInput(videoDeviceInput) else {return}
        captureSession.addInput(videoDeviceInput)
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
    }
}

extension frameHandler: AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImg = self.imageFromSampleBuffer(sampleBuffer: sampleBuffer) else {return}
        
        DispatchQueue.main.async {
            [unowned self] in
                self.frame = cgImg
        }
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return nil}
        let ciImg = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImg = self.context.createCGImage(ciImg, from: ciImg.extent) else {return nil}
        return cgImg
    }
}
