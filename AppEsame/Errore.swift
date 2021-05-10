//
//  Errore.swift
//  AppEsame
//
//  Created by Carlo D'Avino on 11/05/21.
//

import Foundation


//Possiamo utilizzare questa classe per  gestire gli errori nei vari eventi che andremo a codificare. Oltre a restituire true in presenz di errore
//specifichiamo anche il tipo di errore nel campo descrizione
class Errore{
    var errore: Bool
    var descrizione: String
    
    
    //Costruttore
    init(errore: Bool, descrizione: String){
        self.errore = errore
        self.descrizione = descrizione
    }
    
    //Funzioni set
    func setErrore(errore: Bool){self.errore = errore}
    func setDescrizione(descrizione: String){self.descrizione = descrizione}
    
    //Funzioni get
    func getErrore()->Bool{return self.errore}
    func getDescrizione()->String{return self.descrizione}
}
