Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9847B388711
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 08:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhESGBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 02:01:24 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59875 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhESGBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 02:01:22 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14J5xsXjB006077, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14J5xsXjB006077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 May 2021 13:59:54 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 19 May 2021 13:59:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 19 May 2021 13:59:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Wed, 19 May 2021 13:59:52 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Topic: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Index: AQHXHILhha+rxT9tC0u1Umog2SASfaquqNkAgAGcrsCAD6BXQIAqmmsg
Date:   Wed, 19 May 2021 05:59:52 +0000
Message-ID: <557e330fcb1a4d79a6aa4c24333247a8@realtek.com>
References: <20210319054218.3319-3-pkshih@realtek.com>
 <20210411092102.40EE7C43461@smtp.codeaurora.org>
 <632d2ab7679145eab8e1f498b9b12ceb@realtek.com>
 <b7814d48ad3740a0a29439c81cf5b1bf@realtek.com>
In-Reply-To: <b7814d48ad3740a0a29439c81cf5b1bf@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvMTkg5LiK5Y2IIDAyOjQ0OjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/19/2021 05:43:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163738 [May 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/19/2021 05:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGtzaGloDQo+IFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAyMiwgMjAyMSAxMToyOCBBTQ0KPiBUbzogUGtzaGloOyBLYWxsZSBW
YWxvDQo+IENjOiB0b255MDYyMGVtbWFAZ21haWwuY29tOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtl
cm5lbC5vcmc7IERlYW5LdTsgQmVybmllIEh1YW5nOyBTaGFvZnU7IFN0ZXZlbiBUaW5nOw0KPiBL
ZXZpbiBZYW5nDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi83XSBydHc4ODogZm9sbG93IHRoZSBB
UCBiYXNpYyByYXRlcyBmb3IgdHggbWdtdCBmcmFtZQ0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQa3NoaWggW21haWx0bzpwa3NoaWhAcmVhbHRlay5j
b21dDQo+ID4gU2VudDogTW9uZGF5LCBBcHJpbCAxMiwgMjAyMSA0OjExIFBNDQo+ID4gVG86IEth
bGxlIFZhbG8NCj4gPiBDYzogdG9ueTA2MjBlbW1hQGdtYWlsLmNvbTsgbGludXgtd2lyZWxlc3NA
dmdlci5rZXJuZWwub3JnOyBEZWFuS3U7IEJlcm5pZSBIdWFuZzsgU2hhb2Z1OyBTdGV2ZW4NCj4g
VGluZzsNCj4gPiBLZXZpbiBZYW5nDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCAyLzddIHJ0dzg4
OiBmb2xsb3cgdGhlIEFQIGJhc2ljIHJhdGVzIGZvciB0eCBtZ210IGZyYW1lDQo+ID4NCj4gPg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IGt2YWxvPWNvZGVh
dXJvcmEub3JnQG1nLmNvZGVhdXJvcmEub3JnIFttYWlsdG86a3ZhbG89Y29kZWF1cm9yYS5vcmdA
bWcuY29kZWF1cm9yYS5vcmddIE9uDQo+ID4gPiBCZWhhbGYgT2YgS2FsbGUgVmFsbw0KPiA+ID4g
U2VudDogU3VuZGF5LCBBcHJpbCAxMSwgMjAyMSA1OjIxIFBNDQo+ID4gPiBUbzogUGtzaGloDQo+
ID4gPiBDYzogdG9ueTA2MjBlbW1hQGdtYWlsLmNvbTsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJu
ZWwub3JnOyBEZWFuS3U7IEJlcm5pZSBIdWFuZzsgU2hhb2Z1OyBTdGV2ZW4NCj4gPiBUaW5nOw0K
PiA+ID4gS2V2aW4gWWFuZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzddIHJ0dzg4OiBm
b2xsb3cgdGhlIEFQIGJhc2ljIHJhdGVzIGZvciB0eCBtZ210IGZyYW1lDQo+ID4gPg0KPiA+ID4g
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4g
RnJvbTogU2hhby1GdSBDaGVuZyA8c2hhb2Z1QHJlYWx0ZWsuY29tPg0KPiA+ID4gPg0KPiA+ID4g
PiBCeSBkZWZhdWx0IHRoZSBkcml2ZXIgdXNlcyB0aGUgMU0gYW5kIDZNIHJhdGUgZm9yIG1hbmFn
ZW1udCBmcmFtZXMNCj4gPiA+ID4gaW4gMkcgYW5kIDVHIGJhbmRzIHJlc3BlY3RpdmVseS4gQnV0
IHdoZW4gdGhlIGJhc2ljIHJhdGVzIGlzIGNvbmZpZ3VyZWQNCj4gPiA+ID4gZnJvbSB0aGUgbWFj
ODAyMTEsIHdlIG5lZWQgdG8gc2VuZCB0aGUgbWFuYWdlbWVudCBmcmFtZXMgYWNjb3JkaW5nIHRo
ZQ0KPiA+ID4gPiBiYXNpYyByYXRlcy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBjb21taXQgbWFr
ZXMgdGhlIGRyaXZlciB1c2UgdGhlIGxvd2VzdCBiYXNpYyByYXRlcyB0byBzZW5kDQo+ID4gPiA+
IHRoZSBtYW5hZ2VtZW50IGZyYW1lcyBhbmQgYSBkZWJ1ZnMgZW50cnkgdG8gZW5hYmxlL2Rpc2Fi
bGUgZm9yY2UgdG8gdXNlDQo+ID4gPiA+IHRoZSBsb3dlc3QgcmF0ZSAxTS82TSBmb3IgMi40Ry81
RyBiYW5kcy4NCj4gPiA+ID4NCj4gPiA+ID4gb2J0YWluIGN1cnJlbnQgc2V0dGluZw0KPiA+ID4g
PiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeVgvcnR3ODgvYmFzaWNfcmF0ZXMN
Cj4gPiA+ID4NCj4gPiA+ID4gZm9yY2UgbG93ZXN0IHJhdGU6DQo+ID4gPiA+IGVjaG8gMSA+IC9z
eXMva2VybmVsL2RlYnVnL2llZWU4MDIxMS9waHlYL3J0dzg4L2Jhc2ljX3JhdGVzDQo+ID4gPiA+
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW8tRnUgQ2hlbmcgPHNoYW9mdUByZWFsdGVrLmNv
bT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXUtWWVuIFRpbmcgPHN0ZXZlbnRpbmdAcmVhbHRl
ay5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPg0KPiA+ID4NCj4gPiA+IFdoeSBpcyBhIGRlYnVnZnMgaW50ZXJmYWNlIG5lZWRlZD8N
Cj4gPiA+DQo+ID4NCj4gPiBCeSBkZWZhdWx0LCBkcml2ZXIgZm9sbG93cyBBUCdzIGJhc2ljIHJh
dGVzIHRoYXQgbWF5IGJlIDI0TSBhbmQgYWJvdmUsIGFuZA0KPiA+IGRvZXMgYXNzb2NpYXRpb24g
d2l0aCAyNE0gcmF0ZS4gSWYgQVAgaXMgZmFyIGF3YXksIGl0IG1heSBiZSBoYXJkIHRvIGNvbW11
bmljYXRlDQo+ID4gd2l0aCAyNE0gcmF0ZS4gVGhlcmVmb3JlLCB3ZSBhZGQgYSBkZWJ1Z2ZzIHRv
IGFsbG93IGRyaXZlciB0byBzZW5kIG1hbmFnZW1lbnQNCj4gPiBmcmFtZXMgd2l0aCBsb3cgcmF0
ZSA2TSBvciAxTS4NCj4gPg0KPiANCj4gSWYgYW4gQVAgaXMgY29uZmlndXJlZCBiYXNpYyByYXRl
IDI0TSBvciBhYm92ZSwgSSB0aGluayB0aGUgSVQgd2FudHMgU1RBIGZvbGxvd3MNCj4gdGhlIHJh
dGVzLiBJZiB3ZSBoYXZlIGFuIGludGVyZmFjZSBmb3Igbm9ybWFsIHVzZXJzLCBpdCB3aWxsIGJy
ZWFrIHRoZSBJVCdzIGRlc2lyZS4NCj4gU28sIHdlIHVzZSBhIGRlYnVnZnMgdG8gaGVscCByZW1v
dGUgZGVidWcgb25seSwgaW4gY2FzZSB1c2VyIHJlcG9ydHMgaGUgY2FuJ3QNCj4gY29ubmVjdCB0
byBhbiBBUCB3aXRoIGxvdyBSU1NJLg0KPiANCj4gSSB0aGluayBpdCdzIHdvcnRoIHRoYXQgZHJp
dmVyIGNhbiBmb2xsb3cgQVAncyBiYXNpYyByYXRlLCBzbyBJIG1ha2UgaXQgYXMgYW4NCj4gaW5k
aXZpZHVhbCBwYXRjaDsgZGVidWdmcyBhcyBzZWNvbmQgb25lLiBJZiB5b3UgbmVlZCB0byB0aGlu
ayBpZiBkZWJ1Z2ZzIGlzIG5lY2Vzc2FyeSwNCj4gSSBob3BlIHdlIGNhbiBsYW5kIHRoZSBmaXJz
dCBwYXRjaCBmaXJzdC4NCj4gDQo+IFRoZSBwYXRjaHNldCBpcyBzZW50DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjEwNDIyMDMwNDEzLjk3MzgtMS1wa3NoaWhA
cmVhbHRlay5jb20vVC8jdA0KPiANCg0KR2VudGxlIHBpbmcuIFNpbmNlIHRoZSBzdGF0ZSBvZiBw
YXRjaCB2MiBpcyBzdGlsbCBOZXcgaW4gcGF0Y2h3b3JrLCBJJ2QgbGlrZSB0byANCmtub3cgaWYg
dGhlcmUncyBzb21ldGhpbmcgSSBuZWVkIHRvIGRvIGZvciB0aGlzIHBhdGNoLCBvciBJIGp1c3Qg
d2FpdCBmb3IgcmV2aWV3aW5nLg0KDQpUaGFuayB5b3UNCi0tDQpQaW5nLUtlDQoNCg0K
