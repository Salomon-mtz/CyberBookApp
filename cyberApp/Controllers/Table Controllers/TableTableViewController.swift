//
//  TableViewTableViewController.swift
//  PruebaTablasReto
//
//  Created by Usuario on 19/09/22.
//

import UIKit

class TableViewTableViewController: UITableViewController {
    
    var reservas = Historial.listaReservas()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reservas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
        let indice = indexPath.row
        content.text = reservas[indice].titulo
        content.secondaryText = reservas[indice].fechaReserva
        
        cell.contentConfiguration = content
        
        cell.showsReorderControl = true

        return cell
    }

}

