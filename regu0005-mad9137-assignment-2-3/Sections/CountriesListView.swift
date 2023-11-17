//
//  CountriesListView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-15.
//

import SwiftUI
import SVGKit


struct CountriesListView: View {
    @ObservedObject var countriesDataModel: CountriesDataModel
    
    var body: some View {
        Text("Largest Countries by Area")
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 5)
        
            LazyVStack {
                ForEach(countriesDataModel.getMostLargestCountries()) { country in
                    HStack {
                        SVGImageView(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!)
                                                    .frame(width: 50, height: 30)
                                                    .cornerRadius(5)
                                                    .padding(.leading,30)
                                                    .padding(.trailing,30)


                        VStack(alignment: .leading) {
                            Text(country.name)
                                .font(.headline)
                            Text("Capital: \(country.capital)")
                                .font(.subheadline)
                            Text("Area: \(country.area)")
                                .font(.subheadline)
                            Text("Population: \(country.population)")
                                .font(.footnote)
                            
                        }
                        Spacer()
                    }
                    Divider()
                }
            }            
    }
}

#Preview {
    CountriesListView(countriesDataModel: CountriesDataModel())
}
