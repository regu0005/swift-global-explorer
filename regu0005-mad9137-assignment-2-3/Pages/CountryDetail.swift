//
//  CountryDetail.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-17.
//
import SwiftUI
import SVGKit

public struct CountryDetail: View {
    var country: PostCountry
    
    let imageUrl: String = "https://tusmodelos.com/images/img_6.png"
    @State var isFavorite: Bool = false
    

    public var body: some View {
        
        ScrollView {
            // Main image
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 240)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)

                        Button(action: {
                            isFavorite.toggle()
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                                .font(.system(size: 30))
                                .padding(.top, 60)
                                .padding(.trailing, 10)
                                .padding(.trailing)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 240)
            
            Text(country.name)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 5)
            HStack {
                Text("Capital:")
                        .font(.title2)
                        .frame(maxWidth: 100, alignment: .leading)
                        .padding(.top,1)
                        .padding(.leading,40)
                        .foregroundColor(.gray)
                        .background(Color(.yellow))
                Text("\(country.capital)")
                        .font(.title2)
                        .frame(alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                        .background(Color(.yellow))
                Spacer()
            }
            HStack {
                Text("Population:")
                        .font(.title3)
                        .frame(maxWidth: 100, alignment: .leading)
                        .padding(.top,1)
                        .padding(.leading,40)
                        .foregroundColor(.gray)
                        .background(Color(.yellow))
                Text("\(country.population)")
                        .font(.title3)
                        .frame(alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                        .background(Color(.yellow))
                Spacer()
            }
            HStack {
                Text("Area:")
                        .font(.title3)
                        .frame(maxWidth: 100, alignment: .leading)
                        .padding(.top,1)
                        .padding(.leading,40)
                        .foregroundColor(.gray)
                        .background(Color(.yellow))
                Text("\(country.capital) km2")
                        .font(.title3)
    //                        .bold()
                        .frame(alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                        .background(Color(.yellow))
                Spacer()
            }
            HStack{
                Text("Canada is the second largest country in the world, known for its vast landscapes, multicultural cities, and a strong commitment to human rights and equality.")
                    .padding(.top,8)
                    .padding(.horizontal)
            }
            VStack {
                Text("Languages")
                    .font(.title3)
                    .bold()
                    .padding(.top,10)
                    .padding(.leading, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(alignment: .top, spacing: 20) {
                    ForEach(country.languages, id: \.id) { language in
                        HStack(spacing: 8) {
                          Text(language.language)
                            .font(Font.custom("Inter", size: 16))
                            .lineSpacing(24)
                            .foregroundColor(Color(red: 0.10, green: 0.13, blue: 0.17))
                        }
                        .frame(width: 126, height: 38)
                        .background(Color(red: 0.89, green: 0.91, blue: 0.94))
                        .cornerRadius(6)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                .frame(maxWidth: .infinity)
            }
            VStack {
                Text("Flag")
                    .font(.title3)
                    .bold()
                    .padding(.top,10)
                    .padding(.leading, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)
                SVGImageView(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!)
                    .frame(width: 220, height: 130)
                    .cornerRadius(10)
            }
            VStack {
                Text("Map")
                    .font(.title3)
                    .bold()
                    .padding(.top,10)
                    .padding(.leading, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)    
            }
            // END CODE MADE IN FIGMA
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Country Detail", displayMode: .inline)
        
    }
}

//#Preview {
//    CountryDetail(country: <#PostCountry#>)
//}

struct CountryDetail_Previews: PreviewProvider {
    static var previews: some View {
        // create an object demo
        let exampleCountry = PostCountry(
            id: 1,
            name: "Country demo",
            image: nil,
            flag: "https://tusmodelos.com/images/placeholder.jpg",
            capital: "Capital demo",
            population: 123456,
            region: "EjemploRegión",
            area: 78910,
            latitude: nil,
            longitude: nil,
            urlMap: nil,
            idRegion: nil,
            languages: [Language(id: 1, language: "Language demo")]
        )
        CountryDetail(country: exampleCountry)
    }
}
