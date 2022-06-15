//
//  SplashScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/14/22.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            Text("ListMaker").font(.largeTitle).fontWeight(.bold)
            ProgressView().padding(.top)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

