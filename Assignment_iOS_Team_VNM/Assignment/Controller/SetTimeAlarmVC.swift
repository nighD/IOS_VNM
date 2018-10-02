//
//  SetTimeAlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit
import Foundation
import MediaPlayer

class SetTimeAlarmVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var methodLabel: UILabel!
    
    var alarmSet: AlarmDelegate = AlarmSet()
    var alarmModel: Alarms = Alarms()
    var globalVar: GlobalVariable!
    var enabled: Bool!
    var chooseMethod: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alarmModel=Alarms()
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveEditAlarm(_ sender: AnyObject) {
        let date = AlarmSet.correctSecondComponent(date: datePicker.date)
        let index = globalVar.curCellIndex
        var tempAlarm = Alarm()
       
        if methodLabel.text == "Taking a Picture"{
            tempAlarm.chooseMethod.append(1)
        }
        else if methodLabel.text == "Playing TicTacToe"{
            tempAlarm.chooseMethod.append(2)
        }
        else if methodLabel.text == "Solving math problems"{
            tempAlarm.chooseMethod.append(3)
        }
        tempAlarm.date = date
        tempAlarm.label = globalVar.label
        tempAlarm.enabled = true
        tempAlarm.mediaLabel = globalVar.mediaLabel
        tempAlarm.mediaID = globalVar.mediaID
        tempAlarm.repeatWeekdays = globalVar.repeatWeekdays
        tempAlarm.uuid = UUID().uuidString
        if globalVar.isEditMode {
            alarmModel.alarms[index] = tempAlarm
        }
        else {
            alarmModel.alarms.append(tempAlarm)
        }
        self.performSegue(withIdentifier: Identifier.saveSegueIdentifier, sender: self)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        if globalVar.isEditMode {
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Identifier.settingIdentifier)
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: Identifier.settingIdentifier)
        }
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                cell!.textLabel!.text = "Repeat"
                cell!.detailTextLabel!.text = WeekdaysVC.repeatText(weekdays: globalVar.repeatWeekdays)
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            else if indexPath.row == 1 {
                cell!.textLabel!.text = "Label"
                cell!.detailTextLabel!.text = globalVar.label
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            else if indexPath.row == 2 {
                cell!.textLabel!.text = "Sound"
                cell!.detailTextLabel!.text = globalVar.mediaLabel
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
//            else if indexPath.row == 3 {
//                cell!.textLabel!.text = "Choose Alarm Method"
//                cell!.detailTextLabel!.text = SetMethodAlarmVC.chooseMethod(position: segueInfo.chooseMethod)
//                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//            }
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if indexPath.section == 0 {
            switch indexPath.row{
            case 0:
                performSegue(withIdentifier: Identifier.weekdaysSegueIdentifier, sender: self)
                cell?.setSelected(true, animated: false)
                cell?.setSelected(false, animated: false)
            case 1:
                performSegue(withIdentifier: Identifier.labelSegueIdentifier, sender: self)
                cell?.setSelected(true, animated: false)
                cell?.setSelected(false, animated: false)
            case 2:
                performSegue(withIdentifier: Identifier.soundSegueIdentifier, sender: self)
                cell?.setSelected(true, animated: false)
                cell?.setSelected(false, animated: false)
//            case 3:
//                performSegue(withIdentifier: Id.alarmMethodIdentifier, sender: self)
//                cell?.setSelected(true, animated: false)
//                cell?.setSelected(false, animated: false)
            default:
                break
            }
        }
        else if indexPath.section == 1 {
            //delete alarm
            alarmModel.alarms.remove(at: globalVar.curCellIndex)
            performSegue(withIdentifier: Identifier.saveSegueIdentifier, sender: self)
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == Identifier.saveSegueIdentifier {
            let dist = segue.destination as! AlarmVC
            let cells = dist.tableView.visibleCells
            for cell in cells {
                let sw = cell.accessoryView as! UISwitch
                if sw.tag > globalVar.curCellIndex
                {
                    sw.tag -= 1
                }
            }
            alarmSet.reSchedule()
        }
        else if segue.identifier == Identifier.soundSegueIdentifier {
            let vc = segue.destination as! SoundBrowsingVC
            vc.mediaID = globalVar.mediaID
            vc.mediaLabel = globalVar.mediaLabel
        }
        else if segue.identifier == Identifier.labelSegueIdentifier {
            let vc = segue.destination as! AlarmNameVC
            vc.label = globalVar.label
        }
        else if segue.identifier == Identifier.weekdaysSegueIdentifier {
            let vc = segue.destination as! WeekdaysVC
            vc.weekdays = globalVar.repeatWeekdays
        }
//        else if segue.identifier == Id.alarmMethodIdentifier {
//            let dist = segue.destination as! SetMethodAlarmVC
////            dist.setTimeAlarmVC = self
//            dist.position = segueInfo.chooseMethod
//        }
    }
    
    @IBAction func unwindFromLabelEditView(_ segue: UIStoryboardSegue) {
        let src = segue.source as! AlarmNameVC
        globalVar.label = src.label
    }
    
    @IBAction func unwindFromWeekdaysView(_ segue: UIStoryboardSegue) {
        let src = segue.source as! WeekdaysVC
        globalVar.repeatWeekdays = src.weekdays
    }
    
    @IBAction func unwindFromMediaView(_ segue: UIStoryboardSegue) {
        let src = segue.source as! SoundBrowsingVC
        globalVar.mediaLabel = src.mediaLabel
        globalVar.mediaID = src.mediaID
    }
    
//    @IBAction func unwindFromMethod(_ segue: UIStoryboardSegue) {
//        let src = segue.source as! SetMethodAlarmVC
//        segueInfo.chooseMethod = src.position
//    }
    
    @IBAction func chooseMethod(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "chooseMethodVC") as! SetMethodAlarmVC
        vc.setTimeAlarmVC = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}















