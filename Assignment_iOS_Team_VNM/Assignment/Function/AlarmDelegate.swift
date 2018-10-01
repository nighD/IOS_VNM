//
//  AlarmDelegate.swift
//  Assignment
//
//  Created by Cooldown on 26/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import Foundation
import UIKit

protocol AlarmDelegate {
    func setNotificationWithDate(_ date: Date, onWeekdaysForNotify:[Int], soundName: String, index: Int,method: [Int])
    func setupNotificationSettings() -> UIUserNotificationSettings
    func reSchedule()
    func checkNotification()
}
