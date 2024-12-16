//
//  ReviewCard.swift
//  navigation-app
//
//  Created by Juan Cruz Vila on 16/12/2024.
//

import SwiftUI

struct ReviewCard : View {
    
    let review: ApiNetwork.Reviews
    
    var body : some View {
        ZStack {
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    HStack(spacing: 0) {
                        ForEach(UIUtils.shared.getFilledStars(score: review.score), id: \.id) { star in
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
                    Divider()
                        .frame(height: 16)
                        .background(.gray)
                    Text("\(String(format: "%.2f", review.score))")
                       
                    Spacer()
                }
                .font(.system(size: 14))
                .padding(.bottom, 10)
            
                Text(review.message)
                    .font(.system(size: 16))
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
         
                Spacer()
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 36, height: 36)
                  
                    VStack(alignment: .leading) {
                        Text("\(review.user.name) \(review.user.lastName)")
                            .font(.system(size: 18))
                        Text(review.user.email)
                            .font(.system(size: 10))
                    }
                    Spacer()
                }
                

            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
            
        }
        .frame(width: 250)
        .frame(maxHeight: 200)
    }
}


#Preview {
    ReviewCard(review: ApiNetwork.Reviews(
        user: ApiNetwork.User(
            email: "yunagosh@gmail.com", name: "Juan Cruz", lastName: "Vila"
        ), score: 2.4, message: "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Debitis libero qui voluptates facilis in eligendi ducimus nam aut optio minus? Hic beatae quis quaerat sed, deleniti voluptatibus quibusdam eligendi aut repudiandae accusantium illum. Suscipit voluptates quia esse unde tempora deleniti error impedit odio ex omnis sed nisi neque, perferendis, quas reiciendis illum, repellendus magni dolores cupiditate aut. Culpa sed enim iusto nesciunt asperiores aperiam sit distinctio! Reiciendis quisquam asperiores fugit facilis id placeat facere dolore! Maiores nam adipisci, iste voluptatibus esse quam necessitatibus nulla odit iusto illum voluptate veritatis repellendus, autem eveniet optio saepe consequatur dolore corrupti quos facilis architecto non harum! Explicabo dolorem alias illum fuga corporis iste! Veritatis adipisci dicta exercitationem consequuntur perspiciatis culpa dolores eveniet nam perferendis corrupti blanditiis consequatur eligendi iusto soluta, delectus in quidem sequi corporis. Ipsa a voluptatibus doloremque dolorem, temporibus voluptatum minima nesciunt atque laboriosam sequi ea quos quam aperiam porro velit quaerat."
    ))
}
