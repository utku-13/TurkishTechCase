//
//  ListView.swift
//  TurkishTechCase
//
//  Created by Utku Özer on 16.09.2025.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        // Burda API den alacagimiz urunler listelenicek
                        ListItemView()
                        ListItemView()
                        Spacer()
                        // Icleri su anda dummy data dolu gorunum icin.
                        
                    }
                    .navigationTitle("Lists")
                }.onAppear{
                    // burda direk viewmodel yardimi ile sayfa yuklenir yuklenmez fetch fonksiyonu calisacak. Ki bos bir sayfa gostermesin baslangicta.
                    
                }
    }
}

#Preview {
    ListView()
}
