//
//  ViewController.m
//  Date
//
//  Created by apple on 18.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize fromField;
@synthesize toField;
@synthesize secondsField;
@synthesize currentFieldTag;
@synthesize selectedDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDate:[NSDate date] toFieldWithTag:100];
    [self setDate:[NSDate date] toFieldWithTag:101];
    
    [self setSeconds];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)setDate:(NSDate*)date toFieldWithTag:(int)tag
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    switch (tag) 
    {
        case 100:
             self.fromField.text=[formatter stringFromDate:date];
            break;
        case 101:
            self.toField.text=[formatter stringFromDate:date];
            break;
            
        default:
            break;
    }
    
}

-(NSDate*)dateFromFieldWihtTag:(int)tag
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSDate *date=nil;
    
    switch (tag) 
    {
        case 100:
            date=[formatter dateFromString:self.fromField.text];
            break;
        case 101:
            date=[formatter dateFromString:self.toField.text];
            break;
            
        default:
            break;
    }
    
    return date; 
    
}


-(void)selectDate:(UIButton*)sender
{
    self.currentFieldTag=sender.tag;
    self.selectedDate=[self dateFromFieldWihtTag:self.currentFieldTag];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Select", nil];
    actionSheet.delegate=self;
    [actionSheet showInView:[self.view superview]];
    [actionSheet setFrame:CGRectMake(0, 170, 320, 315)];
    
}
#pragma mark DateMethods

-(void)setSeconds
{
    
    NSDate *from=[self dateFromFieldWihtTag:100];
    
    NSDate *to=[self dateFromFieldWihtTag:101];
    
    unsigned int unitFlags = NSSecondCalendarUnit;
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:from  toDate:to  options:0];
    
    
    self.secondsField.text=[NSString stringWithFormat:@"%d",comps.second];
}

-(void)setDateToField
{
       NSDate *from=[self dateFromFieldWihtTag:100]; 
       NSDate *to=[from dateByAddingTimeInterval:self.secondsField.text.intValue];
       [self setDate:to toFieldWithTag:101];
    
}



#pragma mark DatePicker

-(void)changeDate:(UIDatePicker*)picker
{
    [self setDate:picker.date toFieldWithTag:self.currentFieldTag];
    
}

#pragma mark ActionSheetDelegate


- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
    picker.datePickerMode=UIDatePickerModeDate;
    [picker setDate:[self dateFromFieldWihtTag:self.currentFieldTag]];
    [picker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:picker];
    
    
    NSArray *subviews = [actionSheet subviews];
    [[subviews objectAtIndex:1] setFrame:CGRectMake(20, 218, 280, 44)];
    [[subviews objectAtIndex:2] setFrame:CGRectMake(20, 267, 280, 44)];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {  
        [self setSeconds];  
    }
    if (buttonIndex==1)
    {
        [self setDate:self.selectedDate toFieldWithTag:self.currentFieldTag];

    }
}

#pragma  mark TextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setDateToField];  
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;

}


@end
