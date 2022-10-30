//
//  UISchool+Preview.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/29/22.
//

import Foundation

extension UISchool {
    static func preview() -> UISchool {
        UISchool(dbn: "21K728",
                 school_name: "Liberation Diploma Plus High School",
                 primary_address_line_1: "2865 West 19th Street",
                 city: "Brooklyn",
                 zip: "11224",
                 state_code: "NY")
    }
}
