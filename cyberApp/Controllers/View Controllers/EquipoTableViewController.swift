//
//  EquipoTableViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 06/10/22.
//

import UIKit

class EquipoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var equipoController = EquipoController()
    var equipo = Equipos()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task{
            do{
                let equipo = try await equipoController.fetchReservas()
                updateUI(with: equipo)
            }catch{
                displayError(EquipoError.itemNotFound, title: "No se pudo acceder a las reservas")
            }
        }
    }
    
    func updateUI(with equipo:Equipos){
        DispatchQueue.main.async {
            self.equipo = equipo
            self.tableView.reloadData()
        }
    }
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipo.count
   
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equipos", for: indexPath) as! EquiposTableViewCell
        
        // Configure the cell...
        let equipo = self.equipo[indexPath.row]
        //let indice = salones[indice]
        cell.update(r: equipo)
        //cell.showsReorderControl = true
        return cell
    }
    
    
    func updateUI(){
        Task{
            do{
                let license = try await equipoController.fetchReservas()
                updateUI(with: license)
            }catch{
                displayError(EquipoError.itemNotFound, title: "No se pudo accer a las reservas")
            }
        }
        
    }
    
    
    @IBAction func didViewChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}
