Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0655C373CFA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhEEOEf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:04:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43862 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhEEOEf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:04:35 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 145E3WvT4026129, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 145E3WvT4026129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 5 May 2021 22:03:33 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 22:03:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 22:03:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Wed, 5 May 2021 22:03:31 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "ihuguet@redhat.com" <ihuguet@redhat.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: Re: rtlwifi: potential bugs
Thread-Topic: rtlwifi: potential bugs
Thread-Index: AQHXOEApGs/bN0u4/kyWgoPFPSr6varUS50AgAANwICAAA2KgIAAEVOA
Date:   Wed, 5 May 2021 14:03:31 +0000
Message-ID: <1620223407.28283.2.camel@realtek.com>
References: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
         <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com>
         <1620216779.15370.10.camel@realtek.com>
         <CACT4ouehaQsGr1UGqncvAFgay0v40Zv=O=oz5f8W=E+YmV=SYg@mail.gmail.com>
In-Reply-To: <CACT4ouehaQsGr1UGqncvAFgay0v40Zv=O=oz5f8W=E+YmV=SYg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.224.68.229]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvNSDkuIvljYggMTI6MDU6MDA=?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <78CA50B209B9754593187662DF001700@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/05/2021 13:48:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163491 [May 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/05/2021 13:51:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/05/2021 13:48:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163491 [May 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/05/2021 13:51:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTA1IGF0IDEzOjAxICswMDAwLCBJbmlnbyBIdWd1ZXQgd3JvdGU6DQo+
IEhpLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgaW5mby4gTWF5YmUgd2Ugc2hvdWxkIGNvbnNpZGVy
IGFkZGluZyBzb21lIGNvbW1lbnRzIHRvDQo+IGNsYXJpZnkgdGhpcz8gT3RoZXIgcGVvcGxlIG1p
Z2h0IGFsc28gdGhpbmsgdGhlc2UgYXJlIGJ1Z3MuLi4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBP
biBXZWQsIE1heSA1LCAyMDIxIGF0IDI6MTMgUE0gUGtzaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCAyMDIxLTA1LTA1IGF0IDExOjIzICswMDAwLCBJbmln
byBIdWd1ZXQgd3JvdGU6DQo+ID4gPiBPbiBGcmksIEFwciAyMywgMjAyMSBhdCAyOjU2IFBNIElu
aWdvIEh1Z3VldCA8aWh1Z3VldEByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4g
SGVsbG8sDQo+ID4gPiA+DQo+ID4gPiA+IEV4ZWN1dGluZyBzb21lIHN0YXRpYyBhbmFseXNpcyBv
biB0aGUga2VybmVsLCB3ZSd2ZSBnb3QgdGhpcyByZXN1bHRzDQo+ID4gPiA+IGFmZmVjdGluZyBy
dGx3aWZpIGRyaXZlcnM6DQo+ID4gPiA+DQo+ID4gPiA+IEVycm9yOiBJREVOVElDQUxfQlJBTkNI
RVMgKENXRS0zOTgpOiBbI2RlZjIxMl0NCj4gPiA+ID4ga2VybmVsLTUuMTEuMC0wLnJjNy4xNTEv
bGludXgtNS4xMS4wLTAucmM3LjE1MS5lbDkueDg2XzY0L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODgyMWEyYW50LmM6MjgxMzoNCj4gPiA+ID4g
aWRlbnRpY2FsX2JyYW5jaGVzOiBUaGUgc2FtZSBjb2RlIGlzIGV4ZWN1dGVkIHJlZ2FyZGxlc3Mg
b2Ygd2hldGhlcg0KPiA+ID4gPiAiYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9ISUdI
IHx8IGJ0X3Jzc2lfc3RhdGUgPT0NCj4gPiA+ID4gQlRDX1JTU0lfU1RBVEVfU1RBWV9ISUdIIiBp
cyB0cnVlLCBiZWNhdXNlIHRoZSAndGhlbicgYW5kICdlbHNlJw0KPiA+ID4gPiBicmFuY2hlcyBh
cmUgaWRlbnRpY2FsLiBTaG91bGQgb25lIG9mIHRoZSBicmFuY2hlcyBiZSBtb2RpZmllZCwgb3Ig
dGhlDQo+ID4gPiA+IGVudGlyZSAnaWYnIHN0YXRlbWVudCByZXBsYWNlZD8NCj4gPiA+ID4gIyAy
ODExfMKgwqDCoH0NCj4gPiA+ID4gIyAyODEyfA0KPiA+ID4gPiAjIDI4MTN8LT4gaWYgKChidF9y
c3NpX3N0YXRlID09IEJUQ19SU1NJX1NUQVRFX0hJR0gpIHx8DQo+ID4gPiA+ICMgMjgxNHzCoMKg
wqDCoMKgwqAoYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9TVEFZX0hJR0gpKSB7DQo+
ID4gPiA+ICMgMjgxNXzCoMKgwqBidGM4ODIxYTJhbnRfcHNfdGRtYShidGNvZXhpc3QsIE5PUk1B
TF9FWEVDLCB0cnVlLCAyMyk7DQo+ID4gPiA+DQo+ID4gPiA+IEVycm9yOiBJREVOVElDQUxfQlJB
TkNIRVMgKENXRS0zOTgpOiBbI2RlZjIxM10NCj4gPiA+ID4ga2VybmVsLTUuMTEuMC0wLnJjNy4x
NTEvbGludXgtNS4xMS4wLTAucmM3LjE1MS5lbDkueDg2XzY0L2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODgyMWEyYW50LmM6Mjk0NzoNCj4gPiA+
ID4gaWRlbnRpY2FsX2JyYW5jaGVzOiBUaGUgc2FtZSBjb2RlIGlzIGV4ZWN1dGVkIHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlcg0KPiA+ID4gPiAiYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9I
SUdIIHx8IGJ0X3Jzc2lfc3RhdGUgPT0NCj4gPiA+ID4gQlRDX1JTU0lfU1RBVEVfU1RBWV9ISUdI
IiBpcyB0cnVlLCBiZWNhdXNlIHRoZSAndGhlbicgYW5kICdlbHNlJw0KPiA+ID4gPiBicmFuY2hl
cyBhcmUgaWRlbnRpY2FsLiBTaG91bGQgb25lIG9mIHRoZSBicmFuY2hlcyBiZSBtb2RpZmllZCwg
b3IgdGhlDQo+ID4gPiA+IGVudGlyZSAnaWYnIHN0YXRlbWVudCByZXBsYWNlZD8NCj4gPiA+ID4g
IyAyOTQ1fMKgwqDCoH0NCj4gPiA+ID4gIyAyOTQ2fA0KPiA+ID4gPiAjIDI5NDd8LT4gaWYgKChi
dF9yc3NpX3N0YXRlID09IEJUQ19SU1NJX1NUQVRFX0hJR0gpIHx8DQo+ID4gPiA+ICMgMjk0OHzC
oMKgwqDCoMKgwqAoYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9TVEFZX0hJR0gpKQ0K
PiA+ID4gPiAjIDI5NDl8wqDCoMKgYnRjODgyMWEyYW50X3BzX3RkbWEoYnRjb2V4aXN0LCBOT1JN
QUxfRVhFQywgdHJ1ZSwgMjYpOw0KPiA+ID4gPg0KPiA+ID4gPiBFcnJvcjogSURFTlRJQ0FMX0JS
QU5DSEVTIChDV0UtMzk4KTogWyNkZWYyMTRdDQo+ID4gPiA+IGtlcm5lbC01LjExLjAtMC5yYzcu
MTUxL2xpbnV4LTUuMTEuMC0wLnJjNy4xNTEuZWw5Lng4Nl82NC9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bHdpZmkvYnRjb2V4aXN0L2hhbGJ0Yzg4MjFhMmFudC5jOjMxMzU6DQo+ID4g
PiA+IGlkZW50aWNhbF9icmFuY2hlczogVGhlIHNhbWUgY29kZSBpcyBleGVjdXRlZCByZWdhcmRs
ZXNzIG9mIHdoZXRoZXINCj4gPiA+ID4gIndpZmlfYncgPT0gQlRDX1dJRklfQldfTEVHQUNZIiBp
cyB0cnVlLCBiZWNhdXNlIHRoZSAndGhlbicgYW5kICdlbHNlJw0KPiA+ID4gPiBicmFuY2hlcyBh
cmUgaWRlbnRpY2FsLiBTaG91bGQgb25lIG9mIHRoZSBicmFuY2hlcyBiZSBtb2RpZmllZCwgb3Ig
dGhlDQo+ID4gPiA+IGVudGlyZSAnaWYnIHN0YXRlbWVudCByZXBsYWNlZD8NCj4gPiA+ID4gIyAz
MTMzfMKgwqDCoGJ0Y29leGlzdC0+YnRjX2dldChidGNvZXhpc3QsIEJUQ19HRVRfVTRfV0lGSV9C
VywgJndpZmlfYncpOw0KPiA+ID4gPiAjIDMxMzR8DQo+ID4gPiA+ICMgMzEzNXwtPiBpZiAod2lm
aV9idyA9PSBCVENfV0lGSV9CV19MRUdBQ1kpIHsNCj4gPiA+ID4gIyAzMTM2fMKgwqDCoC8qIGZv
ciBISUQgYXQgMTFiL2cgbW9kZSAqLw0KPiA+ID4gPiAjIDMxMzd8wqDCoMKgYnRjODgyMWEyYW50
X2NvZXhfdGFibGUoYnRjb2V4aXN0LCBOT1JNQUxfRVhFQywgMHg1NWZmNTVmZiwNCj4gPiA+ID4N
Cj4gPiA+ID4gRXJyb3I6IElERU5USUNBTF9CUkFOQ0hFUyAoQ1dFLTM5OCk6IFsjZGVmMjE1XQ0K
PiA+ID4gPiBrZXJuZWwtNS4xMS4wLTAucmM3LjE1MS9saW51eC01LjExLjAtMC5yYzcuMTUxLmVs
OS54ODZfNjQvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9o
YWxidGM4ODIxYTJhbnQuYzozMzI0Og0KPiA+ID4gPiBpZGVudGljYWxfYnJhbmNoZXM6IFRoZSBz
YW1lIGNvZGUgaXMgZXhlY3V0ZWQgcmVnYXJkbGVzcyBvZiB3aGV0aGVyDQo+ID4gPiA+ICJidF9y
c3NpX3N0YXRlID09IEJUQ19SU1NJX1NUQVRFX0hJR0ggfHwgYnRfcnNzaV9zdGF0ZSA9PQ0KPiA+
ID4gPiBCVENfUlNTSV9TVEFURV9TVEFZX0hJR0giIGlzIHRydWUsIGJlY2F1c2UgdGhlICd0aGVu
JyBhbmQgJ2Vsc2UnDQo+ID4gPiA+IGJyYW5jaGVzIGFyZSBpZGVudGljYWwuIFNob3VsZCBvbmUg
b2YgdGhlIGJyYW5jaGVzIGJlIG1vZGlmaWVkLCBvciB0aGUNCj4gPiA+ID4gZW50aXJlICdpZicg
c3RhdGVtZW50IHJlcGxhY2VkPw0KPiA+ID4gPiAjIDMzMjJ8wqDCoMKgfQ0KPiA+ID4gPiAjIDMz
MjN8DQo+ID4gPiA+ICMgMzMyNHwtPiBpZiAoKGJ0X3Jzc2lfc3RhdGUgPT0gQlRDX1JTU0lfU1RB
VEVfSElHSCkgfHwNCj4gPiA+ID4gIyAzMzI1fMKgwqDCoMKgwqDCoChidF9yc3NpX3N0YXRlID09
IEJUQ19SU1NJX1NUQVRFX1NUQVlfSElHSCkpIHsNCj4gPiA+ID4gIyAzMzI2fMKgwqDCoGJ0Yzg4
MjFhMmFudF9wc190ZG1hKGJ0Y29leGlzdCwgTk9STUFMX0VYRUMsIHRydWUsIDIzKTsNCj4gPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gbXkgb3BpbmlvbiwgdGhleSBzZWVtIHRvIGJlIHJlYWwg
YnVncy4gSG93ZXZlciwgaXQncyB2ZXJ5IGRpZmZpY3VsdA0KPiA+ID4gPiB0byBpbWFnaW5lIHdo
YXQgYWN0aW9ucyBtdXN0IGJlIHRha2VuIG9uIGVhY2ggYnJhbmNoIG9mIHRoZSBpZi1lbHNlDQo+
ID4gPiA+IGJlY2F1c2UgdGhleSBzdHJvbmdseSBkZXBlbmQgb24gbWFnaWMgbnVtYmVycywgd2hp
Y2ggYXJlIGRpZmZlcmVudA0KPiA+ID4gPiBjb25maWd1cmF0aW9ucyBmb3IgdGhlIGh3LCBJIGd1
ZXNzLg0KPiA+ID4gPg0KPiA+ID4gPiBDYW4gdGhlIG1haW50YWluZXJzIGNvbmZpcm0gaWYgdGhl
c2UgYXJlIHJlYWwgYnVncyBhbmQgc2VlIGhvdyB0byBmaXggdGhlbT8NCj4gPiA+ID4NCj4gPiA+
ID4gUmVnYXJkcw0KPiA+ID4gPiAtLQ0KPiA+ID4gPiDDjcOxaWdvIEh1Z3VldA0KPiA+ID4NCj4g
PiA+IEhlbGxvLA0KPiA+ID4NCj4gPiA+IEEgZmV3IHdlZWtzIGFnbyBJIHNlbnQgdGhlIG1lc3Nh
Z2UgYWJvdmUgbm90aWZ5aW5nIGEgcG90ZW50aWFsIGJ1ZyBpbg0KPiA+ID4gcnRsd2lmaSBtb2R1
bGUuIEkganVzdCB3YW50ZWQgdG8gYmUgc3VyZSB0aGF0IGl0IGhhcyBiZWVuIHJlY2VpdmVkLg0K
PiA+ID4gQ2FuIHRoZSBtYWludGFpbmVycyBhY2tub3dsZWRnZSB3aGV0aGVyIHRoZXkgaGF2ZSBz
ZWVuIGl0Pw0KPiA+ID4NCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gTm90IHJlYWwgYnVncy4gVGhl
IGNvZXhpc3RlbmNlIHByb2dyYW1tZXJzIHByZXNlcnZlIHRoZSBzYW1lIGNvZGUgb2YNCj4gPiBi
cmFuY2hlcyBpbnRlbnRpb25hbGx5IHRvIGZpbmUgdHVuZSBwZXJmb3JtYW5jZSBlYXNpZXIsIGJl
Y2F1c2UgYmFuZHdpZHRoIGFuZA0KPiA+IFJTU0kgc3RyZW5ndGggYXJlIGhpZ2hseSByZWxhdGVk
IHRvIGNvZXhpc3RlbmNlIHBlcmZvcm1hbmNlLg0KPiA+IFRoZSBiYXNpYyBydWxlIG9mIHBlcmZv
cm1hbmNlIHR1bmluZyBpcyB0byBhc3NpZ24gbW9zdCB0aW1lIHNsb3QgdG8gQlQNCj4gPiBmb3Ig
cmVhbHRpbWUgYXBwbGljYXRpb24sIGFuZCBXaUZpIHVzZXMgcmVtYWluaW5nIHRpbWUgc2xvdCBi
dXQgZG9uJ3QgbG93ZXINCj4gPiB0aGFuIGxvdyBib3VuZC4NCj4gPg0KPiA+DQoNCkhpLA0KDQpJ
IGNhbiBhZGQgY29tbWVudHMuIERvIHlvdSBuZWVkIGFueSBrZXl3b3JkIHdpdGhpbiBjb21tZW50
IHRvIGF2b2lkIHlvdXINCmNoZWNraW5nIHRvb2wgd2FybnMgdGhpcyBmYWxzZSBhbGFybT8NCg0K
LS0NClBpbmctS2UNCg0K
