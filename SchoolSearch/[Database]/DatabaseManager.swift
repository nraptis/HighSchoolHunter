//
//  DatabaseManager.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/29/22.
//

import Foundation
import CoreData

final class DatabaseManager {
    
    let container: NSPersistentContainer
    private let searchHelper = SearchHelper<DBSchool>()
    private let sortHelper = SortHelper<DBSchool>()
    
    required init() {
        container = NSPersistentContainer(name: "SchoolData")
    }
    
    func loadPersistentStores() async {
        await withCheckedContinuation { continuation in
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                continuation.resume()
            })
        }
    }
    
    func fetchSchools() async throws -> [DBSchool] {
        let context = container.viewContext
        var result = [DBSchool]()
        
        try await context.perform {
            let fetchRequest = DBSchool.fetchRequest()
            result = try context.fetch(fetchRequest)
        }
        
        return result
    }
    
    func searchSchools(withWords words: [String]) async throws -> [DBSchool] {
        if words.count <= 0 {
            let result = try await fetchSchools()
            return result
        }
        
        let context = container.viewContext
        
        var matches = try await withThrowingTaskGroup(of: [DBSchool].self) { group -> [[DBSchool]] in
            for index in words.indices {
                group.addTask {
                    let word = words[index]
                    let matchesForWord = try await self.buildSearchResultsFor(word: word, inContext: context)
                    return matchesForWord
                }
            }
            
            var matches = [[DBSchool]]()
            for try await matchList in group {
                matches.append(matchList)
            }
            
            return matches
        }
        
        let searchHelperResults = await searchHelper.processCoreDataMatches(withWords: words,
                                                                            andMatches: matches)
        
        let preferredOrdering = try await fetchSchools()
        let sortHelperResults = await sortHelper.processSearchResults(withWords: words,
                                                                      andSearchTermItems: searchHelperResults,
                                                                      andPreferredOrdering: preferredOrdering)
        
        return sortHelperResults
        
    }
    
    private func buildSearchResultsFor(word: String, inContext context: NSManagedObjectContext) async throws -> [DBSchool] {
        
        let predicate_00 = NSPredicate(format: "search_term_00 CONTAINS %@", word)
        let predicate_01 = NSPredicate(format: "search_term_01 CONTAINS %@", word)
        let predicate_02 = NSPredicate(format: "search_term_02 CONTAINS %@", word)
        let predicate_03 = NSPredicate(format: "search_term_03 CONTAINS %@", word)
        let predicate_04 = NSPredicate(format: "search_term_04 CONTAINS %@", word)
        let predicate_05 = NSPredicate(format: "search_term_05 CONTAINS %@", word)
        let predicate_06 = NSPredicate(format: "search_term_06 CONTAINS %@", word)
        let predicate_07 = NSPredicate(format: "search_term_07 CONTAINS %@", word)
        let predicate_08 = NSPredicate(format: "search_term_08 CONTAINS %@", word)
        let predicate_09 = NSPredicate(format: "search_term_09 CONTAINS %@", word)
        let predicate_10 = NSPredicate(format: "search_term_10 CONTAINS %@", word)
        let predicate_11 = NSPredicate(format: "search_term_11 CONTAINS %@", word)
        let predicate_12 = NSPredicate(format: "search_term_12 CONTAINS %@", word)
        let predicate_13 = NSPredicate(format: "search_term_13 CONTAINS %@", word)
        let predicate_14 = NSPredicate(format: "search_term_14 CONTAINS %@", word)
        
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
            predicate_00, predicate_01, predicate_02, predicate_03,
            predicate_04, predicate_05, predicate_06, predicate_07,
            predicate_08, predicate_09, predicate_10, predicate_11,
            predicate_12, predicate_13, predicate_14])
        
        let request = DBSchool.fetchRequest()
        request.predicate = compoundPredicate
        
        var results = [DBSchool]()
        try await context.perform {
            results = try context.fetch(request)
        }
        
        return results
    }
    
    func merge(nwSchools: [NWSchool]) async throws {
        
        let context = container.viewContext
        try await context.perform {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBSchool")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(batchDeleteRequest)
            
            for school in nwSchools {
                let dbSchool = DBSchool(context: context)
                dbSchool.dbn = school.dbn
                dbSchool.school_name = school.school_name
                dbSchool.primary_address_line_1 = school.primary_address_line_1
                dbSchool.city = school.city
                dbSchool.zip = school.zip
                dbSchool.state_code = school.state_code
                
                let terms = Tokenizer.tokenize(school.school_name)
                
                if terms.count > 0 { dbSchool.search_term_00 = terms[0] }
                if terms.count > 1 { dbSchool.search_term_01 = terms[ 1] }
                if terms.count > 2 { dbSchool.search_term_02 = terms[ 2] }
                if terms.count > 3 { dbSchool.search_term_03 = terms[ 3] }
                if terms.count > 4 { dbSchool.search_term_04 = terms[ 4] }
                if terms.count > 5 { dbSchool.search_term_05 = terms[ 5] }
                if terms.count > 6 { dbSchool.search_term_06 = terms[ 6] }
                if terms.count > 7 { dbSchool.search_term_07 = terms[ 7] }
                if terms.count > 8 { dbSchool.search_term_08 = terms[ 8] }
                if terms.count > 9 { dbSchool.search_term_09 = terms[ 9] }
                if terms.count > 10 { dbSchool.search_term_10 = terms[10] }
                if terms.count > 11 { dbSchool.search_term_11 = terms[11] }
                if terms.count > 12 { dbSchool.search_term_12 = terms[12] }
                if terms.count > 13 { dbSchool.search_term_13 = terms[13] }
                if terms.count > 14 { dbSchool.search_term_14 = terms[14] }
            }

            try context.save()
            
        }
        
    }
}
