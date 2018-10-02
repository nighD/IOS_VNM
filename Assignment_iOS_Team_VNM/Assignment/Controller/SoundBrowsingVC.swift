
//
//  SoundBrowsingVC.swift
//  Assignment
//
//  Created by Vinh Ngo on 10/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//
import UIKit
import MediaPlayer

class SoundBrowsingVC: UITableViewController, MPMediaPickerControllerDelegate  {
    
    fileprivate let numberOfRingtones = 100
    var mediaItem: MPMediaItem?
    var mediaLabel: String!
    var mediaID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Identifier.soundUnwindIdentifier, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor =  UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 100
        }
        else {
            return numberOfRingtones
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
        return "MUSIC"
    }
    else {
        return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Identifier.musicIdentifier)
        if(cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.default, reuseIdentifier: Identifier.musicIdentifier)
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell!.textLabel!.text = "bell"
            }
            else if indexPath.row == 1 {
                cell!.textLabel!.text = "Thinking out loud"
            }
            else if indexPath.row == 2 {
                cell!.textLabel!.text = "Apologize"
            }
            
            if cell!.textLabel!.text == mediaLabel {
                cell!.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
        
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            mediaLabel = cell?.textLabel?.text!
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: true)
            let cells = tableView.visibleCells
            for c in cells {
                let section = tableView.indexPath(for: c)?.section
                if (section == indexPath.section && c != cell) {
                    c.accessoryType = UITableViewCellAccessoryType.none
                }
            }
        }
    }
}
