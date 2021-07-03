//
//  File.swift
//  AppEsame
//
//  Created by Carlo D'Avino on 14/05/21.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class MedicoDB{
    
    let db = DBManager.shared.db
    
    init(){}
    
    func creaMedico(medico: Medico){
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db!.collection("utente").addDocument(data: [
            "uid": medico.getUid(),
            "nome": medico.getNome(),
            "cognome": medico.getCognome(),
            "dataNascita": medico.getDataNascita(),
            "codiceFiscale": medico.getCodiceFiscale(),
            "telefono": medico.getTelefono(),
            "email": medico.getEmail(),
            "tipo": medico.getTipo(),
            "password": medico.getPassword(),
            "specializzazioni": medico.getSpecializzazioni(),
            "indirizzo": medico.getIndirizzo(),
            "citta": medico.getCitta(),
            "cap": medico.getCap(),
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func ottieniMedicoDaEmail(emailDaCercare: String, finished: @escaping([Medico]?) -> Void) {
        db!.collection("utente").whereField("email", isEqualTo: emailDaCercare).getDocuments() { (queryResult, err) in
            guard let result = queryResult?.documents else {
                print("No documents")
                return
            }
            
            let medici = result.map{ (queryResult) -> Medico in
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
                let specializzazioni = data["specializzazioni"] as? [String] ?? []
                let indirizzo = data["indirizzo"] as? String ?? ""
                let citta = data["citta"] as? String ?? ""
                let cap = data["cap"] as? String ?? ""
                
                let medico = Medico(id: id, uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, specializzazioni: specializzazioni, indirizzo: indirizzo, citta: citta, cap: cap)
                
                return medico
                
            }
            finished(medici)
        }
    }
    
    func ottieniMedicoDaId(idDaCercare: String, finished: @escaping([Medico]?) -> Void) {
        db!.collection("utente").document(idDaCercare).getDocument { (queryResult, err) in
            guard let result = queryResult?.data() else {
                print("No documents")
                return
            }
            
            let medici = result.map{ (queryResult) -> Medico in
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
                let specializzazioni = data["specializzazioni"] as? [String] ?? []
                let indirizzo = data["indirizzo"] as? String ?? ""
                let citta = data["citta"] as? String ?? ""
                let cap = data["cap"] as? String ?? ""
                
                let medico = Medico(id: id,uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, specializzazioni: specializzazioni, indirizzo: indirizzo, citta: citta, cap: cap)
                
                return medico
                
            }
            finished(medici)
        }
    }
    
    
    func ottieniTuttiMedici(finished: @escaping([Medico]?) -> Void) {
        db!.collection("utente").whereField("tipo", isEqualTo: "Medico").getDocuments() { (queryResult, err) in
            guard let result = queryResult?.documents else {
                print("No documents")
                return
            }
            
            let medici = result.map{ (queryResult) -> Medico in
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
                let specializzazioni = data["specializzazioni"] as? [String] ?? []
                let indirizzo = data["indirizzo"] as? String ?? ""
                let citta = data["citta"] as? String ?? ""
                let cap = data["cap"] as? String ?? ""
                
                let medico = Medico(id: id,uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, specializzazioni: specializzazioni, indirizzo: indirizzo, citta: citta, cap: cap)
                
                return medico
                
            }
            finished(medici)
        }
    }
    
    func ottieniMedicoDaUid(uidDaCercare: String, finished: @escaping([Medico]?) -> Void) {
        db!.collection("utente").whereField("uid", isEqualTo: uidDaCercare).getDocuments() { (queryResult, err) in
            guard let result = queryResult?.documents else {
                print("No documents")
                return
            }
            
            let medici = result.map{ (queryResult) -> Medico in
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
                let specializzazioni = data["specializzazioni"] as? [String] ?? []
                let indirizzo = data["indirizzo"] as? String ?? ""
                let citta = data["citta"] as? String ?? ""
                let cap = data["cap"] as? String ?? ""
                
                let medico = Medico(id: id, uid: uid, nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, specializzazioni: specializzazioni, indirizzo: indirizzo, citta: citta, cap: cap)
                
                return medico
                
            }
            finished(medici)
        }
    }
    
}
