#SHKeyValueObserverBlocks

[![Build Status](https://travis-ci.org/seivan/SHKeyValueObserverBlocks.png?branch=master)](https://travis-ci.org/seivan/SHKeyValueObserverBlocks)
[![Version](http://cocoapod-badges.herokuapp.com/v/SHKeyValueObserverBlocks/badge.png)](http://cocoadocs.org/docsets/SHKeyValueObserverBlocks)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SHKeyValueObserverBlocks/badge.png)](http://cocoadocs.org/docsets/SHKeyValueObserverBlocks)

> This pod is used by [`SHFoundationAdditions`](https://github.com/seivan/SHFoundationAdditions) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

##Overview

Key Value Observing with blocks on top of NSObject.
Blocks are hold with a weak reference so you don't have to cleanup when your object is gone.

 * No need to clean up after - Blocks and observers are self maintained.
 * Weak referenced blocks.
 * Prefixed selectors.
 * Works with existing codebase that uses old fashioned observing delegate calls. 
 * Configurable to remove the swizzled auto cleanup
 * Remove blocks by keypaths or identifiers
 * Remove blocks by keypaths and identifiers
 * Minimum clutter on top of the public interface. 

##Installation

```ruby
pod 'SHKeyValueObserverBlocks'
```


##Setup

Put this either in specific files or your project prefix file
```objective-c
#import "NSObject+SHKeyValueObserverBlocks.h"

```
or
```objective-c
#import "SHKeyValueObserverBlocks.h"
```

##API

```objective-c
#pragma mark - Block Defs

typedef void (^SHKeyValueObserverBlock)(id weakSelf, NSString *keyPath, NSDictionary *change);

@interface NSObject (SHKeyValueObserverBlocks)

#pragma mark - Configuration

+(BOOL)SH_isAutoRemovingObservers;
+(void)SH_setAutoRemovingObservers:(BOOL)shouldRemoveObservers;




#pragma mark - Add Observers

-(NSString *)SH_addObserverForKeyPaths:(NSArray *)theKeyPaths
                                 block:(SHKeyValueObserverBlock)theBlock;

-(NSString *)SH_addObserverForKeyPaths:(NSArray *)theKeyPaths
                           withOptions:(NSKeyValueObservingOptions)theOptions
                                 block:(SHKeyValueObserverBlock)theBlock;



#pragma mark - Helpers
-(BOOL)SH_handleObserverForKeyPath:(NSString *)theKeyPath
                        withChange:(NSDictionary *)theChange
                           context:(void *)context;



#pragma mark - Remove Observers
-(void)SH_removeObserversForKeyPaths:(NSArray *)theKeyPaths
                         withIdentifiers:(NSArray *)theIdentifiers;

-(void)SH_removeObserversWithIdentifiers:(NSArray *)theIdentifiers;

-(void)SH_removeObserversForKeyPaths:(NSArray *)theKeyPaths;

-(void)SH_removeAllObservers;

```


##Contact

If you end up using SHKeyValueObserverBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHKeyValueObserverBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHKeyValueObserverBlocks/blob/master/LICENSE.md) file.
