//
//  SHModel.h
//  Sample
//
//  Created by Seivan Heidari on 2013-12-27.
//  Copyright (c) 2013 Seivan. All rights reserved.
//

@interface SHKeyValueObserverTestManager : NSObject
@property(nonatomic,assign) BOOL isSuperDealloced;
@property(nonatomic,assign) BOOL isSubDealloced;
@end

@interface SHKeyValueObserverDeallocationSuperVerifier : NSObject
@property(nonatomic, strong) SHKeyValueObserverTestManager *testManager;
@property(nonatomic,strong) NSString *testProperty;
@end


@interface SHKeyValueObserverDeallocationSubVerifier : SHKeyValueObserverDeallocationSuperVerifier
@end



@interface SHModel : NSObject
@property(nonatomic,strong) NSOrderedSet          * playersOrderedSet;
@property(nonatomic,strong) NSSet                 * playersSet;
@property(nonatomic,strong) NSArray               * playersArray;
@property(nonatomic,strong) NSMutableDictionary   * playersDictionary;

@property(nonatomic,strong) NSMutableString * gender;
@property(nonatomic,strong) NSNumber        * age;
@property(nonatomic,strong) NSString        * name;
@property(nonatomic,assign) CGSize            size;
@property(nonatomic,assign) BOOL              isDead;
@end


@interface SHSubModel : SHModel
@property(nonatomic,strong) NSArray   * subModelStuff;
@end
