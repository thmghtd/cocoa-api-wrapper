/*
 * Copyright 2009 Ullrich Schäfer, Gernot Poetsch for SoundCloud Ltd.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 *
 * For more information and documentation refer to
 * http://soundcloud.com/api
 * 
 */

@protocol SCPostBodyStreamMonitorDelegate;

@interface SCPostBodyStream : NSInputStream {
	NSString *boundary;
    NSArray *_contentStreams;
    NSInputStream *_currentStream;
    unsigned _streamIndex;
	
	unsigned long long _numBytesRead;
	unsigned long long _numBytesTotal;

	id<SCPostBodyStreamMonitorDelegate> _monitorDelegate;
}

- (id)initWithParameters:(NSDictionary *)postParameters;

@property (assign) id<SCPostBodyStreamMonitorDelegate> monitorDelegate;
@property (readonly) unsigned long long length;
@property (readonly) NSString *boundary;

@end


@protocol SCPostBodyStreamMonitorDelegate <NSObject>
- (void)stream:(SCPostBodyStream *)stream hasBytesDelivered:(unsigned long long)deliveredBytes total:(unsigned long long)totalBytes;
@end

