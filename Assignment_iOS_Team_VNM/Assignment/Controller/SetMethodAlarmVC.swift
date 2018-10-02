//
//  SetMethodAlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

class SetMethodAlarmVC: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var tableView : UITableView!
    var setTimeAlarmVC: SetTimeAlarmVC!
    var method: [UIImage] = [UIImage(named: "camera")!,UIImage(named:"tictactoe-1")!,UIImage(named:"math")!]
    var picArray:[String] = ["camera","tictactoe-1","math"]
    var color: [UIColor] = [UIColor .orange,UIColor .blue,UIColor .green]
    var position: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "tableViewMethod"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Id.methodUnwindIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return method.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! tableViewCellTableViewCell
        cell.backgroundColor = color[indexPath.item]
        //cell.label.text = ""
        cell.image0.image = method[indexPath.item]
        //cell.label.backgroundColor = UIColor(patternImage: resizeImage(image: method[indexPath.item],newWidth: CGFloat(163)))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
        if cell.isSelected {
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "alarmpicSegue", sender: self)
                position.removeAll()
                position.append(indexPath.row + 1)
               // cell.accessoryType
            }
            else {
                //cell.accessoryType = .checkmark
                position.append(indexPath.row + 1)
                if position.count >= 1 {
                    position.removeAll()
                    position.append(indexPath.row + 1)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            if let index = position.index(of: indexPath.row)
            {
            position.remove(at: index + 1)
            }
        }
    }
    
    
    
//        let position1 = position[indexPath.item]
//        if position1 == 0 {
//            //setTimeAlarmVC.alarmMethod.text = "Compare Picture"
//            self.performSegue(withIdentifier: "alarmPIC", sender: self)
//        }
//        else if position1 == 1 {
//           //setTimeAlarmVC.alarmMethod.text = "Tic Tac Toe"
//           //self.navigationController?.popViewController(animated: true)
//           //performSegue(withIdentifier: "saveDone", sender: self)
//           self.performSegue(withIdentifier: "tictactoeVC", sender: self)
//           //self.dismiss(animated: true, completion: nil)
//        }
//        else {
//            //setTimeAlarmVC.alarmMethod.text = "Math"
//            self.performSegue(withIdentifier: "mathVC", sender: self)
//           //self.dismiss(animated: true, completion: nil)
//        }
       // tableView.deselectRow(at: indexPath, animated: true)
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
//        let scale = (newWidth / image.size.width) - 5
//        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth,height: newWidth - 10))
        image.draw(in :CGRect(x: 0,y: 0,width: newWidth,height: newWidth - 10))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
//    @IBAction func Back(_ sender: UIBarButtonItem) {
//         self.dismiss(animated: true, completion: nil)
//        
//    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        setTimeAlarmVC.methodLabel.text = SetMethodAlarmVC.chooseMethod(position: position)
        setTimeAlarmVC.chooseMethod = position
        self.navigationController?.popViewController(animated: true)
    }
}

extension SetMethodAlarmVC {
    static func chooseMethod(position: [Int]) -> String {
        if position.isEmpty {
            return "None"
        }
        
        var ret = String()
        var sortedMethod:[Int] = [Int]()
        
        sortedMethod = position.sorted(by: <)
        
        for method in sortedMethod {
            switch method {
            case 1:
                ret += "Taking a picture"
            case 2:
                ret += "Playing TicTacToe"
            case 3:
                ret += "Solving math problems"
            default:
                break
            }
        }
        return ret
    }
}
//extension SetMethodAlarmVC: CellDelegate {
//    func changeController(title: String) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "main", bundle:nil)
//        if title == "alarmpic"{
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "alarmpic") as! AlarmPIC
//            self.present(nextViewController, animated:true, completion:nil)
//        }
//        else if title == "mathvc"{
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mathvc") as! MathVC
//            self.present(nextViewController, animated:true, completion:nil)
//        }
//
//    }
//
//}
