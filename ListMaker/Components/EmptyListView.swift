//
//  EmptyListScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/17/22.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack {
            Image(systemName: "binoculars")
                .font(.system(size: 24.0))
                .foregroundColor(.black)
                .padding(20)
                .background(Color.white)
                .clipShape(Circle())
            Text("Your list is empty").font(.title3).padding(.top)
        }
    }
}
