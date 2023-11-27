//
//  Hero.swift
//  Little Lemon
//
//  Created by Jeff Heppert on 11/27/23.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.largeTitle)
                .foregroundStyle(Color("brandYellow"))
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Chicago")
                        .font(.title)
                    Text("This is a description of the whole application")
                        .font(.callout)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                Spacer()
                Image("restaurantImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 10)))
            }
            .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    Hero()
}
