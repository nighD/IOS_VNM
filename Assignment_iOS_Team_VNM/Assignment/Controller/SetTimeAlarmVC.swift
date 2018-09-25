//
//  SetTimeAlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit

import AVFoundation

import UserNotifications


class SetTimeAlarmVC: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var weekday: Weekdays!
    var repeatDay: [Int] = []
    var dateComponents = DateComponents()
    var index:Int?
    var segueInfo: SegueInfo!
    
    var alarm: Alarm?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var alarmLbl: UITextField!
    @IBOutlet weak var soundName: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var alarmMethod: UILabel!

    
    @IBOutlet weak var repeatDaysLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.alarmLbl.delegate = self
//        //soundName.text = "None"
//        if(indexOfCell == -1){
//            soundName.text = "None"
//        }
//        else {
//            soundName.text = soundList[indexOfCell]
//        }
        // set minimum date/time for picker
        timePicker.minimumDate = NSDate() as Date
        timePicker.locale = NSLocale.current
        
        
//        if alarm != nil {
//            alarmLbl.text = alarm?.name
//            timePicker.date = alarm?.time as! Date
//        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        }
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                cell!.textLabel!.text = "Alarm Name"
             //   cell!.detailTextLabel!.text = "None"
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            
            if indexPath.row == 1 {
                cell!.textLabel!.text = "Repeat"
              //  cell!.detailTextLabel!.text = WeekdaysVC.repeatText(storedDay: repeatDay)
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            
            if indexPath.row == 2 {
                cell!.textLabel!.text = "Sound"
             //   cell!.detailTextLabel!.text = segueInfo.mediaLabel
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            
            if indexPath.row == 3 {
                cell!.textLabel!.text = "Choose alarm method"
             //   cell!.detailTextLabel!.text = segueInfo.method
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "editNameSegue", sender: self)
                cell?.setSelected(true, animated: false)
                cell?.setSelected(false, animated: false)
            case 1:
                performSegue(withIdentifier: "weekdaysSegue", sender: self)
                cell?.setSelected(true, animated: false)
                cell?.setSelected(false, animated: false)
            case 2:
                performSegue(withIdentifier: "soundsSegue", sender: self)
                cell?.setSelected(true, animated: false)
                cell?.setSelected(false, animated: false)
            case 3:
                performSegue(withIdentifier: "methodSegue", sender: self)
                cell?.setSelected(true, animated: false)
                cell?.setSelected(false, animated: false)
            default:
                break
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "editNameSegue" {
//            let dist = segue.destination as! AlarmNameVC
//            dist.label = segueInfo.label
//        }
//        else if segue.identifier == "weekdaysSegue" {
//            let dist = segue.destination as! WeekdaysVC
//            dist.storedDay = segueInfo.repeatWeekdays
//        }
//    }
//
//    @IBAction func unwindFromAlarmNameVC(_ segue: UIStoryboardSegue) {
//        let src = segue.source as! AlarmNameVC
//        segueInfo.label = src.label
//    }
//
//    @IBAction func unwindFromWeekdaysVC(_ segue: UIStoryboardSegue) {
//        let src = segue.source as! WeekdaysVC
//        segueInfo.repeatWeekdays = src.storedDay
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Id.saveSegueIdentifier {
//            let dist = segue.destination as! AlarmVC
//            let cells = dist.tableView.visibleCells
//            for cell in cells {
//                let sw = cell.accessoryType as! UISwitch
//                if sw.tag > segueInfo.curCellIndex
//                {
//                    sw.tag -= 1
//                }
//            }
//        }
//
//        else if segue.identifier == Id.labelSegueIdentifier {
//            let dist = segue.destination as! AlarmNameVC
//            dist.label = segueInfo.label
//        }
//
//        else if segue.identifier == Id.weekdaysSegueIdentifier {
//            let dist = segue.destination as! WeekdaysVC
//            dist.storedDay = segueInfo.repeatWeekdays
//        }
//
//        else if segue.identifier == Id.soundIdentifier {
//            let dist = segue.destination as! SoundBrowsingVC
//
//        }
//    }
//
//    @IBAction func unwindFromLabelEditView(_ segue: UIStoryboardSegue) {
//        let src = segue.source as! AlarmNameVC
//        segueInfo.label = src.label
//    }
//
//    @IBAction func unwindFromWeekdaysView(_ segue: UIStoryboardSegue) {
//        let src = segue.source as! WeekdaysVC
//        segueInfo.repeatWeekdays = src.storedDay
//    }
    
//    @IBAction func unwindFromMediaView(_ segue: UIStoryboardSegue) {
//        let src = segue.source as! MediaViewController
//        segueInfo.mediaLabel = src.mediaLabel
//        segueInfo.mediaID = src.mediaID
//    }
    
//    // func to check if label is empty
//    func checkLabel() {
//        let text = alarmLbl.text ?? ""
//        saveButton.isEnabled = !text.isEmpty
//    }
//
//    // func to check if date has passed
//    func checkDate() {
//        if NSDate().earlierDate(timePicker.date) == timePicker.date {
//            saveButton.isEnabled = false
//        }
//    }
//
//    // hide keyboard when hit enter
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        checkLabel()
//        navigationItem.title = textField.text
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        saveButton.isEnabled = false
//    }
//
//    func timeChanged(_ sender: UIDatePicker) {
//        checkDate()
//    }
//
    @IBAction func cancelBtn(_ sender: Any?) {
        self.navigationController?.popViewController(animated: true)
    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            let alarmName = alarmLbl.text
//            var time = timePicker.date
//            let timeInterval = floor(time.timeIntervalSinceReferenceDate/60) * 60
//
//            time = NSDate(timeIntervalSinceReferenceDate: timeInterval) as Date
//            // build notification
//
//            // repeat
//            for (element) in repeatDay.enumerated()
//            {
//               let num = repeatDay.count
//               if (num == 0)
//               {
//                break
//                }
//               else {
//                    dateComponents.weekday = element.element
//                }
//            }
//
//            let notification = UILocalNotification()
//            notification.alertTitle = "Alarm"
//            notification.alertBody = "Ding Dong"
//            notification.fireDate = time
//            notification.hasAction = true
//            notification.repeatInterval = NSCalendar.Unit.minute // Repeat every 1 mins
//            notification.soundName = "Apologize.mp3.mp3"
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//            UIApplication.shared.scheduledLocalNotifications?.append(notification)
//
//
//            alarm = Alarm(time: time as NSDate, name: alarmName!, notification: notification)
//
//
//    }
//
//
//    @IBAction func repeatTapped(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "WeekdaysVC") as! WeekdaysVC
//        vc.setTimeAlarmVC = self
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
}















