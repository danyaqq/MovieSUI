//
//  DetailMovieView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI
import WebKit

struct DetailMovieView: View {
    var model: Movie
    var url: String
    var body: some View {
        VStack{
            WebView(url: "https://www.youtube.com/embed/\(url)")
                .frame(height: 250)
                .padding(.bottom, 20)
            VStack(spacing: 50){
                VStack(alignment: .leading, spacing: 15){
                    Text(model.original_name ?? model.original_title ?? "Unknown")
                        .font(.system(size: 22, weight: .bold))
                    Text(model.overview ?? "No overview")
                        .font(.system(size: 18, weight: .regular))
                }
                .lineLimit(10)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                Button {} label: {
                    Text("Download")
                        .modifier(
                            CustomButtonModifier(borderColor: Color(uiColor: UIColor.red), backgroundColor: Color(uiColor: UIColor.red))
                        )
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(uiColor: .systemBackground))
    }
}

struct WebView: UIViewRepresentable{
    var url: String
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.configuration.urlSchemeHandler(forURLScheme: "")
    }
}

