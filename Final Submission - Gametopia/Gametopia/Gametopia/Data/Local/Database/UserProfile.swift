//
//  UserProfile.swift
//  Gametopia
//
//  Created by Patricia Fiona on 22/09/22.
//

import Foundation
import RealmSwift

class UserProfile:Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var photo: Data = Data()
}
