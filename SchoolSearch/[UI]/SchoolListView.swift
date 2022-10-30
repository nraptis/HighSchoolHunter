//
//  SchoolListView.swift
//  SchoolSearch
//
//  Created by Nicky Taylor on 10/27/22.
//

import SwiftUI

struct SchoolListView: View {
    
    @State private var searchText: String
    @FocusState private var searchBarFocused: Bool
    
    @ObservedObject var viewModel: SchoolListViewModel
    
    init(viewModel: SchoolListViewModel) {
        self.viewModel = viewModel
        self.searchText = viewModel.searchText
    }
    
    var body: some View {
        VStack(spacing: 0) {
            searchCell()
            List {
                
                Spacer()
                    .frame(height: 24)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                ForEach(viewModel.schools) { school in
                    schoolCell(viewModel.name(for: school))
                }
                
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                
                Spacer()
                    .frame(height: 360)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            Spacer()
        }
        .onChange(of: searchText) {
            viewModel.updateSearchTextIntent($0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func searchCell() -> some View {
        VStack {
            ZStack {
                TextField("Enter Search Terms", text: $searchText)
                    .focused($searchBarFocused)
                    .font(.system(size: 24))
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                /*
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            
                            Button {
                                searchText = ""
                            } label: {
                                Text("Clear")
                            }
                            .buttonStyle(.bordered)

                            Button {
                                searchBarFocused = false
                            } label: {
                                Text("Done")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                */
            }
            .padding(.horizontal, 8)
            .padding(.all, 6)
            
            .background(Capsule()
                .fill()
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0)))
            .background(Capsule()
                .stroke()
                .foregroundColor(Color(red: 0.65, green: 0.65, blue: 0.65)))
            
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            HStack {
                Spacer()
            }
            .frame(height: 1)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            
        }
        .background(Color(red: 0.72, green: 0.72, blue: 0.72))
    }
    
    func schoolCell(_ text: AttributedString) -> some View {
        HStack {
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 24))
                .lineLimit(5)
                .multilineTextAlignment(.leading)
                Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 24)
        
        .background(RoundedRectangle(cornerRadius: 12)
            .fill()
            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95)))
        .background(RoundedRectangle(cornerRadius: 12)
            .stroke()
            .foregroundColor(Color(red: 0.65, green: 0.65, blue: 0.65)))
        
        .padding(.horizontal, 24)
        .padding(.vertical, 6)
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView(viewModel: SchoolListViewModel.preview())
    }
}
