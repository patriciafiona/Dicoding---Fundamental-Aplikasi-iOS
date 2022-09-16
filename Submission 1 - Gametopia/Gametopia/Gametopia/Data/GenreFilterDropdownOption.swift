//
//  GenreFilterDropdownOption.swift
//  Gametopia
//
//  Created by Patricia Fiona on 16/09/22.
//

import Foundation

struct GenreFilterDropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: GenreFilterDropdownOption, rhs: GenreFilterDropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}
