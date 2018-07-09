//
//  FAQ.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "FAQ.h"

@interface FAQ ()

@end

@implementation FAQ
{
    BOOL currentlyExpanded;
    NSMutableArray *master, *list, *detaillist, *searchResults;
    NSMutableArray *detailResults;
    NSMutableIndexSet *expandedSections;
    UISearchBar *search;
    NSIndexPath *pastindex;
    NSDictionary *faqs;
}
@synthesize table;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[self navigationItem] setTitle:L(@"help")];
    
    if ([[defaults objectForKey:@"language"] isEqualToString:@"en"]) {
        faqs = [NSJSONSerialization JSONObjectWithData:nil options:kNilOptions error:nil];
        master = [faqs mutableCopy];
    } else {
        faqs = [NSJSONSerialization JSONObjectWithData:nil options:kNilOptions error:nil];
        master = [faqs mutableCopy];
    }

    list = [[NSMutableArray alloc] init];
    detaillist = [[NSMutableArray alloc] init];
    for (int i = 0; i < [master count]; i++) {
        [list addObject:[[master objectAtIndex:i] objectForKey:@"question"]];
        [detaillist addObject:[[master objectAtIndex:i] objectForKey:@"answer"]];
    }
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    
    [self UI];
}

- (void)UI {
    search = [[UISearchBar alloc] initWithFrame:CGRectMake([self view].frame.size.height > 568 ? [self view].frame.size.height > 736 ? 65 : 55 : 45, 90, [self view].frame.size.height > 568 ? [self view].frame.size.height > 736 ? [self view].frame.size.width-130 : [self view].frame.size.width-110 : [self view].frame.size.width-90, 50)];
    [search setSearchBarStyle:UISearchBarStyleMinimal];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setDelegate:self];
    [search setShowsCancelButton:NO];
    [search setPlaceholder:@"search"];
    search.transform = CGAffineTransformMakeScale(1.4, 1.4);
    
//    for(UIView *view in search.subviews)
//    {
//        for(UITextField *textfield in view.subviews)
//        {
//            if ([textfield isKindOfClass:[UITextField class]]) {
//                textfield.frame = CGRectMake(textfield.frame.origin.x, 10, textfield.frame.size.width, (search.frame.size.height - (10 * 2)));
//            }
//        }
//    }
    
    UITextField *searchTextField = [search valueForKey:@"_searchField"];
    if ([searchTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        [searchTextField setTextColor:[self colorFromHexString:@"#666666" withAlpha:1.0]];
        [searchTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"search" attributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color4 withAlpha:1.0]}]];
    }
    
    UIButton *clearButton = [searchTextField valueForKey:@"_clearButton"];
    [clearButton setImage:[clearButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    clearButton.tintColor = [self colorFromHexString:Color4 withAlpha:1.0];
    
    NSArray *searchBarSubViews = [[search.subviews objectAtIndex:0] subviews];
    for (UIView *view in searchBarSubViews) {
        if([view isKindOfClass:[UITextField class]])
        {
            UITextField *textField = (UITextField*)view;
            UIImageView *imgView = (UIImageView*)textField.leftView;
            imgView.image = [imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            imgView.tintColor = [self colorFromHexString:Color4 withAlpha:1.0];
        }
    }
    
    [[self view] addSubview:search];
    
    UILabel *lbl = [self UILabel:self withFrame:CGRectMake(10, 60, [self view].frame.size.width-20, 30) withText:@"faqs" withTextSize:textsize16 withAlignment:0 withLines:0];
    [lbl setFont:[UIFont boldSystemFontOfSize:textsize24]];
    [[self view] addSubview:lbl];
    
    UIView *line = [self UIView:self withFrame:CGRectMake(0, 150, [self view].frame.size.width, 1)];
    [line setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [[self view] addSubview:line];
    
    table = [self UITableView:self withFrame:CGRectMake(0, 151, self.view.frame.size.width, self.view.frame.size.height-151) withStyle:0];
    [table setRowHeight:UITableViewAutomaticDimension];
    [table setEstimatedRowHeight:50];
    [table setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[self view] addSubview:table];
}

#pragma mark - Searchbar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [expandedSections removeAllIndexes];
    [self handleSearch:searchBar];
    [[self view] endEditing:YES];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [expandedSections removeAllIndexes];
    [table setFrame:CGRectMake(0, 141, self.view.frame.size.width, self.view.frame.size.height-332)];
    [self.view addGestureRecognizer:tapRecognizer];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [expandedSections removeAllIndexes];
    [self handleSearch:searchBar];
    [table setFrame:CGRectMake(0, 141, self.view.frame.size.width, self.view.frame.size.height-141)];
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [expandedSections removeAllIndexes];
    [self handleSearch:searchBar];
}

//do our search on the remote server using HTTP request
- (void)handleSearch:(UISearchBar *)searchBar {
    //check what was passed as the query String and get rid of the keyboard
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    [searchBar text]];
    
    searchResults = [[list filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    
    detailResults = [[NSMutableArray alloc] init];
    [detailResults removeAllObjects];
    for (int i = 0; i < [searchResults count]; i++) {
        for (int j = 0; j < [master count]; j++) {
            if ([[searchResults objectAtIndex:i] isEqualToString:[[master objectAtIndex:j] objectForKey:@"question"]]) {
                [detailResults addObject:[[master objectAtIndex:j] objectForKey:@"answer"]];
            }
        }
    }
    [table reloadData];
    
    pastindex = nil;
//    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
}

#pragma mark - Table view data source
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section >= 0) return YES;
    
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[search text] length] > 0) {
        return [searchResults count];
    } else {
        return [list count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            return 2; // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // first row
            if ([searchResults count] > 0) {
                cell.textLabel.text = [searchResults objectAtIndex:indexPath.section];
            } else {
                cell.textLabel.text = [list objectAtIndex:indexPath.section];
            }
            cell.textLabel.textColor = [self colorFromHexString:@"#008FA6" withAlpha:1.0];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.textLabel.numberOfLines = 0;
            if ([expandedSections containsIndex:indexPath.section])
            {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"arrowup.png"]]];
                cell.accessoryView = imageView;
            }
            else
            {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"arrowdown.png"]]];
                cell.accessoryView = imageView;
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        else
        {
            // all other rows
            if ([searchResults count] > 0) {
//                cell.textLabel.text = L([detailResults objectAtIndex:indexPath.section]);
                cell.textLabel.attributedText = [[NSAttributedString alloc]
                                                 initWithData: [[detailResults objectAtIndex:indexPath.section] dataUsingEncoding:NSUTF8StringEncoding]
                                                 options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                 documentAttributes: nil
                                                 error: nil];
            } else {
//                cell.textLabel.text = L([detaillist objectAtIndex:indexPath.section]);
                cell.textLabel.attributedText = [[NSAttributedString alloc]
                                                 initWithData: [[detaillist objectAtIndex:indexPath.section] dataUsingEncoding:NSUTF8StringEncoding]
                                                 options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                 documentAttributes: nil
                                                 error: nil];
            }
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = [self colorFromHexString:@"#555555" withAlpha:1.0];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.textLabel.numberOfLines = 0;
        }
    }
    else
    {
//        cell.textLabel.text = [list objectAtIndex:indexPath.section];
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            if (!pastindex) {
                pastindex = indexPath;
            } else if(pastindex != indexPath) {
                NSInteger section = pastindex.section;
                
                currentlyExpanded = [expandedSections containsIndex:section];
                NSInteger rows;
                
                NSMutableArray *tmpArray = [NSMutableArray array];
                
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
                for (int i=1; i<rows; i++)
                {
                    NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:section];
                    [tmpArray addObject:tmpIndexPath];
                }
                
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:pastindex];
                
                [tableView deleteRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationFade];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"arrowdown.png"]]];
                cell.accessoryView = imageView;
                
                pastindex = indexPath;
            }
//            =======================================
//            only first row toggles exapand/collapse
            NSInteger section = indexPath.section;
            
            currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;

            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }

            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationFade];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"arrowdown.png"]]];
                cell.accessoryView = imageView;
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationAutomatic];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"arrowup.png"]]];
                cell.accessoryView = imageView;
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
