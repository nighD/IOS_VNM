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


class SetTimeAlarmVC: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {
    
    var weekday: Weekdays!
    var repeatDay: [Int] = []
    var dateComponents = DateComponents()
    var index:Int?
    
    var alarm: Alarm?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var alarmLbl: UITextField!
    @IBOutlet weak var soundName: UILabel!

    @IBOutlet weak var alarmMethod: UILabel!

    
    @IBOutlet weak var repeatDaysLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alarmLbl.delegate = self
        //soundName.text = "None"
        if(indexOfCell == -1){
            soundName.text = "None"
        }
        else {
            soundName.text = soundList[indexOfCell]
        }
        // set minimum date/time for picker
        timePicker.minimumDate = NSDate() as Date
        timePicker.locale = NSLocale.current
        
//        if alarm != nil {
//            alarmLbl.text = alarm?.name
//            timePicker.date = alarm?.time as! Date
//        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func to check if label is empty
    func checkLabel() {
        let text = alarmLbl.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // func to check if date has passed
    func checkDate() {
        if NSDate().earlierDate(timePicker.date) == timePicker.date {
            saveButton.isEnabled = false
        }
    }
    
    // hide keyboard when hit enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkLabel()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        checkDate()
    }
    
    @IBAction func cancelBtn(_ sender: Any?) {
        self.navigationController?.popViewController(animated: true)
    //    dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let alarmName = alarmLbl.text
            var time = timePicker.date
            let timeInterval = floor(time.timeIntervalSinceReferenceDate/60) * 60
        
            time = NSDate(timeIntervalSinceReferenceDate: timeInterval) as Date
            // build notification
        
            // repeat
            for (element) in repeatDay.enumerated()
            {
               let num = repeatDay.count
               if (num == 0)
               {
                break
                }
               else {
                    dateComponents.weekday = element.element
                }
            }
        
            let notification = UILocalNotification()
            notification.alertTitle = "Alarm"
            notification.alertBody = "Ding Dong"
            notification.fireDate = time
            notification.hasAction = true
            notification.repeatInterval = NSCalendar.Unit.minute // Repeat every 1 mins
            notification.soundName = "Apologize.mp3.mp3"
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            UIApplication.shared.scheduledLocalNotifications?.append(notification)
        
        
            alarm = Alarm(time: time as NSDate, name: alarmName!, notification: notification)
        
        
    }
    
    
    @IBAction func repeatTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WeekdaysVC") as! WeekdaysVC
        vc.setTimeAlarmVC = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func drawRect(rect: CGRect) {
        var aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:100, y:100))
        
        aPath.addLine(to: CGPoint(x:100, y:100))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.red
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
    }
}















