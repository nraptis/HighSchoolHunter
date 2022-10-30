//
//  UISchool.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/29/22.
//

import Foundation

struct UISchool {
    let dbn: String
    let school_name: String?
    let primary_address_line_1: String?
    let city: String?
    let zip: String?
    let state_code: String?
    let school_name_char_array: [Character]
    let school_name_char_array_lowercased: [Character]
    
    init(dbn: String,
         school_name: String?,
         primary_address_line_1: String?,
         city: String?,
         zip: String?,
         state_code: String?) {
        self.dbn = dbn
        self.school_name = school_name
        self.primary_address_line_1 = primary_address_line_1
        self.city = city
        self.zip = zip
        self.state_code = state_code
        if let school_name = school_name {
            self.school_name_char_array = Array(school_name)
            self.school_name_char_array_lowercased = Array(school_name.lowercased())
        } else {
            self.school_name_char_array = [Character]()
            self.school_name_char_array_lowercased = [Character]()
        }
    }
    
    init(dbSchool: DBSchool) {
        self.init(dbn: dbSchool.dbn ?? "",
                  school_name: dbSchool.school_name,
                  primary_address_line_1: dbSchool.primary_address_line_1,
                  city: dbSchool.city,
                  zip: dbSchool.zip,
                  state_code: dbSchool.state_code)
    }
}

extension UISchool: Identifiable {
    var id: String {
        dbn
    }
}

extension UISchool: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
