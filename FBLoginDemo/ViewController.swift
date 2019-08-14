import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {

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

        loginBtn.delegate = self

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
        loadCurrentProfile()
    }

    private func loadCurrentProfile() {
        Profile.loadCurrentProfile { (profile, error) in
            guard let currentProfile = profile else { return }
            let userid = currentProfile.userID
            let name = currentProfile.name
            self.profilePictureView.profileID = userid
            self.userDatailsLabel.text = name
        }
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        loadCurrentProfile()
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        profilePictureView.profileID = ""
        userDatailsLabel.text = ""
    }
}
