//
//  TOStationsViewController.h
//  TopItOff
//
//  Created by Lolcat on 09/06/2013.
//  Copyright (c) 2013 Createch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TOStationsViewController : UITableViewController

@property NSMutableArray *stations;
- (IBAction)showMap:(id)sender;

@end
