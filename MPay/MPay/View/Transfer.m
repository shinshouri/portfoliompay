//
//  Transfer.m
//  MPay
//
//  Created by Admin on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Transfer.h"
#import "ImageCell.h"

@implementation Transfer
{
    UITableView *tbl;
    NSArray *CL, *PH;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CL = [[NSArray alloc] initWithObjects:@"Agung Nugroho", @"Agung T", @"Evan", @"Evan", @"Evan", @"Evan", @"Evan", @"Evan", @"Evan", @"Evan", @"Evan", nil];
    PH = [[NSArray alloc] initWithObjects:@"081812345678", @"081812345678", @"081812345678", @"081812345678", @"081812345678", @"081812345678", @"081812345678", @"081812345678", @"081812345678", @"081812345678", @"081812345678", nil];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = L(@"selectYourFriend");
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    [self tabBarController].navigationItem.rightBarButtonItem = addButton;
}

- (void)UI {
    [[self view] addSubview:[self UIImage:self withFrame:CGRectMake(20, 80, 30, 30) withImageName:@""]];
    
    UITextField *Search = [[UITextField alloc] initWithFrame:CGRectMake(50, 80, self.view.bounds.size.width-70, 30)];
    Search.attributedPlaceholder = [[NSAttributedString alloc]
                                    initWithString:L(@"enterNameOrNumber")
                                    attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:100 green:100 blue:100 alpha:0.5]}];
    Search.textColor = [UIColor whiteColor];
    Search.font = [UIFont boldSystemFontOfSize:12];
    Search.backgroundColor = [UIColor clearColor];
    [[self view] addSubview:Search];
    
    [[self view] addSubview:[self UILabel:self withFrame:CGRectMake(20, 120, self.view.bounds.size.width-40, 30) withText:L(@"friendList") withTextSize:16 withAlignment:0 withLines:0]];
    
    tbl = [self UITableView:self withFrame:CGRectMake(20, 150, [self view].frame.size.width-40, [self view].frame.size.height-200) withStyle:0];
    [[self view] addSubview:tbl];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CL count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.img.image = [UIImage imageNamed:@""];
    cell.mainLabel.text = [CL objectAtIndex:[indexPath row]];
    cell.descriptionLabel.text = [PH objectAtIndex:[indexPath row]];
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarController.title = @"";
    [self performSegueWithIdentifier:@"InputAmount" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
