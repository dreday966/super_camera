//
//  ViewController.swift
//  super_camera
//
//  Created by 李经国 on 2016/10/11.
//  Copyright © 2016年 李经国. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: nil) 
        
        camera.layer.bounds = self.view.bounds
        
        self.scroll.layer.addSublayer(camera.layer)
        scroll.contentSize = CGSize(width: 1000, height: 1000)
        let frame = CGRect(x: 300, y: 300, width: self.view.frame.width, height: self.view.frame.height)
        let web = UIWebView(frame: frame)
        
        let req = URLRequest(url: URL(string: "http://www.baidu.com")!)
        web.loadRequest(req)
        
        self.scroll.addSubview(web)
    }
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBAction func la(_ sender: AnyObject) {
        
        
    }
    
    @IBAction func lp(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.ended{
            let con = camera.stillImageOutput!.connections[0] as! AVCaptureConnection
            camera.stillImageOutput?.captureStillImageAsynchronously(from: con, completionHandler: { (buffer, error) in
                
                let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)!
                let img = UIImage(data: data)
                UIImageWriteToSavedPhotosAlbum(img!,nil,nil,nil);
                
                let alert = UIAlertController(title: "yo", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "confirm", style: .cancel, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            })
        }
        
    }
  
    
    let camera = Camera()

}

