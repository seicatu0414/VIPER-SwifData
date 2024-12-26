//
//  ItemWebViewPresenter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/26.
//

import Foundation

protocol ItemWebViewPresenterProtocol:ObservableObject {
    var urlStr: String? { get }
}

class ItemWebViewPresenter: ItemWebViewPresenterProtocol {
    var urlStr: String?
    
    init(urlStr: String?) {
        self.urlStr = urlStr
    }
    
}
