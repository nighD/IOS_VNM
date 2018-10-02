//
//  AlarmVC.swift
//  Assignment
//
//  Created by Cooldown on 9/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit
import AVFoundation

class AlarmVC: UITableViewController {
    
   
    var soundDelegate: SoundDelegate = AppDelegate()
    var setAlarm: AlarmDelegate = AlarmSet()
    var myAlarm: Alarms = Alarms()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAlarm.checkNotification()
        tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myAlarm = Alarms()
        tableView.reloadData()
        //dynamically append the edit button
        if myAlarm.count != 0 {
            self.navigationItem.leftBarButtonItem = editButtonItem
        }
        else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if myAlarm.count == 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }
        else {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        }
        return myAlarm.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditing {
            performSegue(withIdentifier: Identifier.editSegueIdentifier, sender: GlobalVariable(enabled: myAlarm.alarms[indexPath.row].enabled, label: myAlarm.alarms[indexPath.row].label, repeatWeekdays: myAlarm.alarms[indexPath.row].repeatWeekdays, isEditMode: true, mediaLabel: myAlarm.alarms[indexPath.row].mediaLabel, chooseMethod: myAlarm.alarms[indexPath.row].chooseMethod, curCellIndex: indexPath.row, mediaID: myAlarm.alarms[indexPath.row].mediaID))
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Identifier.alarmCellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: Identifier.alarmCellIdentifier)
        }
        //cell text
        cell!.textLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        cell!.selectionStyle = .none
        cell!.tag = indexPath.row
        let alarm: Alarm = myAlarm.alarms[indexPath.row]
        let amAttr: [NSAttributedStringKey : Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.systemFont(ofSize: 20.0)]
        let str = NSMutableAttributedString(string: alarm.formattedTime, attributes: amAttr)
        let timeAttr: [NSAttributedStringKey : Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.systemFont(ofSize: 45.0)]
        str.addAttributes(timeAttr, range: NSMakeRange(0, str.length-2))
        cell!.textLabel?.attributedText = str
        cell!.detailTextLabel?.text = alarm.label
        //append switch button
        let sw = UISwitch(frame: CGRect())
        sw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9);
        
        //tag is used to indicate which row had been touched
        sw.tag = indexPath.row
        sw.addTarget(self, action: #selector(AlarmVC.switchTapped(_:)), for: UIControlEvents.valueChanged)
        if alarm.enabled {
            cell!.backgroundColor = UIColor.white
            cell!.textLabel?.alpha = 1.0
            cell!.detailTextLabel?.alpha = 1.0
            sw.setOn(true, animated: false)
        } else {
            cell!.backgroundColor = UIColor.groupTableViewBackground
            cell!.textLabel?.alpha = 0.5
            cell!.detailTextLabel?.alpha = 0.5
        }
        cell!.accessoryView = sw
        
        //delete empty seperator line
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return cell!
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        let index = sender.tag
        myAlarm.alarms[index].enabled = sender.isOn
        if sender.isOn {
            print("switch on")
            setAlarm.setNotificationWithDate(myAlarm.alarms[index].date, onWeekdaysForNotify: myAlarm.alarms[index].repeatWeekdays, soundName: myAlarm.alarms[index].mediaLabel, index: index, method: myAlarm.alarms[index].chooseMethod)
            tableView.reloadData()
        }
        else {
            print("switch off")
            setAlarm.reSchedule()
            tableView.reloadData()
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            myAlarm.alarms.remove(at: index)
            let cells = tableView.visibleCells
            for cell in cells {
                let sw = cell.accessoryView as! UISwitch
                //adjust saved index when row deleted
                if sw.tag > index {
                    sw.tag -= 1
                }
            }
            if myAlarm.count == 0 {
                self.navigationItem.leftBarButtonItem = nil
            }
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            setAlarm.reSchedule()
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! UINavigationController
        let addEditController = vc.topViewController as! SetTimeAlarmVC
        if segue.identifier == Identifier.addSegueIdentifier {
            addEditController.navigationItem.title = "Add Alarm"
            addEditController.globalVar = GlobalVariable(enabled: false, label: "Alarm", repeatWeekdays: [], isEditMode: false, mediaLabel: "bell", chooseMethod: [], curCellIndex: myAlarm.count, mediaID: "")
        }
        else if segue.identifier == Identifier.editSegueIdentifier {
            addEditController.navigationItem.title = "Edit Alarm"
            addEditController.globalVar = sender as! GlobalVariable
        }
    }
    
    @IBAction func unwindFromAddEditAlarmView(_ segue: UIStoryboardSegue) {
        isEditing = false
    }
    
    public func changeSwitchButtonState(index: Int) {
        //let info = notification.userInfo as! [String: AnyObject]
        //let index: Int = info["index"] as! Int
        myAlarm = Alarms()
        if myAlarm.alarms[index].repeatWeekdays.isEmpty {
            myAlarm.alarms[index].enabled = false
        }
        let cells = tableView.visibleCells
        for cell in cells {
            if cell.tag == index {
                let sw = cell.accessoryView as! UISwitch
                if myAlarm.alarms[index].repeatWeekdays.isEmpty {
                    sw.setOn(false, animated: false)
                    cell.backgroundColor = UIColor.groupTableViewBackground
                    cell.textLabel?.alpha = 0.5
                    cell.detailTextLabel?.alpha = 0.5
                }
            }
        }
    }
}

