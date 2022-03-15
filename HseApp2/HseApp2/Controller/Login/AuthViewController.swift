//
//  AuthViewController.swift
//  HseApp2
//
//  Created by Al Stark on 15.03.2022.
//

import UIKit

class AuthViewController: UIViewController {
    var stackView: UIStackView!
    var mailTextField: UITextField!
    var passTextField: UITextField!
    var imageView: UIImageView!
    var enterButton: UIButton!
    var closeButton: UIButton!
    var delegate: LoginViewControllerDelegate!
    var tapGest: UITapGestureRecognizer?
    var service = Service.shared
    var checkField = CheckField.shared
    let userDefault = UserDefaults.standard




    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGest!)
        configCloseButton()
        configImg()
        configPassTextField()
        configMailTextField()
        configStackView()
        ConfigNextButton()
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }

    func configCloseButton(){
        closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.addSubview(closeButton)
        closeButton.setBackgroundImage( UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 30
        ).isActive = true
        closeButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
    }
    
    @objc func closeVC(){
        delegate.closeVC()
    }
    
    func configMailTextField(){
        mailTextField = UITextField()
        mailTextField.backgroundColor = .white
        mailTextField.layer.borderWidth = 2
        mailTextField.layer.cornerRadius = 12
        mailTextField.frame = CGRect(x: 0, y: 0, width: 240, height: 31)
        mailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        mailTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        mailTextField.textAlignment = .left
        mailTextField.keyboardType = .emailAddress
        mailTextField.placeholder = "Введите e-mail"
        mailTextField.keyboardType = UIKeyboardType.emailAddress
    }
    func configPassTextField(){
        passTextField = UITextField()
        passTextField.backgroundColor = .white
        passTextField.layer.borderWidth = 2
        passTextField.layer.cornerRadius = 12
        passTextField.frame = CGRect(x: 0, y: 0, width: 240, height: 31)
        passTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passTextField.textAlignment = .left
        passTextField.placeholder = "Введите пароль"
        passTextField.isSecureTextEntry = true
    }
    
    
    func configStackView(){
        stackView = UIStackView()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(mailTextField)
        stackView.addArrangedSubview(passTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(
            equalTo: imageView.safeAreaLayoutGuide.bottomAnchor,
            constant: 30
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -350).isActive = true
        
    }
    
    func ConfigNextButton(){
        enterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 240, height: 60))
        view.addSubview(enterButton)
        enterButton.setTitle("Войти", for: .normal)
        enterButton.layer.cornerRadius = 12
        enterButton.layer.masksToBounds = true
        enterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        enterButton.backgroundColor = .blue
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        enterButton.topAnchor.constraint(
            equalTo: stackView.safeAreaLayoutGuide.bottomAnchor,
            constant: 30
        ).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        enterButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250).isActive = true
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    @objc func enterButtonPressed(){
        if checkField.validField(mailTextField),
           checkField.validField(passTextField){
            let authData = LoginField(email: mailTextField.text!, password: passTextField.text!)
            
            service.authInApp(authData) { response in
                switch response {
                case .success:
                    print("next")
                    self.userDefault.set(true, forKey: "isLogin")
                    print("go")
                    self.delegate.startApp()
                    self.delegate.closeVC()
                case .noVerify:
                    let alert = self.alertAction("Error", "Вы не подтвердили свою почту. На вашу почту пришло письсмо")
                    let verifybtn = UIAlertAction(title: "Ok", style: .cancel)
                    alert.addAction(verifybtn)
                    self.present(alert, animated: true)

                case .error:
                    let alert = self.alertAction("Error", "Email или пароль не подошли")
                    let verifybtn = UIAlertAction(title: "Ok", style: .cancel)
                    alert.addAction(verifybtn)
                    self.present(alert, animated: true)

                    
                }
            }
            
            
        }
    }
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController{
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    func configImg(){
        imageView = UIImageView()
        let img = UIImage(named: "hselogo")
        imageView.image = img
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 100
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
