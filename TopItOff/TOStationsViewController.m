//
//  TOStationsViewController.m
//  TopItOff
//
//  Created by Lolcat on 09/06/2013.
//  Copyright (c) 2013 Createch. All rights reserved.
//

#import "TOStationsViewController.h"

@interface TOStationsViewController ()

@end

@implementation TOStationsViewController

@synthesize stations;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"Init with style");
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        NSLog(@"init the coder");
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"view did load with stations: %@", stations);

    [super viewDidLoad];
    self.navigationItem.title = [stations objectAtIndex:0][@"airport"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"stations: %@", stations);
//    NSLog(@"count: %d", stations[@"stations"]);
    return [stations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    id cellStationData = [[stations objectAtIndex:indexPath.row][@"stations"] objectAtIndex:indexPath.row];
    id cellData = [stations objectAtIndex:indexPath.row];
    
    
    UILabel *gasName = (UILabel *)[cell viewWithTag:1];
    UILabel *directions = (UILabel *)[cell viewWithTag:3];
    UILabel *address = (UILabel *)[cell viewWithTag:4];
    
//    NSLog(@"indexPath: %@ cellData: %@", indexPath, cellData);
    directions.text = cellData[@"directions"];
    gasName.text = cellStationData[@"gas_name"];
    address.text = cellStationData[@"address"];
    
    NSLog(@"directions: %@", directions.text);
    
    
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)showMap:(id)sender {
    
    NSLog(@"sender: %@", sender);
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    id cellStationData = [[stations objectAtIndex:indexPath.row][@"stations"] objectAtIndex:indexPath.row];
    id cellData = [stations objectAtIndex:indexPath.row];
    
    CLLocationDegrees lon = [cellStationData[@"lon"] doubleValue];
    CLLocationDegrees lat = [cellStationData[@"lat"] doubleValue];
    NSLog(@"lon: %f %f", lon, lat);

    
    //first create latitude longitude object
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat,lon);
    
    //create MKMapItem out of coordinates
    MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
    
    if([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
    {
        //using iOS6 native maps app
        [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
    }
    else
    {
        //using iOS 5 which has the Google Maps application
        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current+Location&daddr=%f,%f", lat, lon];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
    
    NSLog(@"indexPath: %@", indexPath);
}

@end
