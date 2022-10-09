//
//  ReservaViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 05/10/22.
//

import UIKit

class ReservaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var reservaController = ReservaController()
    var reserva = Reservas()
    @IBOutlet weak var tableView: UITableView!
    //var salones = Classrooms.listaSalones()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task{
            do{
                let reserva = try await reservaController.fetchReservas()
                updateUI(with: reserva)
            }catch{
                displayError(ClassroomError.itemNotFound, title: "No se pudo acceder a las reservas")
            }
        }
    }
    
    func updateUI(with reserva:Reservas){
        DispatchQueue.main.async {
            self.reserva = reserva
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
        let movedEmoji = reserva.remove(at: fromIndexPath.row)
        reserva.insert(movedEmoji, at: to.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reserva.count
   
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "salones", for: indexPath) as! ReservaTableViewCell
        
        // Configure the cell...
        let reserva = self.reserva[indexPath.row]
        //let indice = salones[indice]
        cell.update(r: reserva)
        //cell.showsReorderControl = true
        return cell
    }
    
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source as? EditReservaTableViewController,
              let reserva = sourceViewController.reservas else { return };

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            Task{
                do{
                    try await reservaController.updateReserva(updateReserva: reserva)
                    self.updateUI()
                }catch{
                    displayError(ReservaError.itemNotFound, title: "No se puede actualizar la reserva")
                }
            }
        } else {
            Task{
                do{
                    try await reservaController.insertReserva(nuevareserva: reserva)
                    self.updateUI()
                }catch{
                    displayError(ReservaError.itemNotFound, title: "No se puede insertar la reserva")
                }
            }
        }
    }
    
    
    @IBSegueAction func addEdit(_ coder: NSCoder, sender: Any?) -> EditReservaTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Editing Emoji
            let c = reserva[indexPath.row]
            return EditReservaTableViewController(coder: coder, c: c)
        } else {
            // Adding Emoji
            return EditReservaTableViewController(coder: coder, c: nil)
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
                    let registroEliminar = reserva[indexPath.row].id
                    try await self.reservaController.deleteReserva(registroID: registroEliminar)
                    self.updateUI()
                }catch{
                    displayError(ReservaError.itemNotFound, title: "No se puede eliminar")
                }
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func updateUI(){
        Task{
            do{
                let reserva = try await reservaController.fetchReservas()
                updateUI(with: reserva)
            }catch{
                displayError(ReservaError.itemNotFound, title: "No se pudo accer a las reservas")
            }
        }
        
    }
    
    
    @IBAction func didViewChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}
