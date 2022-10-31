//
//  HighSchoolHunterApp.swift
//  HighSchoolHunter
//
//  Created by Nicky Taylor on 10/30/22.
//

import SwiftUI

@main
struct HighSchoolHunterApp: App {
    let app = ApplicationController()
    var body: some Scene {
        WindowGroup {
            SchoolSearchView(viewModel: app.viewModel)
        }
    }
}
