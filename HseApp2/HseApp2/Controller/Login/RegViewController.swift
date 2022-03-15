//
//  RegViewController.swift
//  HseApp2
//
//  Created by Al Stark on 15.03.2022.
//

import UIKit

class RegViewController: UIViewController {
    
    var stackView: UIStackView!
    var mailTextField: UITextField!
    var passTextField: UITextField!
    var pass2TextField: UITextField!
    var imageView: UIImageView!
    var nextButton: UIButton!
    var closeButton: UIButton!
    var view1: UIView!
    var tapGest: UITapGestureRecognizer?
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var service = Service.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGest!)
        configCloseButton()
        configImg()
        configMailTextField()
        configPassTextField()
        configPass2TextField()
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
        mailTextField.frame = CGRect(x: 0, y: 0, width: 240, height: 31)
        mailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        mailTextField.layer.borderWidth = 2
        mailTextField.layer.cornerRadius = 12
        mailTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        mailTextField.textAlignment = .left
        mailTextField.placeholder = "Введите e-mail"
        mailTextField.keyboardType = UIKeyboardType.emailAddress
        mailTextField.restorationIdentifier = "email"
    }
    func configPassTextField(){
        passTextField = UITextField()
        passTextField.frame = CGRect(x: 0, y: 0, width: 240, height: 31)
        passTextField.layer.borderWidth = 2
        passTextField.layer.cornerRadius = 12
        passTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passTextField.textAlignment = .left
        passTextField.placeholder = "Введите пароль"
        passTextField.restorationIdentifier = "password"
        passTextField.isSecureTextEntry = true
    }
    func configPass2TextField(){
        pass2TextField = UITextField()
        pass2TextField.frame = CGRect(x: 0, y: 0, width: 240, height: 31)
        pass2TextField.layer.borderWidth = 2
        pass2TextField.layer.cornerRadius = 12
        pass2TextField.borderStyle = UITextField.BorderStyle.roundedRect
        pass2TextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        pass2TextField.textAlignment = .left
        pass2TextField.placeholder = "Повторите пароль"
        pass2TextField.restorationIdentifier = "password"
        pass2TextField.isSecureTextEntry = true
    }
    
    func configStackView(){
        stackView = UIStackView()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(mailTextField)
        stackView.addArrangedSubview(passTextField)
        stackView.addArrangedSubview(pass2TextField)
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
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300).isActive = true
        
    }
    
    func ConfigNextButton(){
        nextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 240, height: 60))
        view.addSubview(nextButton)
        nextButton.setTitle("Регистрация", for: .normal)
        nextButton.layer.cornerRadius = 12
        nextButton.layer.masksToBounds = true
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        nextButton.backgroundColor = .blue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(
            equalTo: stackView.safeAreaLayoutGuide.bottomAnchor,
            constant: 30
        ).isActive = true
        nextButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        nextButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        nextButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    @objc func nextButtonPressed(){
        if checkField.validField(mailTextField),
           checkField.validField(passTextField){
            if passTextField.text == pass2TextField.text {
                service.creatNewUser(LoginField(email: mailTextField.text!, password: passTextField.text!)) {[weak self] code in
                    switch code.code {
                    case 0:
                        let alert = self?.alertAction("Error", "Произошла ошибка регистрации")
                        let verifybtn = UIAlertAction(title: "Ok", style: .cancel)
                        alert?.addAction(verifybtn)
                        self?.present(alert!, animated: true)
                    case 1:
                        let alert = self?.alertAction("Error", "Успешно зарегистрировались")
                        let verifybtn = UIAlertAction(title: "Ok", style: .cancel)
                        alert?.addAction(verifybtn)
                        self?.present(alert!, animated: true)
                        self?.service.confirmEmail()
                    default:
                        let alert = self?.alertAction("Error", "Неизвестная ошибка")
                        let verifybtn = UIAlertAction(title: "Ok", style: .cancel)
                        alert?.addAction(verifybtn)
                        self?.present(alert!, animated: true)
                    }
                }
            } else {
                passTextField.backgroundColor = .red
                pass2TextField.backgroundColor = .red
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
