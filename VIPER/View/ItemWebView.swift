//
//  ItemWebView.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/26.
//

import WebKit
import SwiftUI

struct ItemWebView<Presenter: ItemWebViewPresenterProtocol>: View {
    @ObservedObject var presenter: Presenter

    var body: some View {
        VStack {
            WebView(url: URL(string: presenter.urlStr!)!)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
