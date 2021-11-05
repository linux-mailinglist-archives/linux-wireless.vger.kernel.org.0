Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651D44464EF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 15:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhKEObf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 10:31:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35266 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhKEObd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 10:31:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A5ESeaJ6012927, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A5ESeaJ6012927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 5 Nov 2021 22:28:40 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 5 Nov 2021 22:28:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 22:28:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Fri, 5 Nov 2021 22:28:39 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "tiwai@suse.de" <tiwai@suse.de>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@gmail.com" <Larry.Finger@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtw89: Fix crash by loading compressed firmware file
Thread-Topic: [PATCH] rtw89: Fix crash by loading compressed firmware file
Thread-Index: AQHX0hU7VE24GGCl002qwvOXgdMXQqv0AUsAgACX6Q///34ogIAAjK5D///UggA=
Date:   Fri, 5 Nov 2021 14:28:39 +0000
Message-ID: <bd80d3b6cdc42d7818d7d5c6a5036d8188eb4a67.camel@realtek.com>
References: <20211105071725.31539-1-tiwai@suse.de>
         <s5hpmrfgj93.wl-tiwai@suse.de> <87zgqjqaae.fsf@codeaurora.org>
         <s5hh7crgflg.wl-tiwai@suse.de> <87v917q8hw.fsf@codeaurora.org>
In-Reply-To: <87v917q8hw.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.68.85]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzUg5LiL5Y2IIDAxOjMxOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4E091EEC96FD749BB655CA55B8139B1@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/05/2021 14:09:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167092 [Nov 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/05/2021 14:12:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTExLTA1IGF0IDExOjAzICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBU
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+IHdyaXRlczoNCj4gDQo+ID4gT24gRnJpLCAwNSBO
b3YgMjAyMSAwOToyNToxMyArMDEwMCwNCj4gPiBLYWxsZSBWYWxvIHdyb3RlOg0KPiA+ID4gVGFr
YXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiB3cml0ZXM6DQo+ID4gPiANCj4gPiA+ID4gT24gRnJp
LCAwNSBOb3YgMjAyMSAwODoxNzoyNSArMDEwMCwNCj4gPiA+ID4gVGFrYXNoaSBJd2FpIHdyb3Rl
Og0KPiA+ID4gPiA+IFdoZW4gYSBmaXJtd2FyZSBpcyBsb2FkZWQgaW4gdGhlIGNvbXByZXNzZWQg
Zm9ybWF0IG9yIHZpYSB1c2VyLW1vZGUNCj4gPiA+ID4gPiBoZWxwZXIsIGl0J3MgbWFwcGVkIGlu
IHJlYWQtb25seSwgYW5kIHRoZSBydHc4OSBkcml2ZXIgY3Jhc2hlcyBhdA0KPiA+ID4gPiA+IHJ0
dzg5X2Z3X2Rvd25sb2FkKCkgd2hlbiBpdCB0cmllcyB0byBtb2RpZnkgc29tZSBkYXRhLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggaXMgYW4gYXR0ZW1wIHRvIGF2b2lkIHRoZSBj
cmFzaCBieSByZS1hbGxvY2F0aW5nIHRoZSBkYXRhDQo+ID4gPiA+ID4gdmlhIHZtYWxsb2MoKSBm
b3IgdGhlIGRhdGEgbW9kaWZpY2F0aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gQWx0ZXJuYXRpdmVs
eSwgd2UgbWF5IGRyb3AgdGhlIGNvZGUgdGhhdCBtb2RpZmllcyB0aGUgbG9hZGVkIGZpcm13YXJl
DQo+ID4gPiA+IGRhdGE/ICBBdCBsZWFzdCBTRVRfRldfSERSX1BBUlRfU0laRSgpIGluIHJ0dzg5
X2Z3X2hkcl9wYXJzZXIoKSBsb29rcw0KPiA+ID4gPiB3cml0aW5nIGl0LCBhbmQgSSBoYXZlIG5v
IGlkZWEgd2h5IHRoaXMgb3ZlcndyaXRlIGlzIG5lZWRlZC4NCj4gPiA+IA0KPiA+ID4gU3RyYW5n
ZSwgaXNuJ3QgdGhlIGZpcm13YXJlIGRhdGEgbWFya2VkIGFzIGNvbnN0IGp1c3QgdG8gYXZvaWQg
dGhpcyBraW5kDQo+ID4gPiBvZiBwcm9ibGVtPyBEb2VzIHJ0dzg5IGhhdmUgd3JvbmcgY2FzdHMg
c29tZXdoZXJlIHdoaWNoIHJlbW92ZXMgdGhlDQo+ID4gPiBjb25zdD8NCj4gPiANCj4gPiBZZXMu
ICBTRVRfRldfSERSX1BBUlRfU0laRSgpIGRvZXMgdGhlIGNhc3QsIGRyb3BwaW5nIHRoZSBjb25z
dC4NCj4gDQo+IE9oIG1hbiwgYWxsIG9mIEdFVCBhbmQgU0VUIG1hY3JvcyBpbiBmdy5oIGhhdmUg
dGhvc2UgY2FzdHM6DQo+IA0KPiAjZGVmaW5lIEdFVF9GV19IRFJfTUFKT1JfVkVSU0lPTihmd2hk
cikJXA0KPiAJbGUzMl9nZXRfYml0cygqKChfX2xlMzIgKikoZndoZHIpICsgMSksIEdFTk1BU0so
NywgMCkpDQo+ICNkZWZpbmUgR0VUX0ZXX0hEUl9NSU5PUl9WRVJTSU9OKGZ3aGRyKQlcDQo+IAls
ZTMyX2dldF9iaXRzKCooKF9fbGUzMiAqKShmd2hkcikgKyAxKSwgR0VOTUFTSygxNSwgOCkpDQo+
ICNkZWZpbmUgR0VUX0ZXX0hEUl9TVUJWRVJTSU9OKGZ3aGRyKQlcDQo+IAlsZTMyX2dldF9iaXRz
KCooKF9fbGUzMiAqKShmd2hkcikgKyAxKSwgR0VOTUFTSygyMywgMTYpKQ0KPiANCj4gSSBkb24n
dCBrbm93IGhvdyBJIG1pc3NlZCB0aG9zZSBkdXJpbmcgbXkgcmV2aWV3IDooIEJ1dCB0aGlzIGlz
IGV4YWN0bHkNCj4gd2h5IEkgcHJlZmVyIGhhdmluZyBhIHByb3BlciBzdHJ1Y3QgZm9yIGNvbW1h
bmRzIGFuZCBldmVudHMsIGluc3RlYWQgb2YNCj4gdTggYnVmIHVzZWQgd2l0aCB0aGVzZSBtYWNy
b3MuDQo+IA0KDQoNCkkgY2FuIHVzZSBhIHN0cnVjdCB0byBhY2Nlc3MgZmlybXdhcmUgaGVhZGVy
LCBiZWN1YXNlIHRoZWlyIGZpZWxkcw0KYXJlIG11bHRpcGxlIG9mIDggYml0cy4NCg0KQnV0LCB0
aGUgImZpcm13YXJlIHNlY3Rpb24gaGVhZGVyIiB0aGF0IGlzIGFkZGl0aW9uYWwgaGVhZGVyIGZv
bGxvd2VkDQpieSBmaXJtd2FyZSBoZWFkZXIsIGFuZCBpdCBjb250YWlucyBiaXQgZmllbGRzLCBs
aWtlczoNCg0KI2RlZmluZSBHRVRfRldTRUNUSU9OX0hEUl9TRUNfU0laRShmd2hkcikJXA0KCWxl
MzJfZ2V0X2JpdHMoKigoX19sZTMyICopKGZ3aGRyKSArIDEpLCBHRU5NQVNLKDIzLCAwKSkNCiNk
ZWZpbmUgR0VUX0ZXU0VDVElPTl9IRFJfQ0hFQ0tTVU0oZndoZHIpCVwNCglsZTMyX2dldF9iaXRz
KCooKF9fbGUzMiAqKShmd2hkcikgKyAxKSwgQklUKDI4KSkNCiNkZWZpbmUgR0VUX0ZXU0VDVElP
Tl9IRFJfUkVETChmd2hkcikJXA0KCWxlMzJfZ2V0X2JpdHMoKigoX19sZTMyICopKGZ3aGRyKSAr
IDEpLCBCSVQoMjkpKQ0KI2RlZmluZSBHRVRfRldTRUNUSU9OX0hEUl9ETF9BRERSKGZ3aGRyKQlc
DQoJbGUzMl9nZXRfYml0cygqKChfX2xlMzIgKikoZndoZHIpKSwgR0VOTUFTSygzMSwgMCkpDQoN
CklmIHdlIHVzZSBhIHN0cnVjdCwgaXQgbmVlZHMgYmlnLS9saXR0bGUtIGVuZGlhbnMgcGFydHMu
DQoNClRoZW4sIHdlIHdpbGwgYWNjZXNzIGZpcm13YXJlIGhlYWRlciB3aXRoIHR3byBtZXRob2Rz
OyBpcw0KaXQgcmVhc29uYWJsZT8NCg0KDQpUaGUgbWFjcm8gU0VUX0ZXX0hEUl9QQVJUX1NJWkUo
KSBpcyB1c2VkIHRvIHNldCB0aGUgZmlybXdhcmUNCnBhcnRpdGlvbiBzaXplIHdlIGFyZSBnb2lu
ZyB0byBkb3dubG9hZCwgYW5kIGl0IGlzIG9ubHkgdXNlZA0KYnkgcnR3ODlfZndfZG93bmxvYWRf
aGRyKCkuIFNvLCBJIHdpbGwgc2V0IHRoZSBwYXJ0aXRpb24gc2l6ZQ0KYWZ0ZXIgY29weWluZyBj
b25zdGFudCBmaXJtd2FyZSBoZWFkZXIgaW50byBza2ItPmRhdGEuDQoNCi0tDQpQaW5nLUtlDQoN
Cg==
