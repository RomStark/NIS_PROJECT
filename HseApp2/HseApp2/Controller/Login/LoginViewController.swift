//
//  LoginViewController.swift
//  HseApp2
//
//  Created by Al Stark on 15.03.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func openRegVC()
    func openEnterVC()
    func closeVC()
    func startApp()
}

class LoginViewController: UIViewController {
    var loginView: UIView!
    var imageView: UIImageView!
    var label: UILabel!
    var regButton: UIButton!
    var enterButton: UIButton!
    var regVC: RegViewController!
    var enterVC: AuthViewController!
    var appVC: AppViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let loginView = LoginView()
//        loginView.loginViewControllerDelegate = self
//        loginView.configEnterButton()
//        loginView.configImg()
//        loginView.configLabel()
//        loginView.configRegButton()
//        view.addSubview(loginView.loginView)
        configImg()
        configLabel()
        configRegButton()
        configEnterButton()
    }

    
    func configRegButton(){
        regButton = UIButton(frame: CGRect(x: 80, y: 500, width: 240, height: 60))
        view.addSubview(regButton)
        regButton.setTitle("Регистрация", for: .normal)
        regButton.layer.cornerRadius = 12
        regButton.layer.masksToBounds = true
        regButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        regButton.backgroundColor = .blue
        regButton.setTitleColor(.white, for: .normal)
        regButton.addTarget(self, action: #selector(regButtonPressed), for: .touchUpInside)
    }
    
    @objc func regButtonPressed(sender: UIButton){
        openRegVC()
    }
    
    func configEnterButton(){
        enterButton = UIButton(frame: CGRect(x: 80, y: 600, width: 240, height: 60))
        view.addSubview(enterButton)
        enterButton.setTitle("Войти", for: .normal)
        enterButton.layer.cornerRadius = 12
        enterButton.layer.masksToBounds = true
        enterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        enterButton.backgroundColor = .blue
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)

    }
    
    @objc func enterButtonPressed(sender: UIButton){
        openEnterVC()
    }


    func configLabel(){
        label = UILabel()
        view.addSubview(label)
        label.text = "HSE Apple"
        label.textColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(
            equalTo: imageView.safeAreaLayoutGuide.bottomAnchor,
            constant: -10
        ).isActive = true
        
        label.trailingAnchor.constraint(
            equalTo: imageView.safeAreaLayoutGuide.centerXAnchor, constant: 55).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive
        = true
        label.widthAnchor.constraint(equalTo:
                                        label.heightAnchor).isActive = true
    }
    func configImg(){
        imageView = UIImageView()
        let img = UIImage(named: "hselogo")
        imageView.image = img
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 150
        ).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -80).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
//        imageView.trailingAnchor.constraint(
//            equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: imageView.bounds.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 160).isActive
        = true
        imageView.widthAnchor.constraint(equalTo:
                                        imageView.heightAnchor).isActive = true

    }
}

extension LoginViewController: LoginViewControllerDelegate  {
    func startApp() {
        if appVC == nil {
            appVC = AppViewController()
        }
        let navVC = UINavigationController(rootViewController: appVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.isNavigationBarHidden = true
        appVC.delegate = self
        present(navVC, animated: true)
    }
    
    func closeVC() {
        if enterVC != nil {
            enterVC.dismiss(animated: true, completion: nil)
            enterVC = nil
        }
        if regVC != nil {
            regVC.dismiss(animated: true, completion: nil)
            regVC = nil
        }
    }
    
    func openEnterVC() {
        if enterVC == nil {
            enterVC = AuthViewController()
        }
        let navVC = UINavigationController(rootViewController: enterVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.isNavigationBarHidden = true
        enterVC.delegate = self
        present(navVC, animated: true)
    }
    
    func openRegVC() {
        if regVC == nil {
            regVC = RegViewController()
        }
        let navVC = UINavigationController(rootViewController: regVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.isNavigationBarHidden = true
        regVC.delegate = self
        present(navVC, animated: true)    }
}
