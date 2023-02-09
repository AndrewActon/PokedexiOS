//
//  PokemonViewController.swift
//  PokedexiOS
//
//  Created by Andrew Acton on 2/8/23.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    
    //MARK: Lifecylce Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    //MARK: Methods
    
    func fetchSpriteAndUpdateViews(pokemon: Pokemon) {
        PokemonController.fetchSprite(pokemon: pokemon) { (result) in
            DispatchQueue.main.async {
                
                
                switch result {
                    
                case .success(let sprite):
                    
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name
                    self.pokeIDLabel.text = String(pokemon.id)
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text,
              !searchTerm.isEmpty else { return }
        
        PokemonController.fetchPokemon(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                
                
                switch result {
                    
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(pokemon: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
