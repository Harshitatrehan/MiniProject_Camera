//
//  ViewController.swift
//  Camera
//
//  Created by Harshita Trehan on 4/6/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var captureSession = AVCaptureSession()

    @IBAction func capture(_ sender: Any) {
        //saving the camera button to the the button
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings , delegate: self as! AVCapturePhotoCaptureDelegate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCapture"{
            let previewVC = segue.destination as! CaptureViewController
            previewVC.image = self.image
        }
        
    }
    //back camera Variable
    var backCamera: AVCaptureDevice?
    //variable for storing Front Camera
    var frontCamera: AVCaptureDevice?
    var currentCamrera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
    }
    
    //configuring sessions
    func setupCaptureSession(){
        
        //specifies the image quality and resolution ; full resolution
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
    }
    
    func setupDevice(){
        //connect to a real time ios Camera
        let  deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        //finding out the camera devices ; checking positions of the cameras
        let devices = deviceDiscoverySession.devices
        //check whether the camera is front or rear view
        for device in devices{
            //if the position is back store in first variable
            if device.position == AVCaptureDevice.Position.back{
             //if the back camera is on
                backCamera = device
                
            }
            else if device.position == AVCaptureDevice.Position.front{
                // if  the front Camera is On
                frontCamera = device
            }
        }
        currentCamrera = backCamera
        
    }
    
    func setupInputOutput(){
        //catch error ; device input exists
        do{
            //capture data to the device
            let CaptureDeviceInput =  try AVCaptureDeviceInput(device: currentCamrera!)
            //add the captured data to the capture Session
            captureSession.addInput(CaptureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            //configure photoOutput telling to use a specific format
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        }
        catch{
            
            print(error)
            
        }
        
        
    }
    
    func setupPreviewLayer(){
        //indicates how the preview is displayed ; sets orientation
        //add the previews layers to the View Layers to unhide the buttton
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
        
    }
    
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
    }
}
    
extension ViewController: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
            if let imageData = photo.fileDataRepresentation(){
                image = UIImage(data: imageData)
                performSegue(withIdentifier: "showCapture", sender: nil)
                
                
            }
            
        }
    }
    
    

    



