//
//  CountriesListFetchView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-15.
//

import SwiftUI
import SVGKit


struct CountriesListFetchView: View {
    
    @State var postCountries: [PostCountry] = []
    var networkMonitor: NetworkMonitor
    
            var body: some View {
                
                Text("Largest Countries by Area")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 5)
                
                    LazyVStack {
                        ForEach(postCountries) { country in
                            HStack {
                                
                                SVGImageView(url: URL(string: country.flag) ?? URL(string: "https://example.com/placeholder.svg")!, networkMonitor: networkMonitor)
                                                            .frame(width: 50, height: 30)
                                                            .cornerRadius(5)
                                                            .padding(.leading,30)
                                                            .padding(.trailing,30)


                                VStack(alignment: .leading) {
                                    Text(country.name)
                                        .font(.headline)
                                    Text("Capital: \(country.capital)")
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
                    .onAppear {
                        fetchCountriesDataLocal()
                    }
        }

    //MARK: Model
    
    struct PostCountry: Codable, Identifiable {
        let id: Int // Add this line
        let name: String
        let image: String?
        var flag: String
        let capital: String
        let population: String
        let region: String
        let area: String
        let latitude: String?
        let longitude: String?
        let url_map: String?
        let id_region: String?

        enum CodingKeys: String, CodingKey {
            case id = "idCountry" // Map idCountry from JSON to id
            case name, image, flag, capital, population, region, area, latitude, longitude, url_map, id_region
        }
    }
    //MARK: Function to fetch post data (ViewModel)

    
    // WORKS WITH LOCAL DATA
    private func fetchCountriesDataLocal() {
        // Simulated delay to mimic network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.postCountries = [
                PostCountry(id: 772, name: "Afghanistan", image: nil, flag: "https://upload.wikimedia.org/wikipedia/commons/5/5c/Flag_of_the_Taliban.svg", capital: "Kabul", population: "40218234", region: "Asia", area: "652230", latitude: nil, longitude: nil, url_map: nil, id_region: nil),
                PostCountry(id: 773, name: "Åland Islands", image: nil, flag: "https://flagcdn.com/ax.svg", capital: "Mariehamn", population: "28875", region: "Europe", area: "1580", latitude: nil, longitude: nil, url_map: nil, id_region: nil),
                PostCountry(id: 774, name: "Albania", image: nil, flag: "https://flagcdn.com/al.svg", capital: "Tirana", population: "2837743", region: "Europe", area: "28748", latitude: nil, longitude: nil, url_map: nil, id_region: nil),
                PostCountry(id: 775, name: "Algeria", image: nil, flag: "https://flagcdn.com/dz.svg", capital: "Algiers", population: "43851043", region: "Africa", area: "2381741", latitude: nil, longitude: nil, url_map: nil, id_region: nil),
                PostCountry(id: 776, name: "American Samoa", image: nil, flag: "https://flagcdn.com/as.svg", capital: "Pago Pago", population: "55197", region: "Oceania", area: "199", latitude: nil, longitude: nil, url_map: nil, id_region: nil),
                PostCountry(id: 777, name: "Andorra", image: nil, flag: "https://flagcdn.com/ad.svg", capital: "Andorra la Vella", population: "77265", region: "Europe", area: "468", latitude: nil, longitude: nil, url_map: nil, id_region: nil),
                PostCountry(id: 778, name: "Angola", image: nil, flag: "https://flagcdn.com/ao.svg", capital: "Luanda", population: "32866268", region: "Africa", area: "1246700", latitude: nil, longitude: nil, url_map: nil, id_region: nil),
                // Continue adding dummy data as needed...
            ]
        }
    }
    
            struct PostCountryDetailView: View {
                    let postCountries: PostCountry

                    var body: some View {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(postCountries.name).font(.title).bold()
                            Text(postCountries.capital).font(.headline)
                            Text(postCountries.population).font(.headline)
                        }.padding()
                    }
                }
}

#Preview {
    CountriesListFetchView(networkMonitor: NetworkMonitor())
}
