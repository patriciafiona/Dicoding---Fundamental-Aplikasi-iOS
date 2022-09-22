//
//  Favorite.swift
//  Gametopia
//
//  Created by Patricia Fiona on 22/09/22.
//

import Foundation
import RealmSwift

class Favorites: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
}

