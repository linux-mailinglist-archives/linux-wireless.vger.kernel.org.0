Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C6D77F606
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 14:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbjHQMGu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350745AbjHQMGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 08:06:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E12622136
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 05:06:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37HC65Xa8022953, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37HC65Xa8022953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 20:06:05 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 17 Aug 2023 20:06:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 17 Aug 2023 20:06:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 17 Aug 2023 20:06:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "gregory.greenman@intel.com" <gregory.greenman@intel.com>
Subject: Re: [RFC] wifi: mac80211: fix UBSAN warning caused by reorder_buf_filtered bits shift-out-of-bounds
Thread-Topic: [RFC] wifi: mac80211: fix UBSAN warning caused by
 reorder_buf_filtered bits shift-out-of-bounds
Thread-Index: AQHZ0Mx0fntfUGBm7E6lIBAm7nSdWa/tigWAgABUmIA=
Date:   Thu, 17 Aug 2023 12:06:24 +0000
Message-ID: <408e1ca10cb4daabdad0e2760f69a9b03fbeedd3.camel@realtek.com>
References: <20230817053215.51636-1-pkshih@realtek.com>
         <d55de56e2cc69031f1588fc1db981f5bed640348.camel@sipsolutions.net>
In-Reply-To: <d55de56e2cc69031f1588fc1db981f5bed640348.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.88.175]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <E432BA0ACD4DB24895406D435AC4C14F@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTE3IGF0IDA5OjAzICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiANCj4gPiANCj4gPiBJZiBub3QsIHdlIGNhbiBqdXN0DQo+ID4gYWRkIHNvbWUgY29uZGl0aW9u
cyB0byBhdm9pZCBVQlNBTiB3YXJuaW5nIGxpa2UgdGhpcyBwYXRjaC4gT3RoZXJ3aXNlLA0KPiA+
IHRoaXMgUkZDIGNhbid0IGVudGlyZWx5IHJlc29sdmUgdGhlIHByb2JsZW0uDQo+IA0KPiBTZWVt
cyBmaW5lLiBJJ2Qga2luZCBvZiBwcm9iYWJseSBub3Qgd29yZCBpdCBhcyAiZml4IFVCU0FOIiBz
aW5jZSByZWFsbHkNCj4gaXQncyBqdXN0IG1vcmUgYWxvbmcgdGhlIGxpbmVzIG9mICJ3YXJuIGlm
IEFQSSBpcyBtaXN1c2VkIj8gOikNCg0KTWF5YmUsIGNvbWJpbmUgdHdvPyBCZWNhdXNlIEkgd2Fu
dCB0byBhdm9pZCBVQlNBTiB3YXJuaW5nIGluaXRpYWxseS4gDQoNCj4gDQo+ID4gU2luY2Ugb25s
eSBvbGQgaGFyZHdhcmUgd2l0aCA2NCBvciBsZXNzIFJYIGFnZ3JlZ2F0aW9uIGZyYW1lcyB1c2Vz
DQo+ID4gaWVlZTgwMjExX21hcmtfcnhfYmFfZmlsdGVyZWRfZnJhbWVzKCksIGFkZCBhIFdBUk5f
T05DRSgpIGFuZCBjb21tZW50IHRvDQo+ID4gbm90ZSB0byBhdm9pZCB1c2luZyB0aGlzIGZ1bmN0
aW9uIGlmIGhhcmR3YXJlIGNhcGFiaWxpdHkgaXMgbm90IHN1aXRhYmxlLg0KPiA+IA0KPiA+IENj
OiA8U3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gDQo+IEkgZG9uJ3QgcmVhbGx5IHRoaW5rIHRo
aXMgaXMgc3RhYmxlIG1hdGVyaWFsIC0gaWYgdGhlcmUncyBhIGRyaXZlcg0KPiB0aGF0J3MgY2Fs
bGluZyB0aGlzIHdoZW4gPjY0IGZyYW1lcyBpcyBzdXBwb3J0ZWQgdGhlbiBpdCdzIGEgZHJpdmVy
IGJ1Zw0KPiB0aGF0IHNob3VsZCBiZSBmaXhlZCwgYW5kIGlmIG5vdCB0aGVuIHRoZXJlJ3Mgbm8g
YnVnPw0KDQpJJ2xsIHJlbW92ZSB0aGlzLiANCg0KPiANCj4gPiArKysgYi9uZXQvbWFjODAyMTEv
cnguYw0KPiA+IEBAIC0xMDgzLDcgKzEwODMsOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaWVlZTgw
MjExX3J4X3Jlb3JkZXJfcmVhZHkoc3RydWN0IHRpZF9hbXBkdV9yeA0KPiA+ICp0aWRfYWdnX3J4
LA0KPiA+ICAgICAgIHN0cnVjdCBza19idWZmICp0YWlsID0gc2tiX3BlZWtfdGFpbChmcmFtZXMp
Ow0KPiA+ICAgICAgIHN0cnVjdCBpZWVlODAyMTFfcnhfc3RhdHVzICpzdGF0dXM7DQo+ID4gDQo+
ID4gLSAgICAgaWYgKHRpZF9hZ2dfcngtPnJlb3JkZXJfYnVmX2ZpbHRlcmVkICYgQklUX1VMTChp
bmRleCkpDQo+ID4gKyAgICAgaWYgKHRpZF9hZ2dfcngtPnJlb3JkZXJfYnVmX2ZpbHRlcmVkICYm
DQo+ID4gKyAgICAgICAgIHRpZF9hZ2dfcngtPnJlb3JkZXJfYnVmX2ZpbHRlcmVkICYgQklUX1VM
TChpbmRleCkpDQo+ID4gICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gDQo+IE9yIG1heWJl
IG5vIC0gdGhpcyBwYXJ0IGlzIHdoYXQgeW91IHRoaW5rIHNob3VsZCBiZQ0KDQpUaGlzIGZ1bmN0
aW9uIHdpbGwgYmUgY2FsbGVkIGJ5IGFsbCBkcml2ZXJzIHRoYXQgcmVseSBvbiBtYWM4MDIxMSdz
IHJ4IHJlb3JkZXJpbmcuIA0KVGhlIFVCU0FOIGZpbmQgYGluZGV4YCBvZiBgQklUX1VMTChpbmRl
eClgIGNvdWxkIGJlIG92ZXIgNjQsIGZvciBleGFtcGxlDQppbmRleD0yMTUgd2hlbiBJIHNldCBo
dy5tYXhfcnhfYWdncmVnYXRpb25fc3ViZnJhbWVzIHRvIDI1Ni4gVGhpcyBpcyBpbml0aWFsDQpw
cm9ibGVtIEkgd2FudCB0byBmaXguDQoNClRoZSBgdGlkX2FnZ19yeC0+cmVvcmRlcl9idWZfZmls
dGVyZWQgIT0gMGAgbWVhbnMgaHcubWF4X3J4X2FnZ3JlZ2F0aW9uX3N1YmZyYW1lcyA8PSA2NA0K
KGFzIHdlbGwgYXMgaW5kZXggPD0gNjQpIGltcGxpY2l0bHksIGJlY2F1c2Ugb25seSB0aGlzIGtp
bmQgb2YgaGFyZHdhcmUgY2FuIGNhbGwNCmllZWU4MDIxMV9tYXJrX3J4X2JhX2ZpbHRlcmVkX2Zy
YW1lcygpLiBNYXliZSwgYmVsb3cgd291bGQgYmUgaW50dWl0aXZlLCBidXQNCkkgd29ycnkgaXQg
aGlkZXMgcHJvYmxlbSB0aGF0IFVCU0FOIGNhbid0IGZpbmQuDQoNCiAgICBpZiAoaW5kZXggPCA2
NCAmJiB0aWRfYWdnX3J4LT5yZW9yZGVyX2J1Zl9maWx0ZXJlZCAmIEJJVF9VTEwoaW5kZXgpKQ0K
ICAgICAgICAgIHJldHVybiB0cnVlOw0KDQpBbnkgc3VnZ2VzdGlvbj8gb3IgcHJlZmVyPw0KDQo+
IA0KPiA+ICAgICAgIGlmICghdGFpbCkNCj4gPiBAQCAtMTEyNCw3ICsxMTI1LDggQEAgc3RhdGlj
IHZvaWQgaWVlZTgwMjExX3JlbGVhc2VfcmVvcmRlcl9mcmFtZShzdHJ1Y3QgaWVlZTgwMjExX3N1
Yl9pZl9kYXRhDQo+ID4gKnNkYXRhLA0KPiA+ICAgICAgIH0NCj4gPiANCj4gPiAgbm9fZnJhbWU6
DQo+ID4gLSAgICAgdGlkX2FnZ19yeC0+cmVvcmRlcl9idWZfZmlsdGVyZWQgJj0gfkJJVF9VTEwo
aW5kZXgpOw0KPiA+ICsgICAgIGlmICh0aWRfYWdnX3J4LT5yZW9yZGVyX2J1Zl9maWx0ZXJlZCkN
Cj4gPiArICAgICAgICAgICAgIHRpZF9hZ2dfcngtPnJlb3JkZXJfYnVmX2ZpbHRlcmVkICY9IH5C
SVRfVUxMKGluZGV4KTsNCj4gDQo+IEFuZCB0aGlzLg0KDQpUaGUgc2FtZSBhcyBhYm92ZS4gDQoN
Cg0KVGhhbmsgeW91DQpQaW5nLUtlDQoNCg==
