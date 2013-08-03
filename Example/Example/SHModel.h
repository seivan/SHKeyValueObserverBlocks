//
//  SHModel.h
//  Example
//
//  Created by Seivan Heidari on 8/2/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

@interface SHBackPack : NSObject
@property(nonatomic,strong) NSMutableArray * items;
@end


@interface SHPocket : NSObject
@property(nonatomic,strong) NSMutableSet * items;
@end



@interface SHPlayer : NSObject
@property(nonatomic,strong) SHBackPack * backPackArray;
@property(nonatomic,strong) SHPocket   * pocketSet;
@end

