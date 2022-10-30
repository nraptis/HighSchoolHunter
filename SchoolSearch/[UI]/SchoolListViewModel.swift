//
//  SchoolListViewModel.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/27/22.
//

import SwiftUI
import CoreData

class SchoolListViewModel: ObservableObject {
    
    static func preview() -> SchoolListViewModel {
        return SchoolListViewModel(app: ApplicationController.preview())
    }
    
    @Published var schools = [UISchool]()
    @Published var isLoading = false
    @Published var showingNoSATAlert = false
    @Published var showingErrorAlert = false
    
    private let highlighter = MatchingTextHighlighter()
    
    
    let app: ApplicationController
    init(app: ApplicationController) {
        print("SchoolListViewModel => create()")
        self.app = app
        initializationSequence()
    }
    
    deinit {
        print("SchoolListViewModel => destroy()")
    }
    
    func initializationSequence() {
        Task {
            await MainActor.run {
                self.isLoading = true
            }
            
            await app.databaseManager.loadPersistentStores()
            
            var nwSchools = [NWSchool]()
            do {
                nwSchools = try await app.networkManager.fetchSchools()
            } catch let error {
                print("ERROR: networkManager fetch schools error: \(error.localizedDescription)")
            }
            
            if nwSchools.count > 0 {
                do {
                    try await app.databaseManager.merge(nwSchools: nwSchools)
                } catch let error {
                    print("ERROR: databaseManager merge schools: \(error.localizedDescription)")
                }
            }
            
            await updateSearchTextAsync(searchText)
            
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
    
    private(set) var searchText = "School Sch"
    private(set) var words = [String]()
    func updateSearchTextIntent(_ searchText: String) {
        Task {
            await updateSearchTextAsync(searchText)
        }
    }
    
    private func updateSearchTextAsync(_ searchText: String) async {
        self.searchText = searchText
        
        var dbSchools = [DBSchool]()
        words = Tokenizer.tokenize(searchText)
        
        do {
            dbSchools = try await app.databaseManager.searchSchools(withWords: words)
        } catch let error {
            print("ERROR: databaseManager fetch schools: \(error.localizedDescription)")
        }
        
        let uiSchools = dbSchools.map {
            UISchool(dbSchool: $0)
        }
        
        await MainActor.run {
            self.highlighter.resetWith(words: self.words)
            self.schools = uiSchools
            self.isLoading = false
        }
    }
    
    func name(for school: UISchool) -> AttributedString {
        return highlighter.attributedString(for: school)
    }
    
    func dbn(for school: UISchool) -> String {
        return school.dbn
    }
    
}
