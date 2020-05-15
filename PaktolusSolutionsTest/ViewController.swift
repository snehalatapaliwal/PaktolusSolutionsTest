//
//  ViewController.swift
//  PaktolusSolutionsTest
//
//  Created by apple on 14/05/20.
//  Copyright © 2020 snehalata. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    let delegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateCalories(sender: UIButton){
        let velocity = LocationManager.SharedManager.distance ?? 0.0 / Double(delegate.timeInterval)
        let calories = (0.035 * Double((weight.text! as NSString).doubleValue)) + ((Double((Int(velocity) ^ 2)) / Double((height.text! as NSString).doubleValue))) * (0.029) * (Double((weight.text! as NSString).doubleValue))
        print(calories)
        
    }

}


