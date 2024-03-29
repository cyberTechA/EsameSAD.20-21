//
//  ViewController.swift
//  AppEsame
//
//  Created by alberto urraro on 13/04/21.
//

import UIKit
//import FirebaseDatabase
import LocalAuthentication
import FirebaseUI
import GoogleSignIn


class LoginViewController: UIViewController, UITextFieldDelegate, FUIAuthDelegate {
        
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var accedi: UIButton!
    @IBOutlet weak var loginFaceId: UIButton!
    
    @IBOutlet weak var Googlebutton: GIDSignInButton!
    
    
    
    //per FaceId
    var context = LAContext()
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        
        self.email.delegate = self
        self.password.delegate = self
        
        email.delegate = self
        email.tag = 0
        password.delegate = self
        password.tag = 1
        
        //Curva bottone
        accedi.layer.cornerRadius = 10
        
        //Apro connessione al db
        DBManager.shared.openConnection()
        
        loginFaceId.isHidden = true
        DBManager.shared.getUserDefaultUtenteLoggato()
        if(DBManager.shared.id != ""){
            loginFaceId.isHidden = false
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    @IBAction func entracongoogle(_ sender: GIDSignInButton) {
        let errore = LoginViewModel.validaLogin(email: self.email.text!, password: self.password.text!)
        
        if(errore.getErrore()){
            //Popup di errore
            let alertLogin = UIAlertController(title: "Errore", message: errore.getDescrizione(), preferredStyle: UIAlertController.Style.alert)
            alertLogin.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (act) in
                //Eventuale azione
            }))
            self.present(alertLogin,animated: true, completion: nil)
        } else {
            print("Accedo all'app")
            //            performSegue(withIdentifier: "LoginPaziente", sender: self)
            self.appLogin(email: self.email.text!, password: self.password.text!)

        
        }
        
        
    }
    
    
    @IBAction func accedi(_ sender: Any) {
        let errore = LoginViewModel.validaLogin(email: self.email.text!, password: self.password.text!)
        
        if(errore.getErrore()){
            //Popup di errore
            let alertLogin = UIAlertController(title: "Errore", message: errore.getDescrizione(), preferredStyle: UIAlertController.Style.alert)
            alertLogin.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (act) in
                //Eventuale azione
            }))
            self.present(alertLogin,animated: true, completion: nil)
        } else {
            print("Accedo all'app")
            //            performSegue(withIdentifier: "LoginPaziente", sender: self)
            self.appLogin(email: self.email.text!, password: self.password.text!)

        
        }
    }
    
    

    
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
            if let user = authDataResult?.user{
                print("Loggato uid \(user.uid) email \(user.email ?? "")")
            }
    }
    
    @IBAction func segueRegistrazione(_ sender: Any) {
        
        performSegue(withIdentifier: "SegueStep1Registrazione", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Fa sparire la barra del navigation ogni volta che viene caricato
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Fa apparire la barra del navigation quando si esce dal controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        //Fa abbassare la view verso il basso se pongo uguale a false, mentre uguale a true è come se nn lo mettessi
        //self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func appLogin(email: String, password: String){
        
        LoginViewModel.appLogin(view: self, email: email, password: password, this: self)
    }
    
    @IBAction func loginFaceID(_ sender: Any) {
        
        context = LAContext()
        
        context.localizedCancelTitle = "Enter Username/Password"
        
        // First check if we have the needed hardware support.
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                
                if success {
                    
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        if(DBManager.shared.tipo == "Paziente"){
                            self.performSegue(withIdentifier: "LoginPaziente", sender: self)
                        } else if(DBManager.shared.tipo == "Medico"){
                            self.performSegue(withIdentifier: "LoginMedico", sender: self)
                        }
                        
                    }
                } else {
                    print(error?.localizedDescription ?? "Autenticazione fallita")
                    
                }
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            
            // Fall back to a asking for username and password.
            // ...
        }
    }
    
    //Queste due funzioni servono a fare il dismis keyboard quando si tocca fuori dal text field in uso o se si clicca invio
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func PassDimenticata_click(_ sender: UIButton) {
          
            //Creo un UIAlertController che mi chiede l'email dell'account dell'user che ha dimenticato la password
                    let forgotPasswordAlert = UIAlertController(title: "Hai dimenticato la password?", message: "Inserisci la tua email", preferredStyle: .alert)
                    forgotPasswordAlert.addTextField { (textField) in
                        textField.placeholder = "Inserire l'email"
                    }
                    //Aggiungo dei bottoni e quindi delle azione all'UIAlertController
                    forgotPasswordAlert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
                    forgotPasswordAlert.addAction(UIAlertAction(title: "Ripristina password", style: .default, handler: { (action) in
                        /* Potrei usare l'email nel text field senza inserirla nel UIAlertController, quindi eliminando forgotPasswordAlert.addTextField e utilizzando
                         let resetEmail = self.emailTextField.text al posto del codice della riga successiva, cioè prendo l'email dal textfield dove inserisco l'email per registrarmi e per accedere e non quella che inserisco nel UIAlertController */
                        let resetEmail = forgotPasswordAlert.textFields?.first?.text
                        Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                            DispatchQueue.main.async {
                                if let error = error {
                                    let resetFailedAlert = UIAlertController(title: "Ripristino fallito", message: error.localizedDescription, preferredStyle: .alert)
                                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(resetFailedAlert, animated: true, completion: nil)
                                } else {
                                    let resetEmailSentAlert = UIAlertController(title: "Ripristino avvenuto con successo", message: "Cerca tra le tue email", preferredStyle: .alert)
                                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                                }
                            }
                        })
                    }))
                    //Avviso presente
                    self.present(forgotPasswordAlert, animated: true, completion: nil)
                    
        }
        
        
    }

    
    
    
    
    



