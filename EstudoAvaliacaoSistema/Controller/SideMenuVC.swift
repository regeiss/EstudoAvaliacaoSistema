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
    case logout
    case ajuda
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuType?(menuType)
        }
    }
}
