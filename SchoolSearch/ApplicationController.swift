//
//  ApplicationController.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/29/22.
//

import Foundation

class ApplicationController: ObservableObject {
    
    static func preview() -> ApplicationController {
        let result = ApplicationController()
        return result
    }
    
    let networkManager = NetworkManager()
    let databaseManager = DatabaseManager()
    
    lazy var schoolListViewModel = {
        SchoolListViewModel(app: self)
    }()
}
