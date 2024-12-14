//
//  PlaceCard.swift
//  navigation-app
//
//  Created by Juan Cruz Vila on 13/12/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlaceCard : View {
    let place: ApiNetwork.Place
    
    var body: some View {
        
        VStack {
            WebImage(url: URL(string: place.mainImage))
                .resizable()
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame( alignment: .center)
            
            HStack(alignment: .top) {
                Text(place.name)
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                   
                
                Spacer()
                HStack {
                    
                    HStack {
                        Image(systemName: "star.fill")
                        
                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .foregroundColor(.orange)
                    
                    Text("\(String(format: "%.2f", place.score))")
                        .foregroundColor(.orange)
                        .font(.system(size: 12))
                }
                
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
         
            
            
            Text(place.description)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
              
            HStack {
                Spacer()
                Image(systemName: "heart")
                
            }
            .foregroundColor(.gray)
           
        }
        .padding()
        .background(Rectangle().foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 15)
        )
        
        
        
        
        
    }
    
}

#Preview {
    PlaceCard(place:
                ApiNetwork.Place(id: "1", name: "Item", score: 3.5, description: "The best place in the world", mainImage: "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcSzKCIt4FlJhxl4gY6KPMXXM4ZWWLTVKtaX_Va7BLpchkp-UArCT5U-nYGN772rVw8OJ3tzJhnSNgi3OZLykUcfu7pyhd9rd-LSfUWaag", images: [], reviews: [])
    )
}
