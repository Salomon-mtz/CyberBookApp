//
//  LicenciasTableViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 05/10/22.
//

import UIKit

class LicenciasTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var licenciaController = LicenseController()
    var license = Licenses()
    @IBOutlet weak var tableView: UITableView!
    //var salones = Classrooms.listaSalones()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task{
            do{
                let license = try await licenciaController.fetchReservas()
                updateUI(with: license)
            }catch{
                displayError(LicenseError.itemNotFound, title: "No se pudo acceder a las reservas")
            }
        }
    }
    
    func updateUI(with license:Licenses){
        DispatchQueue.main.async {
            self.license = license
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
    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
            tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = license.remove(at: fromIndexPath.row)
        license.insert(movedEmoji, at: to.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return license.count
   
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "licencias", for: indexPath) as! LicenciasTableViewCell
        
        // Configure the cell...
        let license = self.license[indexPath.row]
        //let indice = salones[indice]
        cell.update(r: license)
        //cell.showsReorderControl = true
        return cell
    }
    
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source as? AddLicenciasTableViewController,
              let license = sourceViewController.licences else { return };

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            Task{
                do{
                    try await licenciaController.insertReserva(nuevareserva: license)
                    self.updateUI()
                }catch{
                    displayError(LicenseError.itemNotFound, title: "No se puede insertar la reserva")
                }
            }
        }
    }
    
    
    
    @IBSegueAction func addEdit(_ coder: NSCoder, sender: Any?) -> AddLicenciasTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Editing Emoji
            let c = license[indexPath.row]
            return AddLicenciasTableViewController(coder: coder, l: c)
        } else {
            // Adding Emoji
            return AddLicenciasTableViewController(coder: coder, l: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Task{
                do{
                    let registroEliminar = license[indexPath.row].id
                    try await self.licenciaController.deleteReserva(registroID: registroEliminar)
                    self.updateUI()
                }catch{
                    displayError(LicenseError.itemNotFound, title: "No se puede eliminar")
                }
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func updateUI(){
        Task{
            do{
                let license = try await licenciaController.fetchReservas()
                updateUI(with: license)
            }catch{
                displayError(LicenseError.itemNotFound, title: "No se pudo accer a las reservas")
            }
        }
        
    }
    
    
    @IBAction func didViewChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}
