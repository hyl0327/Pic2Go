//
//  ViewController.swift
//  Uploading
//
//  Created by 柯東爵 on 2018/6/3.
//  Copyright © 2018年 CSIE. All rights reserved.
//

import UIKit

enum MyError: Error {
    case message(String)
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Choose(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let image = imgView.image {
            let SpotTableScene = segue.destination as! SpotTableViewController
            SpotTableScene.img = image
        } else {
            self.addAlert(title: "No Image", message: "Please choose a image to upload!")
        }
    }
    func addAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.image = image
        } else{
            print("Something went wrong!")
        }
        dismiss(animated: true, completion: nil)
    }
}

