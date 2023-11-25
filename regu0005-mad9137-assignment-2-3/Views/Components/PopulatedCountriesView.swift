//
//  PopulatedCountriesView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI
import SVGKit


struct PopulatedCountriesView: View {
    @ObservedObject var countriesDataModel: CountriesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    @Environment(\.colorScheme) var colorScheme
    
    var networkMonitor: NetworkMonitor
    
    // Constants for layout
    let gridSpacing:    CGFloat = 20
    let cardWidth:      CGFloat = 170
    let cardHeight:     CGFloat = 160
    let imageHeight:    CGFloat = 100
    
    var body: some View {

        VStack {
                HStack {
                    Text("Populated Countries")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                    Spacer()
                    NavigationLink(destination: TopCountriesPopulatedView(favoritesManagerModel: favoritesManagerModel, topCountries: countriesDataModel.getMostPopulatedCountries(), countriesDataModel: countriesDataModel, networkMonitor: networkMonitor)) {
                        Text("See more")
                            .padding(.horizontal,20)
                    }
                }.padding(.top, 15)
            
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                
                            ForEach(countriesDataModel.getMostPopulatedCountries(), id: \.id) { country in
                                NavigationLink(destination: CountryDetail(favoritesManagerModel: favoritesManagerModel, country: country, countriesDataModel: countriesDataModel, networkMonitor: networkMonitor)) {
                                    
                                    VStack() {
                                        
                                        // VALIDATION FLAG: SVG OR (PNG, JPEG, JPEG)
                                        if country.flag.lowercased().hasSuffix(".svg")
                                        {
                                            // Display SVG using SVGImageView
                                            SVGImageView(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!, networkMonitor: networkMonitor)
                                                .frame(width: 70, height: 50)
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
                                            .frame(width: 70, height: 50)
                                            .cornerRadius(5)
                                            .padding(.leading, 30)
                                            .padding(.trailing, 30)
                                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                        }
                                        // END VALIDATION FLAG: SVG OR (PNG, JPEG, JPEG)

                                        Text(country.name)
                                            .font(.title2)
                                            .padding(.top, 5)
                                        Text("Population:")
                                            .font(.subheadline)
                                            .foregroundColor(textColor)
                                        Text("\(country.population)")
                                            .font(.subheadline)
                                            .foregroundColor(textColor)
                                    }
                                    .padding(.top, 5)
                                    .frame(width: cardWidth, height: cardHeight) 
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 1)
                                }
                                
                            }
                            .padding(.bottom, 5)
                } // lazyVGrid
                .padding(.horizontal)
        } // VStack
        .padding(.horizontal)
    } // Body view
        
    var textColor: Color {
        return colorScheme == .dark ? .gray : .secondary
    }
    
    // Function to load flag image
    @ViewBuilder
    private func countryFlagImage(_ url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    PopulatedCountriesView(countriesDataModel: CountriesDataModel(), favoritesManagerModel: FavoritesManagerModel(), networkMonitor: NetworkMonitor())
}
