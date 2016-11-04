//
//  ForecastViewController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/20/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

// Step 4: Import Class
class ForecastViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // Step 6: add sectionExpanded
    var sectionExpanded = [false, false, false, false, false, false, false]
    
    // Step 7: add closeButton
    var closeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 7: add modal logic
        if self.parent is UINavigationController {
            closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close(_:)))
            self.navigationItem.leftBarButtonItem = closeButton
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        tableView.reloadData()
    }
    
    // Step 7: implement close function
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}


// Step 6: update UITableViewDelegate/DataSource functions
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionExpanded[section] ? 19 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayCell.self)) as! DayCell
            
            cell.delegate = self
            
            let date = Date().addingTimeInterval(60*60*24)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E"
            let day = dateFormatter.string(from: date)
            let temp: String
            if let dayInfo = UserStore.shared.weatherInfo?.dailyWeather?.data?[(indexPath as NSIndexPath).section] {
                temp = "\(Utils.intFromDouble(dayInfo.temperatureMin))º - \(Utils.intFromDouble(dayInfo.temperatureMax))º"
            } else {
                temp = ""
            }
            cell.setupCell(day, temp: temp, section: indexPath.section, expanded: sectionExpanded[indexPath.section])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourCell.self)) as! HourCell
            
            if let dayInfo = UserStore.shared.weatherInfo?.dailyWeather?.data?[(indexPath as NSIndexPath).section] {
                switch (indexPath as NSIndexPath).row {
                case 1:
                    cell.textLabel?.text = dayInfo.summary ?? ""
                    cell.detailTextLabel?.text = ""
                case 2:
                    cell.textLabel?.text = "Max Temp."
                    cell.detailTextLabel?.text = "\(Utils.formatDouble(dayInfo.temperatureMax))º @\(Utils.timeFromTimestamp(dayInfo.temperatureMaxTime))"
                case 3:
                    cell.textLabel?.text = "Min Temp."
                    cell.detailTextLabel?.text = "\(Utils.formatDouble(dayInfo.temperatureMin))º @\(Utils.timeFromTimestamp(dayInfo.temperatureMinTime))"
                case 4:
                    cell.textLabel?.text = "Max Real Feel"
                    cell.detailTextLabel?.text = "\(Utils.formatDouble(dayInfo.apparentTemperatureMin))º @\(Utils.timeFromTimestamp(dayInfo.apparentTemperatureMinTime))"
                case 5:
                    cell.textLabel?.text = "Min Real Feel"
                    cell.detailTextLabel?.text = "\(Utils.formatDouble(dayInfo.apparentTemperatureMax))º @\(Utils.timeFromTimestamp(dayInfo.apparentTemperatureMinTime))"
                case 6:
                    cell.textLabel?.text = "Precipitation Intensity"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.precipitationIntensity)
                case 7:
                    cell.textLabel?.text = "Precipitation Intensity Max"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.precipitationIntensityMax)
                case 8:
                    cell.textLabel?.text = "Precipitation Probability"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.precipitationIntensity) + "%"
                case 9:
                    cell.textLabel?.text = "Dew Point"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.dewPoint)
                case 10:
                    cell.textLabel?.text = "Humidity"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.humidity)
                case 11:
                    cell.textLabel?.text = "Wind Speed"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.windSpeed)
                case 12:
                    cell.textLabel?.text = "Wind Bearing"
                    cell.detailTextLabel?.text = Utils.formatInt(dayInfo.windBearing)
                case 13:
                    cell.textLabel?.text = "Visibility"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.visibility)
                case 14:
                    cell.textLabel?.text = "Cloud Cover"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.cloudCover)
                case 15:
                    cell.textLabel?.text = "Pressure"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.pressure)
                case 16:
                    cell.textLabel?.text = "Ozone"
                    cell.detailTextLabel?.text = Utils.formatDouble(dayInfo.ozone)
                case 17:
                    cell.textLabel?.text = "Sunrise"
                    cell.detailTextLabel?.text = Utils.timeFromTimestamp(dayInfo.sunriseTime)
                case 18:
                    cell.textLabel?.text = "Sunset"
                    cell.detailTextLabel?.text = Utils.timeFromTimestamp(dayInfo.sunsetTime)
                default:
                    break
                }
            }
            
            return cell
        }
    }
}


// Step 6: add DayCellDelegate extension
extension ForecastViewController: DayCellDelegate {
    func cellTapped(_ section: Int) {
        sectionExpanded[section] = !sectionExpanded[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
