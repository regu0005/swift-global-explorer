//
//  CountriesGeneralListView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-19.
//

import SwiftUI

struct CountriesGeneralListView: View {
    @ObservedObject var countriesDataModel: CountriesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            Text("List of Countries")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 5)
            
            TextField("Search for a country", text: $searchText)
                            .padding(7)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
            
                LazyVStack {
                    ForEach(filteredCountries) { country in
                        NavigationLink(destination: CountryDetail(country: country, countriesDataModel: countriesDataModel, favoritesManagerModel: favoritesManagerModel)) {
                            HStack {

                                // VALIDATION FLAG: SVG OR (PNG, JPEG, JPEG)
                                if country.flag.lowercased().hasSuffix(".svg")
                                {
                                    // Display SVG using SVGImageView
                                    SVGImageView(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!)
                                        .frame(width: 50, height: 30)
                                        .cornerRadius(5)
                                        .padding(.leading, 30)
                                        .padding(.trailing, 30)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                                else {
                                    // Display other image formats using AsyncImage
                                    AsyncImage(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 50, height: 30)
                                    .cornerRadius(5)
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                                // END VALIDATION FLAG: SVG OR (PNG, JPEG, JPEG)

                                VStack(alignment: .leading) {
                                    Text(country.name)
                                        .font(.headline)
                                        .foregroundColor(textColorTitle)
                                    Text("Capital: \(country.capital)")
                                        .font(.subheadline)
                                        .foregroundColor(textColorDetails)
                                    Text("Area: \(country.area)")
                                        .font(.subheadline)
                                        .foregroundColor(textColorDetails)
                                    Text("Population: \(country.population)")
                                        .font(.footnote)
                                        .foregroundColor(textColorDetails)
                                }
                                Spacer()
                            }
                            Divider()
                        }
                    }
                } // End LazyVStack
        } // End ScrollView
        
    } // Body view
    
    var textColorDetails: Color {
        return colorScheme == .dark ? .gray : .secondary
    }
    var textColorTitle: Color {
        return colorScheme == .dark ? .white : .black
    }
    
    var filteredCountries: [PostCountry] {
        if searchText.isEmpty {
            return countriesDataModel.countries
        } else {
            return countriesDataModel.countries.filter { country in
                country.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

//#Preview {
//    CountriesGeneralListView()
//}
