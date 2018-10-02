//
//  AlarmNameVC.swift
//  Assignment
//
//  Created by Cooldown on 25/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class AlarmNameVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var labelTextField: UITextField!
    var label: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
        self.labelTextField.delegate = self
        
        labelTextField.text = label
        
        //defined in UITextInputTraits protocol
        labelTextField.returnKeyType = UIReturnKeyType.done
        labelTextField.enablesReturnKeyAutomatically = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        label = textField.text!
        performSegue(withIdentifier: Identifier.labelUnwindIdentifier, sender: self)
        //This method can be used when no state passing is needed
        //navigationController?.popViewController(animated: true)
        return false
    }
    
}
