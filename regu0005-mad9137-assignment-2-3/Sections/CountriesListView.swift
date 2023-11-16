//
//  CountriesListView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-15.
//

import SwiftUI

struct CountryData: Identifiable {
    let id = UUID()
    var name: String
    var detail: String
    var population: String
    var area: String
    var imageName: String
    var flagURL: String
}

struct CountriesListView: View {
    let countries2 = [
        CountryData(name: "Afghanistan", detail: "Capital: Kabul", population: "40,218,234", area: "652,230 km²", imageName: "afghanistanImage", flagURL: "https://upload.wikimedia.org/wikipedia/commons/5/5c/Flag_of_the_Taliban.svg"),
        CountryData(name: "Åland Islands", detail: "Capital: Mariehamn", population: "28,875", area: "1,580 km²", imageName: "alandIslandsImage", flagURL: "https://flagcdn.com/ax.svg"),
        CountryData(name: "Albania", detail: "Capital: Tirana", population: "2,837,743", area: "28,748 km²", imageName: "albaniaImage", flagURL: "https://flagcdn.com/al.svg"),
        CountryData(name: "Algeria", detail: "Capital: Algiers", population: "43,851,043", area: "2,381,741 km²", imageName: "algeriaImage", flagURL: "https://flagcdn.com/dz.svg"),
        CountryData(name: "American Samoa", detail: "Capital: Pago Pago", population: "55,197", area: "199 km²", imageName: "americanSamoaImage", flagURL: "https://flagcdn.com/as.svg"),
        CountryData(name: "Albania", detail: "Capital: Tirana", population: "2,837,743", area: "28,748 km²", imageName: "albaniaImage", flagURL: "https://flagcdn.com/al.svg"),
    ]

    let urlTest = "https://tusmodelos.com/images/icon-flutter.png"
    
    var body: some View {
        Text("Largest Countries by Area")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 5)
        
        LazyVStack {
            ForEach(countries2) { country in
                HStack {
    //                AsyncImage(url: URL(string: country.flagURL)) { image in
                    AsyncImage(url: URL(string: urlTest)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 30)
                    .cornerRadius(5)
                    .padding(.leading,30)
                    .padding(.trailing,30)

                    VStack(alignment: .leading) {
                        Text(country.name)
                            .font(.headline)
                        Text(country.detail)
                            .font(.subheadline)
                        Text("Population: \(country.population)")
                            .font(.footnote)
                        Text("Area: \(country.area)")
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
    CountriesListView()
}
