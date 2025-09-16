//
//  MainView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            ListView()
                .tabItem {
                    Label("home", systemImage: "house")
                }
            FavouriteView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    MainView()
}
