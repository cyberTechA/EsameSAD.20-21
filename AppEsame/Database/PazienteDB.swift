//
//  UtenteDB.swift
//  AppEsame
//
//  Created by Carlo D'Avino on 13/05/21.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class PazienteDB: UtenteDB{
    
    
    //Dichiarazione variabili
    var allergie: [String]!
    var patologie: [String]!
    
    
    //Costruttore
    init(id: String,uid: String, nome: String, cognome: String, dataNascita: String, codiceFiscale: String, telefono: String, email: String, tipo: String, password: String, allergie: [String], patologie: [String], indirizzo: String, citta: String, cap: String) {
        self.allergie = allergie
        self.patologie = patologie
        super.init(id: id,uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, indirizzo: indirizzo, citta: citta, cap: cap)
    }
    
    //Costruttore vuoto
    override init(){
        super.init()
    }
    
    //Funzioni set
    func setAllergia(allergie: [String]){self.allergie = allergie}
    func setPatologie(patologie: [String]){self.patologie = patologie}
    
    //Funzioni get
    func getAllergie()->[String]{return self.allergie}
    func getPatologie()->[String]{return self.patologie}
    
    func creaPaziente(pazienteDb: PazienteDB)->String{
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db!.collection("utente").addDocument(data: [
            "uid": pazienteDb.getUid(),
            "nome": pazienteDb.getNome(),
            "cognome": pazienteDb.getCognome(),
            "dataNascita": pazienteDb.getDataNascita(),
            "codiceFiscale": pazienteDb.getCodiceFiscale(),
            "telefono": pazienteDb.getTelefono(),
            "email": pazienteDb.getEmail(),
            "tipo": pazienteDb.getTipo(),
            "password": pazienteDb.getPassword(),
            "allergie": pazienteDb.getAllergie(),
            "patologie": pazienteDb.getPatologie(),
            "indirizzo": pazienteDb.getIndirizzo(),
            "citta": pazienteDb.getCitta(),
            "cap": pazienteDb.getCap(),
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                
            }
            
        }
        return ref!.documentID
    }
    
    func ottieniPazienteDaEmail(emailDaCercare: String, finished: @escaping([PazienteDB]?) -> Void) {
        db!.collection("utente").whereField("email", isEqualTo: emailDaCercare).getDocuments() { (queryResult, err) in
            guard let result = queryResult?.documents else {
                print("No documents")
                return
            }
            
            let pazienti = result.map{ (queryResult) -> PazienteDB in
                let data = queryResult.data()
                
                let id = queryResult.documentID
                let uid = data["uid"] as? String ?? ""
                let nome = data["nome"] as? String ?? ""
                let cognome = data["cognome"] as? String ?? ""
                let dataNascita = data["dataNascita"] as? String ?? ""
                let codiceFiscale = data["codiceFiscale"] as? String ?? ""
                let telefono = data["telefono"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let tipo = data["tipo"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let allergie = data["allergie"] as? [String] ?? []
                let patologie = data["patologie"] as? [String] ?? []
                let indirizzo = data["indirizzo"] as? String ?? ""
                let citta = data["citta"] as? String ?? ""
                let cap = data["cap"] as? String ?? ""
                
                let paziente = PazienteDB(id: id,uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, allergie: allergie, patologie: patologie, indirizzo: indirizzo, citta: citta, cap: cap)
                
                return paziente
                
            }
            finished(pazienti)
        }
    }
    
    func ottieniPazienteDaId(idDaCercare: String, finished: @escaping([PazienteDB]?) -> Void) {
        db!.collection("utente").document(idDaCercare).getDocument { (queryResult, err) in
            guard let result = queryResult?.data() else {
                print("No documents")
                return
            }
            
            let pazienti = result.map{ (queryResult) -> PazienteDB in
                let data = result
                
                let id = idDaCercare
                let uid = data["uid"] as? String ?? ""
                let nome = data["nome"] as? String ?? ""
                let cognome = data["cognome"] as? String ?? ""
                let dataNascita = data["dataNascita"] as? String ?? ""
                let codiceFiscale = data["codiceFiscale"] as? String ?? ""
                let telefono = data["telefono"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let tipo = data["tipo"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let allergie = data["allergie"] as? [String] ?? []
                let patologie = data["patologie"] as? [String] ?? []
                let indirizzo = data["indirizzo"] as? String ?? ""
                let citta = data["citta"] as? String ?? ""
                let cap = data["cap"] as? String ?? ""
                
                let paziente = PazienteDB(id: id,uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, allergie: allergie, patologie: patologie, indirizzo: indirizzo, citta: citta, cap: cap)
                
                return paziente
                
            }
            finished(pazienti)
        }
    }
    
    func ottieniPazienteDaUid(uidDaCercare: String, finished: @escaping([PazienteDB]?) -> Void) {
        db!.collection("utente").whereField("uid", isEqualTo: uidDaCercare).getDocuments() { (queryResult, err) in
            guard let result = queryResult?.documents else {
                print("No documents")
                return
            }
            
            let pazienti = result.map{ (queryResult) -> PazienteDB in
                let data = queryResult.data()
                
                let id = queryResult.documentID
                let uid = data["uid"] as? String ?? ""
                let nome = data["nome"] as? String ?? ""
                let cognome = data["cognome"] as? String ?? ""
                let dataNascita = data["dataNascita"] as? String ?? ""
                let codiceFiscale = data["codiceFiscale"] as? String ?? ""
                let telefono = data["telefono"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let tipo = data["tipo"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let allergie = data["allergie"] as? [String] ?? []
                let patologie = data["patologie"] as? [String] ?? []
                let indirizzo = data["indirizzo"] as? String ?? ""
                let citta = data["citta"] as? String ?? ""
                let cap = data["cap"] as? String ?? ""
                
                let paziente = PazienteDB(id: id,uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, allergie: allergie, patologie: patologie, indirizzo: indirizzo, citta: citta, cap: cap)
                
                return paziente
                
            }
            finished(pazienti)
        }
    }
    
    
}
