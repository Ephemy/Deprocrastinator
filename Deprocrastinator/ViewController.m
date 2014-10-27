//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Jonathan Chou on 10/27/14.
//  Copyright (c) 2014 Jonathan Chou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property NSIndexPath *checkedIndexPath;
@property BOOL editButton;
@property int editCount;
@property int swipeCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.editButton = NO;
    self.editCount = 0;
    [super viewDidLoad];
//    self.listTableView.allowsMultipleSelection = YES;
    //    self.listArray = [@[] mutableCopy];
    self.listArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.row];
    
    return cell;}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!self.checkedIndexPath){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checkedIndexPath = indexPath;
    }
    
    else if([self.checkedIndexPath isEqual:indexPath]){
        self.checkedIndexPath = nil;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    
    else
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(self.editButton)
    {   [self.listArray removeObjectAtIndex:indexPath.row];
        [self.listTableView reloadData];
    }
    
        
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self onAddButtonPressed:nil];
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.listArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (IBAction)onAddButtonPressed:(id)sender
{
    
    if (![self.textField.text isEqualToString:@""])
    {
    NSString *list = self.textField.text;
    [self.listArray addObject:list];
    
    [self.listTableView reloadData];
    self.textField.text = nil;
    [self.textField resignFirstResponder];
    }
}

- (IBAction)editButtonPressed:(UINavigationItem *)editButton
{
    self.editCount++;
    if(self.editCount%2){
    self.editButton = YES;
    editButton.title = @"Done";
    }
    else{
        self.editButton = NO;
        editButton.title = @"Edit";
    }
}
- (IBAction)onSwipeGestureRecognizer:(UIGestureRecognizer *)gesture {
    //PROVED
//    self.textField.text = @"Alexey";
    self.swipeCount++;
    CGPoint location = [gesture locationInView:self.listTableView];
    NSIndexPath *swipedIndexPath = [self.listTableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell = [self.listTableView cellForRowAtIndexPath:swipedIndexPath];
    NSArray *colorArray = @[[UIColor redColor], [UIColor yellowColor], [UIColor greenColor], [UIColor whiteColor]];
    for(int i = 0t; i < self.swipeCount%5; i++){
        swipedCell.backgroundColor = colorArray[i];
    }
    
//    UIButton *highButton = [[UIButton alloc]initWithFrame:(0,0,0,0)]
//UITextField *color =[self.listArray objectAtIndex:indexPath.row];
//    color.backgroundColor = [UIColor blueColor];
    
}


@end
