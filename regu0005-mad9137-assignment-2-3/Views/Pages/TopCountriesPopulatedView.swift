//
//  TopCountriesPopulatedView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-24.
//

import SwiftUI
import Charts

struct TopCountriesPopulatedView: View {
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    var topCountries: [PostCountry]
    @ObservedObject var countriesDataModel: CountriesDataModel
    var networkMonitor: NetworkMonitor
    
        var body: some View {
                VStack {
                    Text("Top 10 Populated Countries")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,20)
                    Text("List of top 10 populated countries in the world")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Chart(topCountries, id: \.id) { country in
                        // Scale down because the chart doesn't work with huge numbers
                        let scaledPopulation = Double(country.population) / 1000000
                        SectorMark(
                            angle: .value("Population", scaledPopulation),
                            angularInset: 1
                        )
                        .annotation(position: .overlay) {
                            Text("\(country.name)")
                                .foregroundStyle(.white)
                                .font(.footnote)
                        }
                        .foregroundStyle(country.color)
                    }
                    .padding(.horizontal, 60)
                    .padding(.bottom,10)
                    
                    List(topCountries, id: \.id) { country in
                        NavigationLink(destination: CountryDetail(favoritesManagerModel: favoritesManagerModel, country: country, countriesDataModel: countriesDataModel, networkMonitor: networkMonitor)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Label("", systemImage: "square.fill")
                                        .foregroundStyle(country.color)
                                    Text(country.name)
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                Text("Population: \(country.population)")
                                    .font(.subheadline)
                                    .padding(.leading,50)
                            }
                        }
                        
                    }
                    .padding(.top,-20)
                }
        }
}

//#Preview {
//    TopCountriesPopulatedView()
//}
