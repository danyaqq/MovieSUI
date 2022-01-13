//
//  HomeHeaderView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI

extension HomeView{
    var headerView: some View{
        Image("poster")
            .resizable()
            .frame(height: 450)
            .overlay(
                LinearGradient(colors: [Color(uiColor: UIColor.clear), Color(uiColor: UIColor.black)], startPoint: .top, endPoint: .bottom)
            )
            .overlay(
                VStack(spacing: 20){
                    
                    Button {} label: {
                        Text("Play")
                            .modifier(
                                CustomButtonModifier(borderColor: .white, backgroundColor: .clear)
                            )
                    }
                    Button {} label: {
                        Text("Download")
                            .modifier(
                                CustomButtonModifier(borderColor: Color(uiColor: UIColor.red), backgroundColor: Color(uiColor: UIColor.red))
                            )
                    }
                    
                    
                }
                    .padding(.bottom, 50),
                alignment: .bottom
            )
    }
}
