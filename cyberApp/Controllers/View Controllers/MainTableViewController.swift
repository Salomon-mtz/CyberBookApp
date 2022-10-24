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
    
    

}

   

