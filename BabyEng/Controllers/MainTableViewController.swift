//
//  MainTableViewController.swift
//  BabyEng
//
//  Created by Denis Valshchikov on 20.10.2021.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    private let glossaryProvider: GlossaryProvider
    private var glossariesList: GlossariesList

    init (glossaryProvider: GlossaryProvider) {
        self.glossaryProvider = glossaryProvider
        self.glossariesList = glossaryProvider.getGlossariesList()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Глоссарии"
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "reuseIdentifier"
        )
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                barButtonSystemItem: .search,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                barButtonSystemItem: .compose,
                target: self,
                action: nil
            )
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Files",
            style: .plain,
            target: self,
            action: nil
        )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return glossariesList.glossariesNames.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if glossariesList.isOpen[section] {
            return glossariesList.glossariesNames[section].count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier",
            for: indexPath
        )

        let glossaryName = glossariesList.glossariesNames[indexPath.section][indexPath.row]
        cell.textLabel?.text = glossaryName
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(tableView.cellForRow(at: indexPath)?.textLabel?.text) is selected. Path: \(indexPath)")
        if indexPath.row == 0 {
            glossariesList.isOpen[indexPath.section] = !glossariesList.isOpen[indexPath.section]
            print(glossariesList.isOpen)
            DispatchQueue.main.async {
                tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
            }
        }
    }
    
}
