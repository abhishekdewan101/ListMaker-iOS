//
//  AccountScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/9/22.
//

import SwiftUI

struct AccountScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill").font(.system(size: 64.0))
            Text("Abhishek Dewan").font(.headline).padding(.vertical)
            Spacer()
        }
    }
}

struct AccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountScreen()
    }
}
