//
//  SearchHelper.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/29/22.
//

import Foundation

protocol SearchTermsConvertible: Hashable {
    func searchTerms() -> [String]
}

class SearchHelper<SearchItem: SearchTermsConvertible> {
    
    private func filterMatchesToMatchingAll(withWords words: [String],
                                            andMatches matches: [[SearchItem]]) async -> [SearchItem] {
        
        var matchSets = [Set<SearchItem>](repeating: Set<SearchItem>(), count: words.count)
        for index in words.indices {
            let matchListForWord = matches[index]
            for SearchItem in matchListForWord {
                matchSets[index].insert(SearchItem)
            }
        }
        
        let matches0 = matches[0]
        var result = [SearchItem]()
        
        for SearchItem in matches0 {
            var allContains = true
            for matchSet in matchSets {
                if !matchSet.contains(SearchItem) {
                    allContains = false
                    break
                }
            }
            if allContains {
                result.append(SearchItem)
            }
        }
        
        return result
    }
    
    private func filterMatchesEliminatingSharedTermMatches(withWords words: [String], andMatchingAllSearchTermItems matchingAllSearchTermItems: [SearchTermItem<SearchItem>]) async -> [SearchTermItem<SearchItem>] {
        
        func helper(searchTerms: [String],
                    usedSearchTerms: inout [Bool],
                    words: [String],
                    wordIndex: Int,
                    matchCount: Int) -> Bool {
            
            if matchCount == words.count { return true }
            if wordIndex == words.count { return false }
            
            let word = words[wordIndex]
            
            for termIndex in searchTerms.indices {
                if usedSearchTerms[termIndex] == false {
                    let searchTerm = searchTerms[termIndex]
                    if searchTerm.range(of: word) != nil {
                        usedSearchTerms[termIndex] = true
                        if helper(searchTerms: searchTerms,
                                  usedSearchTerms: &usedSearchTerms,
                                  words: words,
                                  wordIndex: wordIndex + 1,
                                  matchCount: matchCount + 1) {
                            return true
                        }
                        usedSearchTerms[termIndex] = false
                    }
                }
            }
            return false
        }
        
        var result = [SearchTermItem<SearchItem>]()
        for searchTermItem in matchingAllSearchTermItems {
            var usedSearchTerms = [Bool](repeating: false, count: searchTermItem.searchTerms.count)
            if helper(searchTerms: searchTermItem.searchTerms,
                      usedSearchTerms: &usedSearchTerms,
                      words: words,
                      wordIndex: 0,
                      matchCount: 0) {
                result.append(searchTermItem)
            }
        }
        return result
    }
    
    func processCoreDataMatches(withWords words: [String], andMatches matches: [[SearchItem]]) async -> [SearchTermItem<SearchItem>] {
        
        if words.count != matches.count {
            fatalError("words expected to map 1:1 to matches")
        }
        
        if words.count <= 0 {
            return [SearchTermItem<SearchItem>]()
        }
        
        let matchingAll = await filterMatchesToMatchingAll(withWords: words, andMatches: matches)
        
        let matchingAllSearchTermItems = matchingAll.map { item in
            SearchTermItem(item: item, searchTerms: item.searchTerms())
        }
        
        let matchingAllEliminatingSharedTermMatches = await filterMatchesEliminatingSharedTermMatches(withWords: words, andMatchingAllSearchTermItems: matchingAllSearchTermItems)
        
        return matchingAllEliminatingSharedTermMatches
    }
    
}
