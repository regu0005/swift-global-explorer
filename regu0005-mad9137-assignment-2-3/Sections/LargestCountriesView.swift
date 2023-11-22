//
//  CountriesListView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-15.
//

import SwiftUI
import SVGKit

struct LargestCountriesView: View {
    @ObservedObject var countriesDataModel: CountriesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            Text("Largest Countries by Area")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 5)
            
                LazyVStack {
                    ForEach(countriesDataModel.getMostLargestCountries()) { country in
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
                }
        }
        .padding(.horizontal)
    } // Body view
    
    var textColorDetails: Color {
        return colorScheme == .dark ? .gray : .secondary
    }
    var textColorTitle: Color {
        return colorScheme == .dark ? .white : .black
    }
}

#Preview {
    LargestCountriesView(countriesDataModel: CountriesDataModel(), favoritesManagerModel: FavoritesManagerModel())
}
