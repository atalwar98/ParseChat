//
//  LoginViewController.m
//  ParseChat
//
//  Created by atalwar98 on 7/10/19.
//  Copyright © 2019 atalwar98. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *parseUsername;
@property (weak, nonatomic) IBOutlet UITextField *parsePassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)tapSignup:(UIButton *)sender {
    [self registerUser];
}
- (IBAction)tapLogin:(UIButton *)sender {
    [self loginUser];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.parseUsername.text;
    //newUser.email = self.emailField.text;
    newUser.password = self.parsePassword.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            if ([self.parseUsername.text isEqual:@""] || [self.parsePassword.text isEqual:@""]){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unable to Signup"
                                                                               message:@"Please make sure you have entered a username and password."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                
                UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again"
                                                                         style:UIAlertActionStyleCancel
                                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                                           // handle cancel response here. Doing nothing will dismiss the view.
                                                                       }];
                // add the cancel action to the alertController
                [alert addAction:tryAgainAction];
                [self presentViewController:alert animated:YES completion:^{
                    // optional code for what happens after the alert controller has finished presenting
                }];
            }
        } else {
            
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (void)loginUser {
    NSString *username = self.parseUsername.text;
    NSString *password = self.parsePassword.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            if ([self.parseUsername.text isEqual:@""] || [self.parsePassword.text isEqual:@""]){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty Fields"
                                                                               message:@"Please enter your username and password."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                
                UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again"
                                                                         style:UIAlertActionStyleCancel
                                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                                           // handle cancel response here. Doing nothing will dismiss the view.
                                                                       }];
                // add the cancel action to the alertController
                [alert addAction:tryAgainAction];
                [self presentViewController:alert animated:YES completion:^{
                    // optional code for what happens after the alert controller has finished presenting
                }];
            }
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
        
    }];
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
