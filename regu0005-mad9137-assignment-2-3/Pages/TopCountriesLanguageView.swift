//
//  TopCountriesLanguageView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-20.
//

import SwiftUI
import Charts

struct TopCountriesLanguageView: View {
    var topCountries: [PostCountry]
    var languageName: String
    

        var body: some View {
            Text("Top 10 countries that speak \(languageName):")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 5)
            
            
            
            List(topCountries, id: \.id) { country in
                VStack(alignment: .leading) {
                    Text(country.name)
                        .font(.headline)
                    Text("Population: \(country.population)")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Language Top 10")
        }

}

//#Preview {
//    TopCountriesLanguageView(topCountries: [PostCountry])
//}
