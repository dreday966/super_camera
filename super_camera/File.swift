//
//  File.swift
//  super_camera
//
//  Created by 李经国 on 2016/10/11.
//  Copyright © 2016年 李经国. All rights reserved.
//

import UIKit
import AVFoundation

class Camera: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var stillImageOutput: AVCaptureStillImageOutput?{
        
        
        for out in session.outputs{
            if let o = out as? AVCaptureStillImageOutput{
                return o
            }
        }
        return nil
    }
    
    var stillImageConnection: AVCaptureConnection?{
        for out in session.outputs{
            if let o = out as? AVCaptureStillImageOutput,let con = o.connections.first as? AVCaptureConnection{
                return con
            }
        }
        return nil
    }
    
    private lazy var backCameraInput: AVCaptureDeviceInput? = {
        let devices = AVCaptureDevice.devices() as! [AVCaptureDevice]
        
        for device in devices{
            if device.position == .back{
                return try? AVCaptureDeviceInput(device: device)
            }
        }
        return nil
    }()
    
    private lazy var frontCameraInput: AVCaptureDeviceInput? = {
        let devices = AVCaptureDevice.devices() as! [AVCaptureDevice]
        
        for device in devices{
            if device.position == .front{
                return try? AVCaptureDeviceInput(device: device)
            }
        }
        return nil
    }()

    
//    func captureImage() -> Promise<UIImage>{
//        return Promise{ful,rej in
//            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(stillImageConnection, completionHandler: { (buffer, error) -> Void in
//                if error == nil {
//                    
//                    ful(self.bufferToCIImage(buffer))
//                }else{
//                    rej(error)
//                }
//            })
//        }
//    }
    
    enum InputCamera {
        case Front,Back,NoInput
    }
    
    override init() {
        
        session = AVCaptureSession()
        
        layer = AVCaptureVideoPreviewLayer(session: session)
        super.init()
        
        session.sessionPreset = AVCaptureSessionPreset640x480
        
        let back = backCameraInput!
        session.addInput(back)
        
        let stillImageOutput = AVCaptureStillImageOutput()
        let outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        stillImageOutput.outputSettings = outputSettings
        
        if session.canAddOutput(stillImageOutput){
            session.addOutput(stillImageOutput)
        }
        stillImageConnection?.videoOrientation = .portrait
        
        session.startRunning()
    }
    
    let session: AVCaptureSession
    
    let layer: AVCaptureVideoPreviewLayer
    
    
//    private func bufferToCIImage(sampleBuffer: CMSampleBuffer) -> UIImage {
//        
//        
//        let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
//        return UIImage(data: data)!
//    }
}
