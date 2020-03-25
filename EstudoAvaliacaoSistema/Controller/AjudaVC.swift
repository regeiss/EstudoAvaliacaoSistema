//
//  AjudaVC.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 20/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import UIKit

class AjudaVC: UIViewController
{

    @IBOutlet weak var lblLogado: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        NotificationCenter.default.removeObserver((Any).self, name: .didReceiveData, object: nil)
    }
    @objc func onDidReceiveData(_ notification:Notification)
    {
        lblLogado.text = "Logado"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
