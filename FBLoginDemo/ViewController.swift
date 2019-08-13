import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    lazy var loginBtn: FBLoginButton = {
        let loginBtn = FBLoginButton(type: .custom)
        loginBtn.permissions = ["email"];
        return loginBtn
    }()

    lazy var profilePictureView: FBProfilePictureView = {
        let profilePictureView = FBProfilePictureView()
        profilePictureView.pictureMode = .square
        return profilePictureView
    }()

    lazy var userDatailsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchData()
    }

    func setupUI() {
        loginBtn.center = view.center
        view.addSubview(loginBtn)
        view.addSubview(profilePictureView)
        view.addSubview(userDatailsLabel)

        profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        profilePictureView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profilePictureView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profilePictureView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePictureView.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20).isActive = true

        userDatailsLabel.translatesAutoresizingMaskIntoConstraints = false
        userDatailsLabel.topAnchor.constraint(equalTo: profilePictureView.bottomAnchor, constant: 20).isActive = true
        userDatailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userDatailsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }

    func fetchData() {
        guard let profile = Profile.current else { return }

        let userid = profile.userID
        let name = profile.name
        userDatailsLabel.text = "\(userid)\n\(name)"

        let access = AccessToken.current
        profilePictureView.profileID = access?.userID ?? ""
        print(profilePictureView.profileID)
    }
}
