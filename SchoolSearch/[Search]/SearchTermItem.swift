//
//  SearchTermItem.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/30/22.
//

import Foundation

struct SearchTermItem<SearchItem> {
    let item: SearchItem
    let searchTerms: [String]
    init(item: SearchItem, searchTerms: [String]) {
        self.item = item
        self.searchTerms = searchTerms
    }
}
