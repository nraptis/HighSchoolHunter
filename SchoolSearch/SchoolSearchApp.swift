//
//  SchoolSearchApp.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/27/22.
//

import SwiftUI

@main
struct SchoolSearchApp: App {
    
    let app = ApplicationController()
    var body: some Scene {
        WindowGroup {
            content()
        }
    }
    
    func content() -> some View {
        print("App content")
        return SchoolListView(viewModel: app.schoolListViewModel)
    }
    
}
