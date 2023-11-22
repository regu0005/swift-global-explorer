//
//  FavoritesView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-21.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    @ObservedObject var countriesDataModel: CountriesDataModel
    @Environment(\.colorScheme) var colorScheme

        var body: some View {
            List(favoriteCountries) { country in
                NavigationLink(destination: CountryDetail(favoritesManagerModel: favoritesManagerModel, country: country, countriesDataModel: countriesDataModel)) {
                    
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
                    
                } // End NavigationLink
                
            }
            .navigationBarTitle("Favorites")
        }

    
        private var favoriteCountries: [PostCountry] {
            countriesDataModel.countries.filter { country in
                favoritesManagerModel.getFavorites().keys.contains(country.id)
            }
        }
    
        var textColorDetails: Color {
            return colorScheme == .dark ? .gray : .secondary
        }
        var textColorTitle: Color {
            return colorScheme == .dark ? .white : .black
        }
    
    }


    struct FavoritesView_Previews: PreviewProvider {
        static var previews: some View {
            FavoritesView(
                favoritesManagerModel: FavoritesManagerModel(),
                countriesDataModel: CountriesDataModel()
            )
        }
    }
