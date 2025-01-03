//
//  UserDetailView.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/12.
//

import SwiftUI
// Presenterを疎結合にするためジェネリクス定義
struct UserDetailView<Presenter: UserDetailPresenterProtocol>: View {
    @State private var imageData: Data?
    @Binding var navigationPath: NavigationPath
    @ObservedObject var presenter: Presenter
    @State private var isModalPresented = false

    var body: some View {
        VStack(spacing: 16) {
            userProfile
            MiddleListTitleView(title: "投稿記事一覧")
            itemsList
        }
        .onAppear(){
            Task {
                try await presenter.fetchItemApi()
                imageData = try await presenter.fetchImageData()
            }
        }
        .onDisappear(){
            Task {
                try await presenter.saveUserData()
            }
        }
        .padding()
        .navigationTitle("ユーザ詳細")
        // モーダル遷移の設定
        .sheet(isPresented: $isModalPresented) {
            if let urlStr = presenter.webViewUrlStr {
                ItemWebModuleFactory.createModule(navigationPath: $navigationPath, diContainer: DIContainer.shared, inputData:urlStr)
            }
        }
        .navigationDestination(for:FollowerAndFolloweeData.self) { data in
                FollowerAndFolloweeModuleFactory.createModule(navigationPath: $navigationPath, diContainer: DIContainer.shared, inputData: data)

        }
    }
    
    private var userProfile: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 4) {
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .shadow(radius: 3)
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 120, height: 120)
                        .overlay(Text("?").foregroundColor(.white))
                }
                
                VStack(alignment: .leading) {
                    Text(presenter.userData.name ?? "Unknown User")
                        .bold()
                        .font(.title)
                    Text("投稿数: \(presenter.userData.itemsCount ?? 0)")
                    HStack {
                        Button(action: {
                            presenter.tapFolloweeButton()
                        }) {
                            Text("following: \(presenter.userData.followeesCount ?? 0)")
                        }
                        .foregroundColor(.stringBlack)
                        
                        Button(action: {
                            presenter.tapFollowerButton()
                        }) {
                            Text("followers: \(presenter.userData.followersCount ?? 0)")
                        }
                        .foregroundColor(.stringBlack)
                        
                    }
                }
                .padding(20)
            }
        }
    }
    
    private var itemsList: some View {
        List(presenter.items, id: \.id) { item in
            Button(action: {
                if let index = presenter.items.firstIndex(where: { $0.id == item.id }) {
                    presenter.didSelectCell(at: IndexPath(row: index, section: 0))
                    isModalPresented = true
                }
            }) {
                UserItemsRow(title: item.title!, updateDay: item.updatedAt!, tags: item.tags!)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .listStyle(PlainListStyle())
    }
    
    
}
