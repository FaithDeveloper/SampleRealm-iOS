//
//  personData.swift
//  SampleRealm
//
//  Created by MAC on 2018. 1. 18..
//  Copyright © 2018년 MAC. All rights reserved.
//

import Foundation
import RealmSwift

class PersonData: Object{
    @objc dynamic var userName = ""
    @objc dynamic var userAge = 0
    @objc dynamic var userEmail = ""
}
