Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCB13677E6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhDVD20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 23:28:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48960 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhDVD2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 23:28:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13M3RjwI6030964, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13M3RjwI6030964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 11:27:45 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 11:27:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 11:27:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Thu, 22 Apr 2021 11:27:42 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Pkshih <pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Topic: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Index: AQHXHILhha+rxT9tC0u1Umog2SASfaquqNkAgAGcrsCAD6BXQA==
Date:   Thu, 22 Apr 2021 03:27:42 +0000
Message-ID: <b7814d48ad3740a0a29439c81cf5b1bf@realtek.com>
References: <20210319054218.3319-3-pkshih@realtek.com>
 <20210411092102.40EE7C43461@smtp.codeaurora.org>
 <632d2ab7679145eab8e1f498b9b12ceb@realtek.com>
In-Reply-To: <632d2ab7679145eab8e1f498b9b12ceb@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjEg5LiL5Y2IIDExOjIzOjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/22/2021 03:12:59
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163276 [Apr 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/22/2021 03:16:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/22/2021 03:12:59
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163276 [Apr 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/22/2021 03:16:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBrc2hpaCBbbWFpbHRvOnBr
c2hpaEByZWFsdGVrLmNvbV0NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMiwgMjAyMSA0OjExIFBN
DQo+IFRvOiBLYWxsZSBWYWxvDQo+IENjOiB0b255MDYyMGVtbWFAZ21haWwuY29tOyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IERlYW5LdTsgQmVybmllIEh1YW5nOyBTaGFvZnU7IFN0
ZXZlbiBUaW5nOw0KPiBLZXZpbiBZYW5nDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi83XSBydHc4
ODogZm9sbG93IHRoZSBBUCBiYXNpYyByYXRlcyBmb3IgdHggbWdtdCBmcmFtZQ0KPiANCj4gDQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBrdmFsbz1jb2RlYXVyb3Jh
Lm9yZ0BtZy5jb2RlYXVyb3JhLm9yZyBbbWFpbHRvOmt2YWxvPWNvZGVhdXJvcmEub3JnQG1nLmNv
ZGVhdXJvcmEub3JnXSBPbg0KPiA+IEJlaGFsZiBPZiBLYWxsZSBWYWxvDQo+ID4gU2VudDogU3Vu
ZGF5LCBBcHJpbCAxMSwgMjAyMSA1OjIxIFBNDQo+ID4gVG86IFBrc2hpaA0KPiA+IENjOiB0b255
MDYyMGVtbWFAZ21haWwuY29tOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IERlYW5L
dTsgQmVybmllIEh1YW5nOyBTaGFvZnU7IFN0ZXZlbg0KPiBUaW5nOw0KPiA+IEtldmluIFlhbmcN
Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvN10gcnR3ODg6IGZvbGxvdyB0aGUgQVAgYmFzaWMg
cmF0ZXMgZm9yIHR4IG1nbXQgZnJhbWUNCj4gPg0KPiA+IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gRnJvbTogU2hhby1GdSBDaGVuZyA8c2hhb2Z1
QHJlYWx0ZWsuY29tPg0KPiA+ID4NCj4gPiA+IEJ5IGRlZmF1bHQgdGhlIGRyaXZlciB1c2VzIHRo
ZSAxTSBhbmQgNk0gcmF0ZSBmb3IgbWFuYWdlbW50IGZyYW1lcw0KPiA+ID4gaW4gMkcgYW5kIDVH
IGJhbmRzIHJlc3BlY3RpdmVseS4gQnV0IHdoZW4gdGhlIGJhc2ljIHJhdGVzIGlzIGNvbmZpZ3Vy
ZWQNCj4gPiA+IGZyb20gdGhlIG1hYzgwMjExLCB3ZSBuZWVkIHRvIHNlbmQgdGhlIG1hbmFnZW1l
bnQgZnJhbWVzIGFjY29yZGluZyB0aGUNCj4gPiA+IGJhc2ljIHJhdGVzLg0KPiA+ID4NCj4gPiA+
IFRoaXMgY29tbWl0IG1ha2VzIHRoZSBkcml2ZXIgdXNlIHRoZSBsb3dlc3QgYmFzaWMgcmF0ZXMg
dG8gc2VuZA0KPiA+ID4gdGhlIG1hbmFnZW1lbnQgZnJhbWVzIGFuZCBhIGRlYnVmcyBlbnRyeSB0
byBlbmFibGUvZGlzYWJsZSBmb3JjZSB0byB1c2UNCj4gPiA+IHRoZSBsb3dlc3QgcmF0ZSAxTS82
TSBmb3IgMi40Ry81RyBiYW5kcy4NCj4gPiA+DQo+ID4gPiBvYnRhaW4gY3VycmVudCBzZXR0aW5n
DQo+ID4gPiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeVgvcnR3ODgvYmFzaWNf
cmF0ZXMNCj4gPiA+DQo+ID4gPiBmb3JjZSBsb3dlc3QgcmF0ZToNCj4gPiA+IGVjaG8gMSA+IC9z
eXMva2VybmVsL2RlYnVnL2llZWU4MDIxMS9waHlYL3J0dzg4L2Jhc2ljX3JhdGVzDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogU2hhby1GdSBDaGVuZyA8c2hhb2Z1QHJlYWx0ZWsuY29tPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogWXUtWWVuIFRpbmcgPHN0ZXZlbnRpbmdAcmVhbHRlay5jb20+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cj4gPg0KPiA+IFdoeSBpcyBhIGRlYnVnZnMgaW50ZXJmYWNlIG5lZWRlZD8NCj4gPg0KPiANCj4g
QnkgZGVmYXVsdCwgZHJpdmVyIGZvbGxvd3MgQVAncyBiYXNpYyByYXRlcyB0aGF0IG1heSBiZSAy
NE0gYW5kIGFib3ZlLCBhbmQNCj4gZG9lcyBhc3NvY2lhdGlvbiB3aXRoIDI0TSByYXRlLiBJZiBB
UCBpcyBmYXIgYXdheSwgaXQgbWF5IGJlIGhhcmQgdG8gY29tbXVuaWNhdGUNCj4gd2l0aCAyNE0g
cmF0ZS4gVGhlcmVmb3JlLCB3ZSBhZGQgYSBkZWJ1Z2ZzIHRvIGFsbG93IGRyaXZlciB0byBzZW5k
IG1hbmFnZW1lbnQNCj4gZnJhbWVzIHdpdGggbG93IHJhdGUgNk0gb3IgMU0uDQo+IA0KDQpJZiBh
biBBUCBpcyBjb25maWd1cmVkIGJhc2ljIHJhdGUgMjRNIG9yIGFib3ZlLCBJIHRoaW5rIHRoZSBJ
VCB3YW50cyBTVEEgZm9sbG93cw0KdGhlIHJhdGVzLiBJZiB3ZSBoYXZlIGFuIGludGVyZmFjZSBm
b3Igbm9ybWFsIHVzZXJzLCBpdCB3aWxsIGJyZWFrIHRoZSBJVCdzIGRlc2lyZS4NClNvLCB3ZSB1
c2UgYSBkZWJ1Z2ZzIHRvIGhlbHAgcmVtb3RlIGRlYnVnIG9ubHksIGluIGNhc2UgdXNlciByZXBv
cnRzIGhlIGNhbid0DQpjb25uZWN0IHRvIGFuIEFQIHdpdGggbG93IFJTU0kuDQoNCkkgdGhpbmsg
aXQncyB3b3J0aCB0aGF0IGRyaXZlciBjYW4gZm9sbG93IEFQJ3MgYmFzaWMgcmF0ZSwgc28gSSBt
YWtlIGl0IGFzIGFuDQppbmRpdmlkdWFsIHBhdGNoOyBkZWJ1Z2ZzIGFzIHNlY29uZCBvbmUuIElm
IHlvdSBuZWVkIHRvIHRoaW5rIGlmIGRlYnVnZnMgaXMgbmVjZXNzYXJ5LA0KSSBob3BlIHdlIGNh
biBsYW5kIHRoZSBmaXJzdCBwYXRjaCBmaXJzdC4NCg0KVGhlIHBhdGNoc2V0IGlzIHNlbnQNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjEwNDIyMDMwNDEzLjk3Mzgt
MS1wa3NoaWhAcmVhbHRlay5jb20vVC8jdA0KDQotLQ0KUGluZy1LZQ0KDQoNCg==
