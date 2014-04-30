//
//  ViewController.m
//  weatherInfo
//
//  Created by Mac Book on 29/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self CurrentLocationIdentifier];
    
	// Do any additional setup after loading the view, typically from a nib.
}

// Initialize location manager object.
-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    //------
}

// Update current location.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             [self makeRequestForWeather:Area];
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"Unable to fetch current Location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [alert show];
             //return;
         }
    
     }];
}

// make request for fetching data of weather.
-(void)makeRequestForWeather :(NSString *)param
{
    reqObj = [[Request alloc]init];
    reqObj.delegate = self;
    [reqObj request:param];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Get Date from Time Stamp.
-(NSString *)getDateFromTimeStamp :(NSString *)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

// Delegate method of request class for getting response of server.
-(void)getResult:(id)jsonData
{
    if ([jsonData isKindOfClass:[NSDictionary class]])
    {
        id cod = [jsonData valueForKey:@"cod"];
        
        if (![cod isEqualToString:@"200"])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"Please enter valid city Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        id city = [jsonData valueForKey:@"city"];
        
        id name = [city valueForKey:@"name"];
        
        id list = [jsonData valueForKey:@"list"];
        
        
        if (![list isKindOfClass:[NSNull class]])
        {
            if ([list isKindOfClass:[NSArray class]])
            {
                if (!arrWeatherInfo) {
                    arrWeatherInfo = [[NSMutableArray alloc]init];
                }else
                {
                    [arrWeatherInfo removeAllObjects];
                }
                
                for (int i=0; i<[list count]; i++)
                {
                    weatherDataClass *WDobj = [[weatherDataClass alloc]init];
                    
                    id dt = [[list objectAtIndex:i] valueForKey:@"dt"];
                    WDobj.strDate = dt;
                    
                    id temp = [[list objectAtIndex:i] valueForKey:@"temp"];
                    if (![temp isKindOfClass:[NSNull class]])
                    {
                        id  max = [temp valueForKey:@"max"];
                        WDobj.strMax = max;
                        
                        id  min = [temp valueForKey:@"min"];
                        WDobj.strMin = min;
                    }
                    
                    WDobj.strCity = name;
                    
                    [arrWeatherInfo addObject:WDobj];
                }
            }
        }
    }
    [self.tblWeather reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchTab resignFirstResponder];
    [self makeRequestForWeather:searchBar.text];
}



#pragma mark - UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrWeatherInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
    weatherCell *cell = (weatherCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[weatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier Delegate:self tag:indexPath.row];
    }
    
    weatherDataClass *dataOBJ = [arrWeatherInfo objectAtIndex:indexPath.row];
    
    cell.lblDate.text = [NSString stringWithFormat:@"%@",[self getDateFromTimeStamp:dataOBJ.strDate]];
    
    cell.lblMaxTemp.text = [NSString stringWithFormat:@"Max - %@",dataOBJ.strMax];
    
    cell.lblMinTemp.text = [NSString stringWithFormat:@"Min - %@",dataOBJ.strMin];
    
    cell.lblCity.text = [NSString stringWithFormat:@"%@",dataOBJ.strCity];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
