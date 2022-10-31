//
//  ItemWithSearchTerms.swift
//  HighSchoolHunter
//
//  Created by Nicky Taylor on 10/30/22.
//

import Foundation

protocol ItemWithSearchTermsConvertible {
    associatedtype SearchItem
    func toItemWithSearchTerms() -> ItemWithSearchTerms<SearchItem>
}

struct ItemWithSearchTerms<SearchItem> {
    let item: SearchItem
    let searchTerms: [String]
    init(item: SearchItem, searchTerms: [String]) {
        self.item = item
        self.searchTerms = searchTerms
    }
}
