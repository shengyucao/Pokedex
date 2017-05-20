//
//  PokeDetailVC.swift
//  Pokedex
//
//  Created by Shengyu Cao on 5/20/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {
    
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!

    
    
    
    var pokemon: Pokemon!


    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexID)")
        
        print()
        
        pokemon.downloadPokemonDetail {
            
            self.updateUI()
        
        }
    }
    
    func updateUI() {
        self.pokeID.text = "\(pokemon.pokedexID)"
        self.detailInfo.text = pokemon.detailInfo
        self.typeLbl.text = pokemon.type
        self.heightLbl.text = pokemon.height
        self.weightLbl.text = pokemon.weight
        self.attackLbl.text = pokemon.attack
        self.defenseLbl.text = pokemon.defense
        self.evoLbl.text = pokemon.evoLbl
        self.currentEvoImg.image = UIImage(named: "\(pokemon.pokedexID)")
        
        if self.evoLbl.text == "No Evolution!" {
            nextEvoImg.isHidden = true
        } else {
            self.nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoId)")
        }
        
        
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

    

}
