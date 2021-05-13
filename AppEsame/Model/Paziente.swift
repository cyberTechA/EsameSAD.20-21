//
//  Paziente.swift
//  AppEsame
//
//  Created by Anna on 10/05/2021.
//

import Foundation

class Paziente: Utente{
    //Dichiarazione variabili
    var allergie: [String]!
    var patologie: [String]!
    
    //variabile entità DB
    var pazienteDB = PazienteDB()
    
    //Costruttore
    init(nome: String, cognome: String, dataNascita: String, codiceFiscale: String, telefono: String, email: String, tipo: String, password: String, allergie: [String], patologie: [String]) {
        self.allergie = allergie
        self.patologie = patologie
        super.init(nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password)
    }
    
    //Funzioni set
    func setAllergia(allergie: [String]){self.allergie = allergie}
    func setPatologie(patologie: [String]){self.patologie = patologie}
    
    //Funzioni get
    func getAllergie()->[String]{return self.allergie}
    func getPatologie()->[String]{return self.patologie}
    
    func creaPaziente(){
        pazienteDB.creaPaziente(paziente: self)
    }
    
    func ottieniPazienteDaEmail(emailDaCercare: String, finished: @escaping([Paziente]?) -> Void) {
        
        pazienteDB.ottieniPazienteDaEmail(emailDaCercare: emailDaCercare){(pazienti) in
            
            guard let pazientiRes = pazienti else {
                print("error")
                return
            }
            let pazientiArr = pazientiRes.map{(res) ->Paziente in
                
                let nome = res.nome
                let cognome = res.cognome
                let dataNascita = res.dataNascita
                let codiceFiscale = res.codiceFiscale
                let telefono = res.telefono
                let email = res.email
                let tipo = res.tipo
                let password = res.password
                let allergie = res.allergie ?? []
                let patologie = res.patologie ?? []
                
                
                let paziente = Paziente(nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, allergie: allergie, patologie: patologie)
                
                return paziente
                
            }
            finished(pazientiArr)
        }
    }
    
    func ottieniPazienteDaId(idDaCercare: String, finished: @escaping(Paziente?) -> Void) {
        
        pazienteDB.ottieniPazienteDaId(idDaCercare: idDaCercare){(pazienti) in
            
            guard let pazientiRes = pazienti else {
                print("error")
                return
            }
                let  res = pazientiRes[0] //Ottengo sempre un risultato unico perchè l'id è univoco
                let nome = res.nome
                let cognome = res.cognome 
                let dataNascita = res.dataNascita 
                let codiceFiscale = res.codiceFiscale 
                let telefono = res.telefono 
                let email = res.email 
                let tipo = res.tipo 
                let password = res.password 
                let allergie = res.allergie ?? []
                let patologie = res.patologie ?? []

                
                
                let paziente = Paziente(nome: nome, cognome: cognome, dataNascita: dataNascita, codiceFiscale: codiceFiscale, telefono: telefono, email: email, tipo: tipo, password: password, allergie: allergie, patologie: patologie)
                
                
//            }
            finished(paziente)
        }
    }
    
}
