//
//  UserDetailView.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/12.
//

import SwiftUI

struct UserDetailView<Presenter: UserDetailPresenterProtocol>: View {
    @Binding var navigationPath: NavigationPath
    @ObservedObject var presenter: Presenter
    
    var body: some View {
        VStack(spacing: 16) {
//            if let imageData = userData.followeesCount,
//               let uiImage = UIImage(data: imageData) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//            } else {
//                Image(systemName: "person.circle")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                    .foregroundColor(.gray)
//            }
//            Text(userData.name ?? "No Name")
//                .font(.title)
//                .fontWeight(.bold)
//            
//            Text("Followers: \(userData.followersCount ?? 0)")
//            Text("Following: \(userData.followeesCount ?? 0)")
            detailList
        }
        .onDisappear(){
            Task {
               try await presenter.saveUserData(imageData:Data())
            }

        }
        .padding()
        .navigationTitle("ユーザ詳細")
    }
    
    private var detailList: some View {
        List(presenter.items, id: \.id) { item in
            Button(action: {
                if let index = presenter.items.firstIndex(where: { $0.id == item.id }) {
                    presenter.didSelectCell(at: IndexPath(row: index, section: 0))
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
