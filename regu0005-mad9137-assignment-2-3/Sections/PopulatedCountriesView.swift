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
    
    // Constants for layout
    let gridSpacing:    CGFloat = 20
    let cardWidth:      CGFloat = 170
    let cardHeight:     CGFloat = 180
    let imageHeight:    CGFloat = 100
    
    var body: some View {

        VStack {
            Text("Populated Countries")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 5)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                
                            //ForEach(countries, id: \.name) { country in
                            ForEach(countriesDataModel.getMostPopulatedCountries(), id: \.id) { country in
                                VStack() {
    //                                countryFlagImage(country.flagURL)
//                                    countryFlagImage(country.flag)
//                                        .frame(height: imageHeight)
//                                        .cornerRadius(10)
//                                        .clipped()
                                    SVGImageView(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!)
                                                                .frame(width: 100, height: 60)
                                                                .cornerRadius(5)
                                                                .padding(.leading,30)
                                                                .padding(.trailing,30)

                                    Text(country.name)
                                        .font(.title2)
                                        .padding(.top, 5)

//                                    Text(country.detail)
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
                                    Text("Population:")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("\(country.population)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
//                                    Text("Area: \(country.area)")
//                                        .font(.footnote)
//                                        .foregroundColor(.secondary)
                                    //HStack {
    //                                    Text("Population: \(country.population)")
//                                        Spacer()
                                        
                                    //}
//                                    .font(.footnote)
//                                    .foregroundColor(.secondary)
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 15)
//                                .padding()
                                .frame(width: cardWidth, height: cardHeight) // Fixed width for each card
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                            }
                            .padding(.bottom, 5)
                }
                .padding(.horizontal)
            }
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
    PopulatedCountriesView(countriesDataModel: CountriesDataModel())
}
