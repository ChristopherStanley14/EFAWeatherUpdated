//
//  CurrentViewController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/20/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

// Step 4: Import Class
class CurrentViewController: UIViewController {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tempLabel.layer.cornerRadius = 45
        tempLabel.clipsToBounds = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(setupView), name: NSNotification.Name(rawValue: Constants.weatherUpdated), object: nil)
        
        // Step 10: listen for app entering foreground
        NotificationCenter.default.addObserver(self, selector: #selector(setupView), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        if let currentWeather = UserStore.shared.weatherInfo?.currentWeather {
            tempLabel.text = "\(Utils.intFromDouble(currentWeather.temperature))º"
            feelsLikeLabel.text = "Feels Like \(Utils.intFromDouble(currentWeather.apparentTemperature))º"
            conditionLabel.text = currentWeather.summary ?? ""
        } else {
            tempLabel.text = ""
            feelsLikeLabel.text = ""
            conditionLabel.text = ""
        }
        if let dailyWeather = UserStore.shared.weatherInfo?.dailyWeather, let todayWeather = dailyWeather.data?[0] {
            highLabel.text = "High: \(Utils.intFromDouble(todayWeather.temperatureMax))º"
            lowLabel.text = "Low: \(Utils.intFromDouble(todayWeather.temperatureMin))º"
        } else {
            highLabel.text = ""
            lowLabel.text = ""
        }
        
        tableView.reloadData()
    }
}


extension CurrentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        let currentWeather = UserStore.shared.weatherInfo?.currentWeather
        
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.textLabel?.text = "Precipitation Intensity"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.precipitationIntensity)
        case 1:
            cell.textLabel?.text = "Precipitation Probability"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.precipitationIntensity) + "%"
        case 2:
            cell.textLabel?.text = "Nearest Storm Distance"
            cell.detailTextLabel?.text = Utils.formatInt(currentWeather?.nearestStormDistance)
        case 3:
            cell.textLabel?.text = "Nearest Storm Bearing"
            cell.detailTextLabel?.text = Utils.formatInt(currentWeather?.nearestStormBearing)
        case 4:
            cell.textLabel?.text = "Dew Point"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.dewPoint)
        case 5:
            cell.textLabel?.text = "Humidity"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.humidity)
        case 6:
            cell.textLabel?.text = "Wind Speed"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.windSpeed)
        case 7:
            cell.textLabel?.text = "Wind Bearing"
            cell.detailTextLabel?.text = Utils.formatInt(currentWeather?.windBearing)
        case 8:
            cell.textLabel?.text = "Visibility"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.visibility)
        case 9:
            cell.textLabel?.text = "Cloud Cover"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.cloudCover)
        case 10:
            cell.textLabel?.text = "Pressure"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.pressure)
        case 11:
            cell.textLabel?.text = "Ozone"
            cell.detailTextLabel?.text = Utils.formatDouble(currentWeather?.ozone)
        default:
            break
        }
        
        return cell
    }
}
