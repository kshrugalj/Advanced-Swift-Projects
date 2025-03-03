//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Kshrugal Reddy Jangalapalli on 2/22/25.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btcPrice: UILabel!
    @IBOutlet weak var solanaPrice: UILabel!
    @IBOutlet weak var etherPrice: UILabel!
    @IBOutlet weak var lcPrice: UILabel!
    @IBOutlet weak var lastUpdatedPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCoinData()
        
        let timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    @objc func refreshData() -> Void{
        fetchCoinData()
    }
    

    struct Coin: Codable {
        let id: String
        let symbol: String
        let name: String
        let current_price: Double
    }
    

    func fetchCoinData() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,solana,litecoin"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            

            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                
                // Ensure the response contains the expected coins
                if coins.count == 4 {
                    DispatchQueue.main.async {
                        self.setPrices(coins: coins)
                    }
                }
                
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    

    func setPrices(coins: [Coin]) {

        if let btcCoin = coins.first(where: { $0.id == "bitcoin" }),
           let ethCoin = coins.first(where: { $0.id == "ethereum" }),
           let solanaCoin = coins.first(where: { $0.id == "solana" }),
           let lcCoin = coins.first(where: { $0.id == "litecoin" }) {
            
            self.btcPrice.text = formatPrice(btcCoin)
            self.etherPrice.text = formatPrice(ethCoin)
            self.solanaPrice.text = formatPrice(solanaCoin)
            self.lcPrice.text = formatPrice(lcCoin)
            self.lastUpdatedPrice.text = formatDate(date: Date())
        }
    }
    

    func formatPrice(_ coin: Coin) -> String {
        return String(format: "%@ $%.2f", coin.symbol.uppercased(), coin.current_price)
    }
    

    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
