//
//  SortHelper.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/29/22.
//

import Foundation

class SortHelper<SearchItem: Hashable> {
    
    
    func processSearchResults(withWords words: [String],
                              andSearchTermItems searchTermItems: [SearchTermItem<SearchItem>],
                              andPreferredOrdering preferredOrdering: [SearchItem]) async -> [SearchItem] {
        
        var preferredOrderDict = [SearchItem: Int]()
        for (index, item) in preferredOrdering.enumerated() {
            preferredOrderDict[item] = index
        }
        
        var sortNodes = [SortNodeItem<SearchItem>]()
        for searchTermItem in searchTermItems {
            let sortNode = SortNodeItem(words: words, searchTermItem: searchTermItem)
            sortNodes.append(sortNode)
        }
        
        sortNodes.sort { lhs, rhs in
            if lhs.prefixCount == rhs.prefixCount {
                if lhs.isInOrderExact == rhs.isInOrderExact {
                    if lhs.isInOrderStaggered == rhs.isInOrderStaggered {
                        if lhs.doesStartWithSameFirstWord == rhs.doesStartWithSameFirstWord {
                            let lhsIndex = preferredOrderDict[lhs.searchTermItem.item] ?? 0
                            let rhsIndex = preferredOrderDict[rhs.searchTermItem.item] ?? 0
                            return lhsIndex < rhsIndex
                        } else {
                            return lhs.doesStartWithSameFirstWord
                        }
                    } else {
                        return lhs.isInOrderStaggered
                    }
                } else {
                    return lhs.isInOrderExact
                }
            } else {
                return lhs.prefixCount > rhs.prefixCount
            }
        }
        
        /*
        sortNodes.sort { lhs, rhs in
            if lhs.prefixCount == rhs.prefixCount {
                if lhs.isInOrder == rhs.isInOrder {
                    if lhs.doesMatchExactlyOnFirstWord == rhs.doesMatchExactlyOnFirstWord {
                        if lhs.doesStartWithSameFirstWord == rhs.doesStartWithSameFirstWord {
                            let lhsIndex = preferredOrderDict[lhs.termListWrapper.dbSchool] ?? 0
                            let rhsIndex = preferredOrderDict[rhs.termListWrapper.dbSchool] ?? 0
                            return lhsIndex < rhsIndex
                        } else {
                            return lhs.doesStartWithSameFirstWord
                        }
                    } else {
                        return lhs.doesMatchExactlyOnFirstWord
                    }
                } else {
                    return lhs.isInOrder
                }
            } else {
                return lhs.prefixCount > rhs.prefixCount
            }
        }
        */
        
        let result = sortNodes.map {
            $0.searchTermItem.item
        }
        return result
    }
}
