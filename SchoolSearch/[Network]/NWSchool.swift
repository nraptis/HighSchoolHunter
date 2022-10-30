//
//  School.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/27/22.
//

import Foundation

struct NWSchool: Decodable {
    let dbn: String
    let school_name: String?
    
    let primary_address_line_1: String?
    let city: String?
    let zip: String?
    let state_code: String?
}

/*
extension School: Identifiable {
    var id: String {
        dbn
    }
}

extension School: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(dbn)
    }
}
*/
