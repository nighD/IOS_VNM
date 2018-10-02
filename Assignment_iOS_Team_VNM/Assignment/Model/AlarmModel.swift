//
//  AlarmModel.swift
//  Assignment
//
//  Created by Cooldown on 26/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import Foundation
import MediaPlayer

struct Alarm: Property {
    var date: Date = Date()
    var enabled: Bool = false
    var repeatWeekdays: [Int] = []
    var uuid: String = ""
    var mediaID: String = ""
    var mediaLabel: String = "bell"
    var label: String = "Alarm"
    var chooseMethod: [Int] = []
    
    init(){}
    
    init(date:Date, enabled:Bool, repeatWeekdays:[Int], uuid:String, mediaID:String, mediaLabel:String, label:String, chooseMethod: [Int]){
        self.date = date
        self.enabled = enabled
        self.repeatWeekdays = repeatWeekdays
        self.uuid = uuid
        self.mediaID = mediaID
        self.mediaLabel = mediaLabel
        self.label = label
        self.chooseMethod = chooseMethod
    }
    
    init(_ dict: Property.RepresentationType){
        date = dict["date"] as! Date
        enabled = dict["enabled"] as! Bool
        repeatWeekdays = dict["repeatWeekdays"] as! [Int]
        uuid = dict["uuid"] as! String
        mediaID = dict["mediaID"] as! String
        mediaLabel = dict["mediaLabel"] as! String
        label = dict["label"] as! String
        chooseMethod = dict["chooseMethod"] as! [Int]
    }
    
    static var propertyCount: Int = 8
}

extension Alarm {
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self.date)
    }
}

//This can be considered as a viewModel
class Alarms: Persistable {
    let ud: UserDefaults = UserDefaults.standard
    let persistKey: String = "myAlarmKey"
    var alarms: [Alarm] = [] {
        //observer, sync with UserDefaults
        didSet{
            persist()
        }
    }
    
    private func getAlarmsDictRepresentation()->[Property.RepresentationType] {
        return alarms.map {$0.propertyDictRepresentation}
    }
    
    init() {
        alarms = getAlarms()
    }
    
    func persist() {
        ud.set(getAlarmsDictRepresentation(), forKey: persistKey)
        ud.synchronize()
    }
    
    func unpersist() {
        for key in ud.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    

    
    var count: Int {
        return alarms.count
    }
    
    //helper, get all alarms from Userdefaults
    private func getAlarms() -> [Alarm] {
        let array = UserDefaults.standard.array(forKey: persistKey)
        guard let alarmArray = array else{
            return [Alarm]()
        }
        if let dicts = alarmArray as? [Property.RepresentationType]{
            if dicts.first?.count == Alarm.propertyCount {
                return dicts.map{Alarm($0)}
            }
        }
        unpersist()
        return [Alarm]()
    }
}
