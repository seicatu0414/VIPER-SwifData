//
//  ItemWebModuleFactory.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/26.
//

import SwiftUI

// navigationDestinationなどViewでPresenters、Routerのインスタンスを生成すると責務があやふやになってしまう為作成
class ItemWebModuleFactory: ModuleFactoryProtocol {
    
    typealias PresenterType = ItemWebViewPresenter
    typealias ViewType = ItemWebView<ItemWebViewPresenter>
    typealias InputData = String
    
    static func createModule(navigationState: NavigationState,diContainer: DIContainer, inputData: String?) -> ItemWebView<ItemWebViewPresenter> {
        let presenter = ItemWebViewPresenter(urlStr: inputData)
        return ItemWebView<ItemWebViewPresenter> (
            presenter: presenter
        )
    }
    

}
