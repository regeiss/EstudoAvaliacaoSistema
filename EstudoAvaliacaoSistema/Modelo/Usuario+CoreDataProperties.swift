//
//  Usuario+CoreDataProperties.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 17/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//
//

import Foundation
import CoreData

extension Usuario
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario>
    {
        return NSFetchRequest<Usuario>(entityName: "Usuario")
    }

    @NSManaged public var login: String?
    @NSManaged public var senha: String?
    @NSManaged public var email: String?
    @NSManaged public var logado: Bool
    @NSManaged public var dataCriado: Date?
    @NSManaged public var dataUltimoLogin: Date?
    @NSManaged public var nome: String?
}
