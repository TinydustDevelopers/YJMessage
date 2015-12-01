# YJMessage

A library that displays message in iOS app with Android Snackbar-like style.

## Demo

![demo.gif](./images/demo.gif)

## Installation

Add the following line in your Podfile:

```
pod "YJMessage"
```

## Usage

The usage is simple, similar to TSMessages.

```objective-c
// basic
[YJMessage showMessageInViewController:self
                                     title:@"Hi, there"
                                  duration:1.5f
                                      type:YJMessageTypeInfo];

// show message with completion callback
[YJMessage showMessageInViewController:self
                                    title:@"hi, there"
                                 duration:1.5f
                                     type:YJMessageTypeInfo
                                 callback:^() {
                                     NSLog(@"message showed");
                                 }];

// show message with a button
[YJMessage showMessageInViewController:self
                                     title:@"hey, error!"
                                  duration:1.5f
                                      type:YJMessageTypeInfo
                                  callback:nil
                               buttonTitle:@"tap me"
                            buttonCallback:^{
                                NSLog(@"Tapped.");
                            }];
```

## YJMessageType

### YJMessageTypeInfo

![message_info.png](./images/message_info.png)

### YJMessageTypeError

![mesage_error.png](./images/message_error.png)

### YJMessageTypeSuccess

![message_sucess.png](./images/message_sucess.png)

### YJMessageTypeWarning

![message_warnning.png](./images/message_warnning.png)
