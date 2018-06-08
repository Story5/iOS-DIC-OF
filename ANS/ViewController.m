//
//  ViewController.m
//  ANS
//
//  Created by Story5 on 2018/6/8.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIDocumentInteractionController *documentController;
@property (nonatomic,strong) NSString *file;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.delegate = self;
    self.file = @"dwg";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.file = textField.text;
    NSLog(@"文件类型为:%@",self.file);
    [self.dicButton setTitle:[NSString stringWithFormat:@"打开%@文件",self.file] forState:UIControlStateNormal];    
}

- (IBAction)AppleNativeShare:(id)sender {
    NSString *name = self.file;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:name]];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:name];
    NSLog(@"%@",url);
    [self dic:url];
}

- (void)dic:(NSURL *)url {
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
    self.documentController.delegate = self;
    
    //    [self presentOpenInMenu];
    
    [self presentOptionsMenu];
    
    //    [self presentPreview];
}

#pragma mark -
#pragma mark private

- (void)presentPreview
{
    // display PDF contents by Quick Look framework
    [self.documentController presentPreviewAnimated:YES];
}

- (void)presentOpenInMenu
{
    // display third-party apps
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

- (void)presentOptionsMenu
{
    // display third-party apps as well as actions, such as Copy, Print, Save Image, Quick Look
    [_documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

#pragma mark -
#pragma mark UIDocumentInteractionControllerDelegate

// If preview is supported, this provides the view controller on which the preview will be presented.
// This method is required if preview is supported.
// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform.
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return  self;
}

// Synchronous.  May be called when inside preview.  Usually followed by app termination.  Can use willBegin... to set annotation.
- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(nullable NSString *)application{
    NSLog(@"%s",__func__);
    NSLog(@"%@",application);
}     // bundle ID
- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(nullable NSString *)application
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",application);
}
@end
