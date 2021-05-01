Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE537048F
	for <lists+linux-wireless@lfdr.de>; Sat,  1 May 2021 02:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhEAAz4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Apr 2021 20:55:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35419 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEAAzz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Apr 2021 20:55:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1410sxIT3023975, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1410sxIT3023975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 1 May 2021 08:54:59 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 1 May 2021 08:54:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 1 May 2021 08:54:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Sat, 1 May 2021 08:54:58 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "briannorris@chromium.org" <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH v4 13/19] rtw89: 8852a: add 8852a specific files
Thread-Topic: [PATCH v4 13/19] rtw89: 8852a: add 8852a specific files
Thread-Index: AQHXPM49PxtB+Doz90uTeXPis0u1MKrLeI8AgAAqjICAABuvAIABirEA
Date:   Sat, 1 May 2021 00:54:57 +0000
Message-ID: <1619830496.1798.14.camel@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
         <20210429080149.7068-14-pkshih@realtek.com> <YIsg3iv6d4L6n9Uk@google.com>
         <1619739791.1874.18.camel@realtek.com> <YItbyGGlZN4q9iOh@google.com>
In-Reply-To: <YItbyGGlZN4q9iOh@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.246.39.126]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMzAg5LiL5Y2IIDA3OjU4OjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <92E4098DF6B3414D89785BA540009C44@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/01/2021 00:31:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163441 [Apr 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/01/2021 00:33:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/01/2021 00:31:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163441 [Apr 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/01/2021 00:33:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTMwIGF0IDAxOjIyICswMDAwLCBCcmlhbiBOb3JyaXMgd3JvdGU6DQo+
IE9uIFRodSwgQXByIDI5LCAyMDIxIGF0IDExOjQzOjEyUE0gKzAwMDAsIFBrc2hpaCB3cm90ZToN
Cj4gPiBPbiBUaHUsIDIwMjEtMDQtMjkgYXQgMjE6MTAgKzAwMDAsIEJyaWFuIE5vcnJpcyB3cm90
ZToNCj4gPiA+IHJ0dzg5X3dyaXRlX3JmKCkgaXMgaG9sZGluZyBhIG11dGV4IChyZl9tdXRleCku
IEp1ZGdpbmcgYnkgaXRzIHRyaXZpYWwNCj4gPiA+IHVzYWdlIChpdCdzIG9ubHkgcHJvdGVjdGlu
ZyByZWdpc3RlciByZWFkcy93cml0ZXMpLCBpdCBwcm9iYWJseSBjb3VsZCBiZQ0KPiA+ID4gYSBz
cGlubG9jayBpbnN0ZWFkIC0tIGFsdGhvdWdoIEkgZG8gbm90ZSBzb21lIG1hZ2ljIHVkZWxheSgp
cyBpbiB0aGVyZS4NCj4gPiA+wqANCj4gPsKgDQo+ID4gVGhlIHVkZWxheSgpIGlzIG5lZWRlZCB0
byBlbnN1cmUgdGhlIGluZGlyZWN0LXdyaXRlIGNvcnJlY3QuDQo+IA0KPiBPSy4gTWF5YmUgZGVz
ZXJ2ZXMgYSBjb21tZW50IGZvciB0aGUgZnV0dXJlLiBJcyB0aGlzIGENCj4gaGFyZHdhcmUtc3Bl
Y2lmaWVkIHRpbWluZyAobWVhc3VyZWQgaW4gbnVtYmVyIG9mIGN5Y2xlcyBvciBzaW1pbGFyLCBv
bg0KPiB0aGUgV2lGaSBjaGlwIHNpZGUpLCBvciBzb21ldGhpbmcgeW91J3JlIGp1c3QgZ3Vlc3Np
bmcgYXQ/DQo+IA0KDQpUaGlzIGlzIGVzdGltYXRlZCBieSBkZXNpZ25lci4NCg0KPiA+ID4gQWx0
ZXJuYXRpdmVseSwgaXQgbG9va3MgbGlrZSB5b3UnZCBiZSBzYWZlIG1vdmluZyB0byB0aGUgbm9u
LWF0b21pYw0KPiA+ID4gaWVlZTgwMjExX2l0ZXJhdGVfYWN0aXZlX2ludGVyZmFjZXMoKSBpbiBy
dHc4OV9sZWF2ZV9scHMoKS4NCj4gPiA+wqANCj4gPsKgDQo+ID4gRm9yIG1vc3QgY2FzZXMgb2bC
oHJ0dzg5X2xlYXZlX2xwcygpLCB3ZSBjYW4gdXNlwqBpZWVlODAyMTFfaXRlcmF0ZV9hY3RpdmVf
aW50ZXJmYWNlcygpLA0KPiA+IHdoaWNoIGhvbGQgaWZsaXN0X210eCBsb2NrLCBleGNlcHQgdG/C
oA0KPiA+wqANCj4gPsKgCWllZWU4MDIxMV9yZWNhbGNfcHMobG9jYWwpOwkvLyBoZWxkIGlmbGlz
dF9tdHggbG9jaw0KPiA+wqAJCS4uLg0KPiA+wqAJCWllZWU4MDIxMV9od19jb25maWcNCj4gPsKg
CQkJLi4uDQo+ID7CoAkJCXJ0dzg5X2xlYXZlX2xwcygpDQo+ID7CoAkJCQkuLi4NCj4gPsKgCQkJ
CWllZWU4MDIxMV9pdGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzKCkNCj4gPsKgDQo+ID4gVGhhdCB3
aWxsIGxlYWRzIGRlYWRsb2NrLg0KPiANCj4gR29vZCBwb2ludC4NCj4gDQo+ID4gQW5vdGhlciB2
YXJpYW50IGllZWU4MDIxMV9pdGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzX210eCgpIHRoYXQgZG9l
c24ndA0KPiA+IGhvbGQgYSBsb2NrIG1heSBiZSBhIHNvbHV0aW9uLiBUaGUgdGhlIGNvbW1lbnQg
c2F5cyAiVGhpcyB2ZXJzaW9uIGNhbg0KPiA+IG9ubHkgYmUgdXNlZCB3aGlsZSBob2xkaW5nIHRo
ZSBSVE5MLiIsIGFuZCB0aGUgY29kZSB3aXRoaW4gdGhlIGZ1bmN0aW9uDQo+ID4gc2F5cyAibG9j
a2RlcF9hc3NlcnRfd2lwaHkoaHctPndpcGh5KTsiLiBJJ20gbm90IHN1cmUgaWYgSSBjYW4gdXNl
IGl0DQo+ID4gdG8gcHJldmVudCBsb2NraW5nIGlmbGlzdF9tdHggdHdpY2UuDQo+IA0KPiBUaGlz
IGRvZXNuJ3QgcXVpdGUgZmVlbCBsaWtlIHRoZSByaWdodCB0aGluZy4gWW91J3JlIGluIHRoZSBt
aWRzdCBvZg0KPiBtYW55IG90aGVyIGNhbGxiYWNrIGxheWVycywgYW5kIEkgZG9uJ3QgdGhpbmsg
dGhpcyBpcyB0aGUgcmlnaHQgcGxhY2UgdG8NCj4gYmUgZ3JhYmJpbmcgdGhvc2UgbG9ja3MuIEJ1
dCBJIGhhdmVuJ3QgcmVzZWFyY2hlZCB0aGlzIHZlcnkgY2xvc2VseSB5ZXQuDQo+IA0KPiA+IElm
IEkgY2FuIHVzZSBpdCwgSSBjYW4gYWRkIGEgYXJndW1lbnQgJ210eCcsIGxpa2UgcnR3ODlfbGVh
dmVfbHBzKHJ0d2RldiwgYm9vbCBtdHgpLA0KPiA+IHRvIGp1ZGdlIHVzaW5nIGllZWU4MDIxMV9p
dGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzKCkgb3IgaWVlZTgwMjExX2l0ZXJhdGVfYWN0aXZlX2lu
dGVyZmFjZXNfbXR4KCkuDQo+ID7CoA0KPiA+IEknbSBhbHNvIHRoaW5raW5nIHRoYXQgd2UgY2Fu
IHN0aWxsIHVzZcKgaWVlZTgwMjExX2l0ZXJhdGVfYWN0aXZlX2ludGVyZmFjZXNfYXRvbWljKCkN
Cj4gPiB0byBtZXJlbHkgY29sbGVjdMKgcnR3dmlmLT5tYWNfaWQgbGlzdCwgYW5kIHVzZSBhIGxv
b3AgdG8gZG8gbGVhdmVfbHBzDQo+ID4gb3V0IG9mIHRoZSBhdG9taWMgaXRlcmF0ZS4NCj4gDQo+
IFRoYXQncyBwcm9iYWJseSBzYWZlLCBiZWNhdXNlIHdlJ3JlIGFscmVhZHkgaG9sZGluZyBydHdk
ZXYtPm11dGV4LCBzbw0KPiB0aGVyZSdzIG5vIGNoYW5jZSBvZiBvdXIgbWFjX2lkIGdvaW5nIGF3
YXkuIElmIHRoYXQgc29sdXRpb24gaXNuJ3QgdG9vDQo+IGNvbXBsZXgsIGl0IG1ha2VzIHNlbnNl
IHRvIG1lLg0KPiANCg0KSSBkcm9wIHRoZcKgcnR3ODlfaXRlcmF0ZV92aWZzX2F0b21pYygpIHRo
YXQgY2Fubm90IHNsZWVwLCBidXQgaXQncyBoYXJkIHRvIGF2b2lkIGNhbGxpbmcNCnNsZWVwIGZ1
bmN0aW9ucy4gVG8gbWFrZSBvdGhlciBwcm9ncmFtbWVycyBlYXNpZXIgdG8gY2hvb3NlIGl0ZXJh
dGUgZnVuY3Rpb25zLCBJIHJlLWRlc2lnbg0KdGhlbSBhY2NvcmRpbmcgdG8gcnVubmluZyBjb250
ZXh0LCBhbmQgbGlzdGVkIGJlbG93DQoNCsKgIMKgIGNvbnRleHTCoMKgwqDCoMKgwqDCoMKgwqBp
Zmxpc3RfbXR4wqDCoMKgwqDCoMKgaXRlcmF0ZSB2aWZzIGZ1bmN0aW9ucw0KwqDCoMKgwqAtLS0t
LS0twqDCoMKgwqDCoMKgwqDCoMKgLS0tLS0tLS0tLcKgwqDCoMKgwqDCoC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCsKgwqDCoMKgQkjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTi9BwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBydHc4OV9pdGVyYXRlX3ZpZnNfYmgoKQ0KwqDCoMKgwqB0aHJl
YWTCoMKgwqDCoMKgwqDCoMKgwqDCoG5vdCBoZWxkIMKgIMKgIMKgIMKgcnR3ODlfaXRlcmF0ZV92
aWZzKCwsLGZhbHNlKTsNCsKgwqDCoMKgdGhyZWFkwqDCoMKgwqDCoMKgwqDCoMKgwqBoZWxkwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcnR3ODlfaXRlcmF0ZV92aWZzKCwsLHRydWUpOw0KDQpJdCdz
IGNsZWFyIHRoYXQgaXRlcmF0b3JzIG9mIHJ0dzg5X2l0ZXJhdGVfdmlmc19iaCgpIGNhbid0IGNh
bGwgc2xlZXAgZnVuY3Rpb25zLg0KSXRlcmF0b3JzIG9mIHJ0dzg5X2l0ZXJhdGVfdmlmcygpIGNh
biBhbHdheXMgY2FsbCBzbGVlcCBmdW5jdGlvbnMsIGJ1dCBhZGRpdGlvbmFsDQpmb3J0aCBhcmd1
bWVudCBtdXN0IGJlIHNldCBjb3JyZWN0bHkuDQoNCk5leHQgc3VibWlzc2lvbiB3aWxsIGluY2x1
ZGUgdGhpcyBjaGFuZ2UuDQoNCi0tDQpQaW5nLUtlDQoNCg==
