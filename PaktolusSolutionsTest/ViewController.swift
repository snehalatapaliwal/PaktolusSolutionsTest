//
//  ViewController.swift
//  PaktolusSolutionsTest
//
//  Created by apple on 14/05/20.
//  Copyright © 2020 snehalata. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    var calories = 0.0
    let delegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateCalories(sender: UIButton){
        let velocity = LocationManager.SharedManager.distance ?? 0.0 / Double(delegate.timeInterval)
         calories = (0.035 * Double((weight.text! as NSString).doubleValue)) + ((Double((Int(velocity) ^ 2)) / Double((height.text! as NSString).doubleValue))) * (0.029) * (Double((weight.text! as NSString).doubleValue))
        saveDataOnLocalDB()
    }
    
    func saveDataOnLocalDB() {
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let managedContext =
        appDelegate.persistentContainer.viewContext
      let entity =
        NSEntityDescription.entity(forEntityName: "UserInfo",
                                   in: managedContext)!
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        person.setValue(name.text, forKeyPath: "userName")
        person.setValue(age.text, forKeyPath: "userAge")
        person.setValue(height.text, forKeyPath: "userHeight")
        person.setValue(weight.text, forKeyPath: "userWeight")
        person.setValue(calories, forKeyPath: "caloriesData")

      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }

}


