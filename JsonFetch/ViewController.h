//
//  ViewController.h
//  JsonFetch
//
//  Created by Yuon Flemming on 4/13/14.
//  Copyright (c) 2014 Yuon Flemming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *JSONTableView;


- (IBAction)fetchData:(id)sender;

@end
