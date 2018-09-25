//
//  Persistable.swift
//  Assignment
//
//  Created by Cooldown on 26/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import Foundation
protocol Persistable{
    var ud: UserDefaults {get}
    var persistKey : String {get}
    func persist()
    func unpersist()
}
