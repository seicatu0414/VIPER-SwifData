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
        }
        .padding()
        .navigationTitle("ユーザ詳細")
    }
}
