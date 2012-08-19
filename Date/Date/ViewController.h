//
//  ViewController.h
//  Date
//
//  Created by apple on 18.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate>
{
    IBOutlet UITextField *fromField;
    IBOutlet UITextField *toField;
    IBOutlet UITextField *secondsField;
    
    int currentFieldTag;
    NSDate *selectedDate;
    
}

@property (nonatomic,strong) UITextField *fromField;
@property (nonatomic,strong) UITextField *toField;
@property (nonatomic,strong) UITextField *secondsField; 
@property (nonatomic,strong) NSDate *selectedDate;
@property int currentFieldTag;

-(IBAction)selectDate:(id)sender;


@end
