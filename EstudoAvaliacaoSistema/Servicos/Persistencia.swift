//
//  Persistencia.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 17/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import Foundation
import CoreData

class Persistencia
{
    // MARK: - Core Data stack

    private init() {}
    static var context: NSManagedObjectContext
    {
        persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EstudoAvaliacaoSistema")
        container.loadPersistentStores(completionHandler:
            { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Erro desconhecido \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    static func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do
            {
                try context.save()
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Erro desconhecido \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func delete(_ object: NSManagedObject)
    {
        context.delete(object)
        do
        {
            try context.save()
        }
        catch
        {
            let nserror = error as NSError
            fatalError("Erro desconhecido \(nserror), \(nserror.userInfo)")
        }
    }
}
