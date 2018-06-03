//
//  CaptureViewController.swift
//  Camera
//
//  Created by Harshita Trehan on 4/6/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController {
    
    var image: UIImage!

    @IBOutlet weak var photo: UIImageView!
    
    //save photo to the album
    @IBAction func save(_ sender: Any) {
        //load the first image to the photo album
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //dismiss the view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        //dismiss the capture View Controller
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
