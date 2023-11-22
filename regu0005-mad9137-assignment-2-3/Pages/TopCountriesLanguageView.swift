//
//  TopCountriesLanguageView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-20.
//

import SwiftUI
import Charts

extension PostCountry {
    var color: Color {
        let colors: [Color] = [
            .red, .green, .blue,
            .orange, .yellow, .purple,
            .pink, .cyan, .mint,
            .indigo, .brown, .gray
        ]
        return colors[self.id % colors.count]
    }
}

struct TopCountriesLanguageView: View {
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    var topCountries: [PostCountry]
    @ObservedObject var countriesDataModel: CountriesDataModel
    
    var languageName: String
    
        var body: some View {
                VStack {
                    Text("Language Top 10")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,20)
                    Text("Top 10 countries that speak \(languageName)")
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
                        NavigationLink(destination: CountryDetail(favoritesManagerModel: favoritesManagerModel, country: country, countriesDataModel: countriesDataModel)) {
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
//    TopCountriesLanguageView(topCountries: [PostCountry])
//}

// Preview Provider with dummy data
struct TopCountriesLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyCountries = [
            PostCountry(id: 1, name: "Country A", image: "", flag: "🇦🇽", capital: "Capital A", population: 2500, region: "", area: 10, languages: [Language(idLanguage: 2, language: "English")]),
            PostCountry(id: 1, name: "Country B", image: "", flag: "🇦🇽", capital: "Capital B", population: 2800, region: "", area: 10, languages: [Language(idLanguage: 2, language: "English")]),
            PostCountry(id: 1, name: "Country C", image: "", flag: "🇦🇽", capital: "Capital C", population: 500, region: "", area: 10, languages: [Language(idLanguage: 2, language: "English")]),
        ]

        TopCountriesLanguageView(favoritesManagerModel: FavoritesManagerModel(), topCountries: dummyCountries, countriesDataModel: CountriesDataModel() ,languageName: "English")
    }
}
