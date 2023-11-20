//
//  TestingData.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-16.
//

import SwiftUI

struct TestingData: View {
    
    @ObservedObject var countriesDataModel: CountriesDataModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        LazyVStack {
                    ForEach(countriesDataModel.countries) { country in
                        Text(country.name)
                    }
                }
                .onAppear {
                   // init()
                }
    }
}

#Preview {
    TestingData(countriesDataModel: CountriesDataModel())
}
