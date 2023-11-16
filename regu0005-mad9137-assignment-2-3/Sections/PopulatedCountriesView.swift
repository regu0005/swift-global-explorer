//
//  PopulatedCountriesView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI
//import SVGKit

struct Country {
    var name: String
    var detail: String
    var population: String
    var area: String
    var imageName: String
    var flagURL: String
}

struct PopulatedCountriesView: View {
    
    let countries = [
        Country(name: "Afghanistan", detail: "Capital: Kabul", population: "40,218,234", area: "652,230 km²", imageName: "afghanistanImage", flagURL: "https://upload.wikimedia.org/wikipedia/commons/5/5c/Flag_of_the_Taliban.svg"),
        Country(name: "Åland Islands", detail: "Capital: Mariehamn", population: "28,875", area: "1,580 km²", imageName: "alandIslandsImage", flagURL: "https://flagcdn.com/ax.svg"),
        Country(name: "Albania", detail: "Capital: Tirana", population: "2,837,743", area: "28,748 km²", imageName: "albaniaImage", flagURL: "https://flagcdn.com/al.svg"),
        Country(name: "Algeria", detail: "Capital: Algiers", population: "43,851,043", area: "2,381,741 km²", imageName: "algeriaImage", flagURL: "https://flagcdn.com/dz.svg"),
        Country(name: "American Samoa", detail: "Capital: Pago Pago", population: "55,197", area: "199 km²", imageName: "americanSamoaImage", flagURL: "https://flagcdn.com/as.svg"),
        Country(name: "Albania", detail: "Capital: Tirana", population: "2,837,743", area: "28,748 km²", imageName: "albaniaImage", flagURL: "https://flagcdn.com/al.svg"),

    ]

    let urlTest = "https://tusmodelos.com/images/icon-flutter.png"
    
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
                
                            ForEach(countries, id: \.name) { country in
                                VStack() {
    //                                countryFlagImage(country.flagURL)
                                    countryFlagImage(urlTest)
                                        .frame(height: imageHeight)
                                        .cornerRadius(10)
                                        .clipped()

                                    Text(country.name)
                                        .font(.title2)
                                        .padding(.top, 5)

//                                    Text(country.detail)
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
                                    Text("Population:")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                    Text(country.population)
                                        .font(.footnote)
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
        
        
    // Function to load flag image... in process
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
    PopulatedCountriesView()
}
