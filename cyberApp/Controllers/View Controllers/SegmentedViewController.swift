//
//  SegmentedViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 27/09/22.
//

import UIKit
/*
class SegmentedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    var classController = ClassroomController()
    var classroom = Classrooms()
    var licenseController = LicenseController()
    var licencia = Licenses()
    var equipos = Equipos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.02, green: 0.16, blue: 0.46, alpha: 1.00)]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes2, for: .selected)
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        Task{
            do{
                let classroom = try await classController.fetchReservas()
                updateUI(with: classroom)
            }catch{
                displayError(ClassroomError.itemNotFound, title: "No se pudo accer a las reservas")
            }
        }
    }
    
    func updateUI(with classroom:[Classroom]){
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
        switch segmentedController.selectedSegmentIndex{
        case 0:
            return classroom.count
        case 1:
            return equipos.count
        case 2:
            return licencia.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reserva", for: indexPath)as! MainTableViewCell
        switch segmentedController.selectedSegmentIndex{
        case 0:
            let indice = indexPath.row
            let classroom = classroom[indice]
            cell.update(r: classroom)
            cell.showsReorderControl = true
            return cell 
        case 1:
            let indice = indexPath.row
            let equipo = equipos[indice]
            cell.update(r: equipo)
            cell.showsReorderControl = true
        case 2:
            let indice = indexPath.row
            let licencia = licencia[indice]
            cell.update(r: licencia)
            cell.showsReorderControl = true
        default:
            break
        }
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

    @IBSegueAction func addEditReserva(_ coder: NSCoder, sender: Any?) -> AddEditReservaTableViewController? {
        
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
            classroom.remove(at: indexPath.row)
            equipos.remove(at: indexPath.row)
            licencia.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    @IBAction func didViewChange(_ sender: UISegmentedControl) {
        tableView.reloadData()
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
}*/
