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
    @EnvironmentObject var movieVM: MovieViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ZStack{
                    if !movieVM.isLoad{
                            WebView(url: "https://www.youtube.com/embed/\(movieVM.movieURL)")
                    } else {
                        if !movieVM.errorReceivingVideo{
                            ProgressView()
                        } else {
                            Text("The video is currently unavailable or missing")
                                .font(.system(size: 18))
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(uiColor: .label).opacity(0.05).blur(radius: 5))
                        }
                    }
                    
                }
                .frame(height: 250)
                .padding(.bottom, 20)
                VStack(spacing: 50){
                    VStack(alignment: .leading, spacing: 15){
                        Text(model.original_name ?? model.original_title ?? "Unknown")
                            .font(.system(size: 22, weight: .bold))
                        Text(model.overview ?? "No overview")
                            .font(.system(size: 18, weight: .regular))
                            .lineLimit(nil)
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
                    .padding(.bottom, 20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(uiColor: .systemBackground))
        }
    }
}

struct WebView: UIViewRepresentable{
    var url: String
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        if let requestUrl = URL(string: url) {
            uiView.load(URLRequest(url: requestUrl))
        }
        
    }
}

