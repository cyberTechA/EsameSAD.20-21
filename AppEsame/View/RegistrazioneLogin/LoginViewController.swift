//
//  ViewController.swift
//  AppEsame
//
//  Created by alberto urraro on 13/04/21.
//

import UIKit
//import FirebaseDatabase

class LoginViewController: UIViewController {
    
    //    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        database.child("Ciamm fatt").observeSingleEvent(of: .value, with: {snapshot in guard let value = snapshot.value as? [String: Any] else {
        //
        //            return}
        //
        //            print("Valori contenuti nella chiave del databse sono:\(value)")
        //        })
        //
        //
        //        let bottone = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 50))
        //        bottone.setTitle("aggiungi sul database", for: .normal)
        //        bottone.setTitleColor(.white, for: .normal )
        //        bottone.backgroundColor = .link
        //        view.addSubview(bottone)
        //        bottone.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
        
    }
    
    //    @objc private func addNewEntry(){
    //        let oggetto:[String: Any] = [
    //            "nome": "prova upload" as NSObject,
    //            "cognome": "prova"
    //
    //        ]
    //        database.child("fanculo firebase_\(Int.random(in: 0..<100))").setValue(oggetto)
    //
    //        let strunz:[String: Any] = [
    //            "nome": "alberto" as NSObject,
    //            "cognome" : "urraro" ,
    //            "altezza" : "183 cm" ,
    //            "Peso" : "90kg"
    //
    //
    //        ]
    //        database.child("Ciamm fatt").setValue(strunz)
    //
    //
    //    }
    
   
//    SEGUE VIEW PAZIENTE FULL SCREEN
//        let pazienteStoryboard = UIStoryboard(name: "Paziente", bundle: nil)
//        let pazienteViewController = pazienteStoryboard.instantiateViewController(withIdentifier: "PazienteViewController") as! PazienteViewController
//        pazienteViewController.modalPresentationStyle = .fullScreen
//
//        self.present(pazienteViewController, animated: true, completion: nil)
   
//    SEGUE VIEW MEDICO FULL SCREEN
//
//        let medicoStoryboard = UIStoryboard(name: "Medico", bundle: nil)
//        let medicoViewController = medicoStoryboard.instantiateViewController(withIdentifier: "MedicoViewController") as! MedicoViewController
//        medicoViewController.modalPresentationStyle = .fullScreen
//
//        self.present(medicoViewController, animated: true, completion: nil)

    
    @IBAction func segueRegistrazione(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let registrazioneViewController = mainStoryboard.instantiateViewController(withIdentifier: "RegistrazioneViewController") as! RegistrazioneViewController
        registrazioneViewController.modalPresentationStyle = .fullScreen
       
        self.present(registrazioneViewController, animated: true, completion: nil)
    }
    

    
    
    
    
    
    
    
    
    
}

