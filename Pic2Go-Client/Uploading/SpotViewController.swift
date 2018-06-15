//
//  SpotViewController.swift
//  Uploading
//
//  Created by 柯東爵 on 2018/6/3.
//  Copyright © 2018年 CSIE. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireImage

class SpotViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var AddressTitle: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var DescriptionTitle: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var OpeningHoursTitle: UILabel!
    @IBOutlet weak var OpeningHoursLabel: UILabel!
    @IBOutlet weak var TravellingInformationTitle: UILabel!
    @IBOutlet weak var TravellingInformationLabel: UILabel!
    
    @IBOutlet weak var SpotImage: UIImageView!
    
    var Spot : SpotObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Spot?.Name
        NameLabel?.text = Spot?.Name
        if(Spot?.Address != "") {
            AddressLabel?.text = Spot?.Address
        } else {
            AddressLabel.isHidden = true
            AddressTitle.isHidden = true
        }
        if(Spot?.Description != "") {
            DescriptionLabel?.text = Spot?.Description
        } else {
            DescriptionLabel.isHidden = true
            DescriptionTitle.isHidden = true
        }
        
        if(Spot?.OpeningHours != "") {
            OpeningHoursLabel?.text = Spot?.OpeningHours
        } else {
            OpeningHoursLabel.isHidden = true
            OpeningHoursTitle.isHidden = true
        }
        
        if(Spot?.TravellingInformation != "") {
            TravellingInformationLabel?.text = Spot?.TravellingInformation
        } else {
            TravellingInformationLabel.isHidden = true
            TravellingInformationTitle.isHidden = true
        }
        
        Alamofire.request((Spot?.ImageURL)!, method: .get).responseImage { response in
            guard let image = response.result.value else {
                // Handle error
                print("Image URL Error!")
                return
            }
            // Do stuff with your image
            self.SpotImage?.image = image
        }
        //SpotImage?.image = UIImage(named: (Spot?.IATA)!)
        
        // Do any additional setup after loading the view.
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
