//
//  SpotTableViewController.swift
//  Uploading
//
//  Created by 柯東爵 on 2018/6/3.
//  Copyright © 2018年 CSIE. All rights reserved.
//


import UIKit
import Alamofire

class SpotTableViewCell : UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Address: UILabel!
}

class SpotTableViewController: UITableViewController {
    var img: UIImage?
    var Spots: [SpotObj]!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        self.Spots = [SpotObj]()
        setLoadingScreen()
        reloadTableViewAfterNetworkCall()
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Spots.isEmpty ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Spots.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! SpotTableViewCell

        // Configure the cell...
        let Spot = Spots[indexPath.row]
        cell.Name?.text = Spot.Name
        cell.Address?.text = Spot.Address
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Spots"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SpotScene = segue.destination as! SpotViewController
        let indexpath = self.tableView.indexPathForSelectedRow
        SpotScene.Spot = Spots[indexpath!.row]
    }
    
    func reloadTableViewAfterNetworkCall() {
        Upload() {
            (Spots, error) in
            if let error = error {
                self.handleError(error: error)
                return
            }
            print("reload Success")
            self.Spots = Spots
            self.removeLoadingScreen()
            self.tableView.reloadData()
        }
    }
    
    func Upload(completion: @escaping ([SpotObj]?, Error?) -> Void) {
        if let image = img {
            let ImageData = UIImageJPEGRepresentation(image, 0.3)
            let url = "http://106.104.1.117:8787"
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 300
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = 300
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(ImageData!, withName: "pic",fileName: "file.jpg", mimeType: "image/jpeg")
            }, to:url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        if let arr = response.result.value as? NSArray{
                            //do your action base on Api Return failed/success
                            completion(SpotObj.loadSpotData(arr: arr), nil)
                        } else {
                            self.addAlert(title: "Request Fail", message: "Please upload again.")
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    completion(nil, encodingError)
                }
            }
        } else {
            self.addAlert(title: "No Image", message: "Please choose a image to upload!")
        }
    }
    
    func handleError(error: Error) {
        print(error)
    }
    
    func addAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 160
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 30, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableView.addSubview(loadingView)
        
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        loadingView.removeFromSuperview()
    }
}
