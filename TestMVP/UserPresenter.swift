
import Foundation

struct UserViewData{
    
    let name: String
    let age: String
}

protocol UserView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setUsers(users: [UserViewData])
    func setEmptyUsers()
}

class UserPresenter {
    private let userService:UserService
    weak private var userView : UserView?
    
    init(userService:UserService){
        self.userService = userService
    }
    
    func attachView(view:UserView){
        userView = view
    }
    
    func detachView() {
        userView = nil
    }
    
    func getUsers(){
        self.userView?.startLoading()
        userService.getUsers{ [weak self] users in
            self?.userView?.finishLoading()
            if(users.count == 0){
                self?.userView?.setEmptyUsers()
            }else{
                let mappedUsers = users.map{
                    return UserViewData(name: "\($0.firstName) \($0.lastName)", age: "\($0.age) years")
                }
                self?.userView?.setUsers(mappedUsers)
            }
            
        }
    }
}