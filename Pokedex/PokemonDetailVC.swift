//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Ali Zeynalov on 04/09/16.
//  Copyright © 2016 Ali Zeynalov. All rights reserved.
//


import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
        mainImg.image=UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImg.image=UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { 
            // Download bittiginde fonksiyon calistirilacaktir
            self.updateUI()
        }
        }
    
    
    func updateUI()
    {
        descriptionLbl.text=pokemon.description
        typeLbl.text=pokemon.type
        defenseLbl.text=pokemon.defense
        heightLbl.text=pokemon.height
        pokedexLbl.text="\(pokemon.pokedexId)"
        weightLbl.text=pokemon.weight
        baseAttack.text=pokemon.attack
        
        ///pokemon evolve etmiyorsa
        if pokemon.nextEvolutionId == ""
        {
            evoLbl.text="No Evolutions"
            nextEvoImg.hidden=true
        }
        else
        {
            nextEvoImg.hidden=false
            nextEvoImg.image=UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            if pokemon.nextEvolutionLvl != ""
            {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
                evoLbl.text=str
            }
        }
        
        
    }
    

    @IBAction func BackButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        }
    }
    
    

    





    

    
    

