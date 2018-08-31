//
//  RDetailViewController.m
//  OneApp
//
//  Created by lijunjie on 30/08/2018.
//  Copyright © 2018 lijunjie. All rights reserved.
//

#import "RDetailViewController.h"
#import "BImageStore.h"
@interface RDetailViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation RDetailViewController
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker  animated:YES completion:nil];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.aImageView.image = image;
    [[BImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(id) init {
    self = [super init];
    if(self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"DetailView";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    RItem *item = self.item;
    self.nameField.text = item._itemName;
    self.serialField.text = item._serialNumber;
    self.valueField.text = [ NSString stringWithFormat:@"%d",item._valueInDollars];
    UIImage *image = [[ BImageStore sharedStore] imageForKey:item.itemKey];
    if(image) {
        self.aImageView.image = image;
    }
    
    
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    RItem *item = self.item;
    item._itemName = self.nameField.text;
    item._serialNumber = self.serialField.text;
    item._valueInDollars = [self.valueField.text intValue];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
