/*
 * Copyright (c) 2016 Spotify AB.
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#import <XCTest/XCTest.h>
#import <SPTPersistentCache/SPTPersistentCacheOptions.h>
#import <SPTPersistentCache/SPTPersistentCacheTypes.h>

@interface SPTPersistentCacheOptionsTests : XCTestCase
@property (nonatomic, strong) SPTPersistentCacheOptions *dataCacheOptions;
@end

@implementation SPTPersistentCacheOptionsTests

- (void)testDefaultInitializer
{
    self.dataCacheOptions = [[SPTPersistentCacheOptions alloc] init];
    
    XCTAssertEqual(self.dataCacheOptions.folderSeparationEnabled, YES);
    XCTAssertEqual(self.dataCacheOptions.gcIntervalSec, SPTPersistentCacheDefaultGCIntervalSec);
    XCTAssertEqual(self.dataCacheOptions.defaultExpirationPeriodSec,
                   SPTPersistentCacheDefaultExpirationTimeSec);
    XCTAssertNotNil(self.dataCacheOptions.cachePath, @"The cache path cannot be nil");
    XCTAssertNotNil(self.dataCacheOptions.cacheIdentifier, @"The cache identifier cannot be nil");
    XCTAssertNotNil(self.dataCacheOptions.identifierForQueue, @"The identifier for queue shouldn't be nil");
}

- (void)testMinimumGarbageColectorInterval
{
    self.dataCacheOptions = [[SPTPersistentCacheOptions alloc] initWithCachePath:nil
                                                                          identifier:nil

                                                                 currentTimeCallback:nil
                                                           defaultExpirationInterval:1
                                                            garbageCollectorInterval:1
                                                                               debug:nil];
    XCTAssertEqual(self.dataCacheOptions.gcIntervalSec,
                   SPTPersistentCacheMinimumGCIntervalLimit);
}

- (void)testMinimumDefaultExpirationInterval
{
    self.dataCacheOptions = [[SPTPersistentCacheOptions alloc] initWithCachePath:nil
                                                                          identifier:nil
                             
                                                                 currentTimeCallback:nil
                                                           defaultExpirationInterval:1
                                                            garbageCollectorInterval:1
                                                                               debug:nil];
    XCTAssertEqual(self.dataCacheOptions.defaultExpirationPeriodSec,
                   SPTPersistentCacheMinimumExpirationLimit);
}


@end
