//
//  DailyCalorieMeterTableViewCell.swift
//  BeFit
//
//  Created by MTLab on 07/01/2017.
//  Copyright © 2017 Kristijan Gašljević. All rights reserved.
//

import UIKit

class DailyCalorieMeterTableViewCell: UITableViewCell {
    //txt labels
    @IBOutlet weak var labelDailyGoaltxt: UILabel!
    @IBOutlet weak var labelMealstxt: UILabel!
    @IBOutlet weak var labelExercisetxt: UILabel!
    @IBOutlet weak var labelRemainingtxt: UILabel!
    
    //labels with number value
    @IBOutlet weak var labelCounterDailyGoal: UILabel!
    @IBOutlet weak var labelCounterMeals: UILabel!
    @IBOutlet weak var labelCounterExercise: UILabel!
    @IBOutlet weak var labelCounterRemaining: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelCounterRemaining.font = UIFont.boldSystemFont(ofSize: 19.0);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
