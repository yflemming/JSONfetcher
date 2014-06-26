//
//  ViewController.m
//  JsonFetch
//
//  Created by Yuon Flemming on 4/13/14.
//  Copyright (c) 2014 Yuon Flemming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *JSONData;
    NSURLConnection *urlConn;
    NSMutableArray *JSONArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self JSONTableView]setDelegate:self];
    [[self JSONTableView]setDataSource:self];
    JSONArray = [[NSMutableArray alloc]init];
}

//Check for response from site URL
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [JSONData setLength:0];
}


//Append Recieved to JSONdata array
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [JSONData appendData:data];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection Failure: Error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSArray *entryData = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    for (NSDictionary *dict in entryData) {
        NSString *_id = [dict objectForKey:@"_id"];
      //  NSString *description = [dict objectForKey:@"_id"];
        
        [JSONArray addObject:_id];
    }
    [[self JSONTableView]reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchData:(id)sender
{
    [JSONArray removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"http://ims-dev.wesleyan.edu/pulleffect/messages"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    urlConn = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (urlConn) {
        JSONData = [[NSMutableData alloc]init];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [JSONArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    cell.textLabel.text = [JSONArray objectAtIndex:indexPath.row];
    return cell;
}

@end
