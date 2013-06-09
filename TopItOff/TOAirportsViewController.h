//
//  TOAirportsViewController.h
//  TopItOff
//
//  Created by Lolcat on 08/06/2013.
//  Copyright (c) 2013 Createch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSONKit/JSONKit.h>
#import "TOStationsViewController.h"

@interface TOAirportsViewController : UITableViewController <UITableViewDataSource> {
    NSMutableDictionary *airportsData;
} 

@end
