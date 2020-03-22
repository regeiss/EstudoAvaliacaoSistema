//
//  SideMenuVC.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 19/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//
import Foundation
import UIKit

enum MenuType: Int
{
    case home
    case perfil
    case cadastro
    case ajuda
    case logout
}

class SideMenuVC: UITableViewController
{
    var didTapMenuType: ((MenuType) -> Void)?
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case 0: return 3
            case 1: return 2
            default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let secao = indexPath.section
        var indice = indexPath.row
        
        if secao == 1
        {
            indice = indice + 3
        }
        
        guard let menuType = MenuType(rawValue: indice) else { return }
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuType?(menuType)
        }
    }
}
