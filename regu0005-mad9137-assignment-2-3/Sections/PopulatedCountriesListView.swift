//
//  PopulatedCountriesListView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-17.
//

import SwiftUI

struct PopulatedCountriesListView: View {
    var countries: [PostCountry]

        var body: some View {
            ForEach(countries, id: \.id) { country in
                Text(country.name + ": " + String(country.population))
            }
        }
}
