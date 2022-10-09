//
//  ViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 21/09/22.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var classController = ClassroomController()
    var classroom = Classrooms()
    @IBOutlet weak var tableView: UITableView!
    //var salones = Classrooms.listaSalones()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task{
            do{
                let classroom = try await classController.fetchReservas()
                updateUI(with: classroom)
            }catch{
                displayError(ClassroomError.itemNotFound, title: "No se pudo acceder a las reservas")
            }
        }
    }
    
    func updateUI(with classroom:Classrooms){
        DispatchQueue.main.async {
            self.classroom = classroom
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
        let movedEmoji = classroom.remove(at: fromIndexPath.row)
        classroom.insert(movedEmoji, at: to.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classroom.count
   
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "espacios", for: indexPath) as! ClassroomTableViewCell
        
        // Configure the cell...
        let classroom = self.classroom[indexPath.row]
        //let indice = salones[indice]
        cell.update(r: classroom)
        //cell.showsReorderControl = true
        return cell
    }
    
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source as? AddEditReservaTableViewController,
              let classroom = sourceViewController.classrooms else { return };

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            Task{
                do{
                    try await classController.insertReserva(nuevareserva: classroom)
                    self.updateUI()
                }catch{
                    displayError(ClassroomError.itemNotFound, title: "No se puede insertar la reserva")
                }
            }
        }
    }
    
    
    @IBSegueAction func addEdit(_ coder: NSCoder, sender: Any?) -> AddEditReservaTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Editing Emoji
            let c = classroom[indexPath.row]
            return AddEditReservaTableViewController(coder: coder, c: c)
        } else {
            // Adding Emoji
            return AddEditReservaTableViewController(coder: coder, c: nil)
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
                    let registroEliminar = classroom[indexPath.row].id
                    try await self.classController.deleteReserva(registroID: registroEliminar)
                    self.updateUI()
                }catch{
                    displayError(ClassroomError.itemNotFound, title: "No se puede eliminar")
                }
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func updateUI(){
        Task{
            do{
                let classroom = try await classController.fetchReservas()
                updateUI(with: classroom)
            }catch{
                displayError(ClassroomError.itemNotFound, title: "No se pudo accer a las reservas")
            }
        }
        
    }
    
    
    @IBAction func didViewChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

   

