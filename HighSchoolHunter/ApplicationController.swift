//
//  ApplicationController.swift
//  HighSchoolHunter
//
//  Created by Nicky Taylor on 10/30/22.
//

import Foundation

class ApplicationController {
    
    let networkManager = NetworkManager()
    let databaseManager = DatabaseManager()
    
    lazy var viewModel = {
        ViewModel(app: self)
    }()
    
}
