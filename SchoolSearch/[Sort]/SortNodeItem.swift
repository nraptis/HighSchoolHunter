//
//  DBSchoolSortNode.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/29/22.
//

import Foundation

class SortNodeItem<SearchItem> {
    
    let words: [String]
    let searchTermItem: SearchTermItem<SearchItem>
    
    //Priority 1
    private(set) var prefixCount = 0
    
    //Priority 2
    private(set) var isInOrderExact = false
    
    //Priority 3
    private(set) var isInOrderStaggered = false
    
    //Priority 4
    private(set) var doesStartWithSameFirstWord = false
    
    init(words: [String], searchTermItem: SearchTermItem<SearchItem>) {
        self.words = words
        self.searchTermItem = searchTermItem
        computePrefixCount()
        computeIsInOrderExact()
        computeIsInOrderStaggered()
        computeDoesStartWithSameFirstWord()
    }
    
    private func computePrefixCount() {
        prefixCount = 0
        for word in words {
            var isPrefix = false
            for searchTerm in searchTermItem.searchTerms {
                guard let range = searchTerm.range(of: word) else { continue }
                if range.lowerBound == searchTerm.startIndex {
                    isPrefix = true
                }
            }
            if isPrefix {
                prefixCount += 1
            }
        }
    }
    
    private func computeIsInOrderExact() {
        isInOrderExact = false
        for wordIndex in 0..<min(words.count, searchTermItem.searchTerms.count) {
            let word = words[wordIndex]
            var searchTerm = searchTermItem.searchTerms[wordIndex]
            if searchTerm.range(of: word) == nil {
                return
            }
        }
        isInOrderExact = true
    }
    
    private func computeIsInOrderStaggered() {
        isInOrderStaggered = false
        
        var wordIndex = 0
        var termIndex = 0
        while wordIndex < words.count && termIndex < searchTermItem.searchTerms.count {
            
            let word = words[wordIndex]
            var searchTerm = searchTermItem.searchTerms[termIndex]
            if searchTerm.range(of: word) != nil {
                wordIndex += 1
                if wordIndex == words.count {
                    //print("words: \(words) {in order} \(termListWrapper.terms)")
                    isInOrderStaggered = true
                    return
                }
            } else {
                termIndex += 1
            }
        }
    }
    
    private func computeDoesStartWithSameFirstWord() {
        doesStartWithSameFirstWord = false
        guard words.count > 0 else { return }
        guard searchTermItem.searchTerms.count > 0 else { return }
        
        let word = words[0]
        let searchTerm = searchTermItem.searchTerms[0]
        
        guard let range = searchTerm.range(of: word) else { return }
        
        if range.lowerBound == searchTerm.startIndex {
            doesStartWithSameFirstWord = true
        }
    }
    
}
