//
//  PlaceDetails.swift
//  navigation-app
//
//  Created by Juan Cruz Vila on 13/12/2024.
//

import SwiftUI

import SDWebImageSwiftUI



struct PlaceDetails: View {
    @Environment(\.dismiss) var dismiss
    
    @State var detailedPlace: ApiNetwork.Place? = nil
    
    let previewPlace: ApiNetwork.PreviewPlace
    
    
    
    var body: some View {
            
            VStack(spacing: 0) {
                
                WebImage(url: URL(string: previewPlace.mainImage))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(height: 250)
                
                VStack {
                    Text(previewPlace.name)
                        .bold()
                        .font(.system(size: 32))
                        .padding(.bottom, 8)
                    
                    Text(previewPlace.description)
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    
                    Spacer()
                        .frame(height: 40)
                    ZStack {
                        Rectangle()
                            .frame(height: 70)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.lightGray, lineWidth: 2)
                            )
                        HStack {
                            
                            Spacer()
                            VStack {
                                Text("\(String(format: "%.2f", previewPlace.score))")
                                
                                HStack(spacing: 0) {
                                    ForEach(UIUtils.shared.getFilledStars(score: previewPlace.score), id: \.id) { star in
                                        switch star.state {
                                        case .filled:
                                            Image(systemName: "star.fill")
                                        case .half:
                                            Image(systemName: "star.lefthalf.fill")
                                        case .empty:
                                            Image(systemName: "star")
                                                .foregroundColor(.gray)
                                        }
                                        
                                    }
                                }
                                .font(.system(size: 16))
                            }
                            Spacer()
                            Divider()
                                .frame(height: 50)
                                .background(.gray)
                            Spacer()
                            Text("\(detailedPlace?.reviews.count ?? 0) reviews")
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        
                    }
                }
                .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 16))
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(detailedPlace?.reviews ?? [], id: \.id) {review in
                            ReviewCard(review: review)
                        }
                    }
                    .listStyle(.plain)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                .scrollTargetLayout()
                    
               
              
                Spacer()
            }
      
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            dismiss()
        }) {
            
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
                .frame(width: 32, height: 32)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        })
        .task {
            do {
                detailedPlace = try await ApiNetwork().getPlaceById(id: previewPlace.id)
            } catch  {
                print("Error fetching data \(error)")
            }
        }
    }
    
    
    
}



#Preview {
    PlaceDetails(previewPlace: ApiNetwork.PreviewPlace( id: "1", name: "Iguazu Falls", score: 4.5, mainImage: "https://cdn.prod.website-files.com/5efa2cf76690196c83784c64/66b3ddf7d2f5eff760ed7419_66b3dd7fe04c15538bc05acb_Iguazu%2520Gargamta%2520del%2520Diablo.jpeg", description: "This chain of gigantic waterfalls set amongst a teeming rainforest in northern Argentina is one of the world’s most beautiful natural wonders. Nothing can prepare you for the power and noise of the towering cascades." )
                 
    )
}
