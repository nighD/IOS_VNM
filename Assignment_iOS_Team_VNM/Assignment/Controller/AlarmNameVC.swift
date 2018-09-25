//
//  AlarmNameVC.swift
//  Assignment
//
//  Created by Cooldown on 25/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class AlarmNameVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var label: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
        self.textField.delegate = self
        
        textField.text = label
        
        textField.returnKeyType = UIReturnKeyType.done
        textField.enablesReturnKeyAutomatically = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        label = textField.text!
        performSegue(withIdentifier: "nameUnwindSegue", sender: self)
        //This method can be used when no state passing is needed
        //navigationController?.popViewController(animated: true)
        return false
    }
    

}
