import SwiftUI

struct FollowerAndFolloweeView<Presenter: FllowerAndFolloweePresenterProtocol>: View {
    @State private var isOn: Bool = true // セグメント選択状態
    @ObservedObject var presenter: Presenter
    init(presenter:Presenter,followerAndFollowee:Bool){
        self.presenter = presenter
        _isOn = State(initialValue: followerAndFollowee)
    }

    var body: some View {
        VStack {
            follwerOrFolloweeSegment
            MiddleListTitleView(title: isOn ? "Follower" : "Followee")
            if isOn {
                followerListView
            } else {
                followeeListView
            }
        }
        .navigationTitle("Follower & Followee")
        .onAppear {
            fetchUsers()
        }
        .onChange(of: isOn) {
            fetchUsers()
        }
    }
    
    
    private var follwerOrFolloweeSegment: some View {
        Picker("", selection: $isOn) {
            Text("Follower")
                .tag(true)
            
            Text("Followee")
                .tag(false)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var followerListView: some View {
        List(presenter.followers, id: \.id) { user in
            Button(action: {
                //                   presenter.didSelectCell(for: user)
            }) {
                SearchedUserRow(
                    userImageData: Data(),
                    userName: user.name ?? "No Name",
                    userFlowerCnt: "\(user.followersCount ?? 0)",
                    userFloweeCnt: "\(user.followeesCount ?? 0)"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .listStyle(PlainListStyle())
    }
    
    private var followeeListView: some View {
        List(presenter.followees, id: \.id) { user in
            Button(action: {
                //                   presenter.didSelectCell(for: user)
            }) {
                SearchedUserRow(
                    userImageData: Data(),
                    userName: user.name ?? "No Name",
                    userFlowerCnt: "\(user.followersCount ?? 0)",
                    userFloweeCnt: "\(user.followeesCount ?? 0)"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .listStyle(PlainListStyle())
    }
    
    private func fetchUsers() {
        Task {
            do {
                if isOn {
                    try await presenter.fetchFollowers()
                } else {
                    try await presenter.fetchFollowees()
                }
            } catch {
                print("Failed to fetch users: \(error)")
            }
        }
    }
}
