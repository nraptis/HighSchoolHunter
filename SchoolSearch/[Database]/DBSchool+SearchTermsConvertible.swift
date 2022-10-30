//
//  DBSchool+Tokenizable.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/30/22.
//

import Foundation

extension DBSchool: SearchTermsConvertible {
    
    func searchTerms() -> [String] {
        var result = [String]()
        if let search_term_00 = self.search_term_00, search_term_00.count > 0 { result.append(search_term_00.lowercased()) }
        if let search_term_01 = self.search_term_01, search_term_01.count > 0 { result.append(search_term_01.lowercased()) }
        if let search_term_02 = self.search_term_02, search_term_02.count > 0 { result.append(search_term_02.lowercased()) }
        if let search_term_03 = self.search_term_03, search_term_03.count > 0 { result.append(search_term_03.lowercased()) }
        if let search_term_04 = self.search_term_04, search_term_04.count > 0 { result.append(search_term_04.lowercased()) }
        if let search_term_05 = self.search_term_05, search_term_05.count > 0 { result.append(search_term_05.lowercased()) }
        if let search_term_06 = self.search_term_06, search_term_06.count > 0 { result.append(search_term_06.lowercased()) }
        if let search_term_07 = self.search_term_07, search_term_07.count > 0 { result.append(search_term_07.lowercased()) }
        if let search_term_08 = self.search_term_08, search_term_08.count > 0 { result.append(search_term_08.lowercased()) }
        if let search_term_09 = self.search_term_09, search_term_09.count > 0 { result.append(search_term_09.lowercased()) }
        if let search_term_10 = self.search_term_10, search_term_10.count > 0 { result.append(search_term_10.lowercased()) }
        if let search_term_11 = self.search_term_11, search_term_11.count > 0 { result.append(search_term_11.lowercased()) }
        if let search_term_12 = self.search_term_12, search_term_12.count > 0 { result.append(search_term_12.lowercased()) }
        if let search_term_13 = self.search_term_13, search_term_13.count > 0 { result.append(search_term_13.lowercased()) }
        if let search_term_14 = self.search_term_14, search_term_14.count > 0 { result.append(search_term_14.lowercased()) }
        return result
    }
}
