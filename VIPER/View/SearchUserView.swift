//
//  ContentView.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//
import SwiftUI
import SwiftData

struct SearchUserView: View {
    @Binding var navigationPath: NavigationPath
    @ObservedObject var presenter: SearchUserPresenter
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                searchBar
                userList
            }
            .navigationTitle("ユーザ検索")
            .navigationDestination(for: SearchUser.self) { user in
                UserDetailView(userData: user)
            }
        }
    }

    // サブビュー: 検索バー
    private var searchBar: some View {
        HStack {
            TextField("ユーザIDを入力", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: {
                presenter.didTapButton(userIDStr: searchText)
            }) {
                Text("検索")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.qiitaDarkGreen)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding(.top)
    }

    // サブビュー: ユーザリスト
    private var userList: some View {
        List(presenter.users, id: \.id) { user in
            Button(action: {
                if let index = presenter.users.firstIndex(where: { $0.id == user.id }) {
                    presenter.didSelectCell(at: IndexPath(row: index, section: 0))
                }
            }) {
                SearchedUserRow(
                    userImageData: user.profileImageData!,
                    userName: user.name ?? "No Name",
                    userFlowerCnt: "\(user.followersCount ?? 0)",
                    userFloweeCnt: "\(user.followeesCount ?? 0)"
                )
            }
        }
    }
}


//#Preview {
//    // プレゼンターのダミーデータを注入
//    let dummyPresenter = SearchUserPresenter(
//        apiInteractor: DummyAPIInteractor(),
//        swiftDataInteractor: DummySwiftDataInteractor(),
//        router: DummyRouter()
//    )
//    
//    SearchUserView(presenter: dummyPresenter)
//        .modelContainer(for: LookedUser.self, inMemory: true)
//}
