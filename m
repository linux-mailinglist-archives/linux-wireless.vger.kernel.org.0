Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90D373ADC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhEEMPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 08:15:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38152 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhEEMOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 08:14:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 145CD6Lp8008890, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 145CD6Lp8008890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 5 May 2021 20:13:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 20:13:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 20:13:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Wed, 5 May 2021 20:13:03 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ihuguet@redhat.com" <ihuguet@redhat.com>
CC:     "ivecera@redhat.com" <ivecera@redhat.com>
Subject: Re: rtlwifi: potential bugs
Thread-Topic: rtlwifi: potential bugs
Thread-Index: AQHXOEApGs/bN0u4/kyWgoPFPSr6varUS50AgAANwIA=
Date:   Wed, 5 May 2021 12:13:03 +0000
Message-ID: <1620216779.15370.10.camel@realtek.com>
References: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
         <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com>
In-Reply-To: <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.224.68.229]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvNSDkuIrljYggMDk6NTI6MDA=?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <3408DF3FF6802B458EF2D97330A4BA40@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/05/2021 11:45:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163489 [May 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/05/2021 11:49:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/05/2021 11:51:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163489 [May 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/05/2021 11:54:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTA1IGF0IDExOjIzICswMDAwLCBJbmlnbyBIdWd1ZXQgd3JvdGU6DQo+
IE9uIEZyaSwgQXByIDIzLCAyMDIxIGF0IDI6NTYgUE0gSW5pZ28gSHVndWV0IDxpaHVndWV0QHJl
ZGhhdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGVsbG8sDQo+ID4NCj4gPiBFeGVjdXRpbmcgc29t
ZSBzdGF0aWMgYW5hbHlzaXMgb24gdGhlIGtlcm5lbCwgd2UndmUgZ290IHRoaXMgcmVzdWx0cw0K
PiA+IGFmZmVjdGluZyBydGx3aWZpIGRyaXZlcnM6DQo+ID4NCj4gPiBFcnJvcjogSURFTlRJQ0FM
X0JSQU5DSEVTIChDV0UtMzk4KTogWyNkZWYyMTJdDQo+ID4ga2VybmVsLTUuMTEuMC0wLnJjNy4x
NTEvbGludXgtNS4xMS4wLTAucmM3LjE1MS5lbDkueDg2XzY0L2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODgyMWEyYW50LmM6MjgxMzoNCj4gPiBp
ZGVudGljYWxfYnJhbmNoZXM6IFRoZSBzYW1lIGNvZGUgaXMgZXhlY3V0ZWQgcmVnYXJkbGVzcyBv
ZiB3aGV0aGVyDQo+ID4gImJ0X3Jzc2lfc3RhdGUgPT0gQlRDX1JTU0lfU1RBVEVfSElHSCB8fCBi
dF9yc3NpX3N0YXRlID09DQo+ID4gQlRDX1JTU0lfU1RBVEVfU1RBWV9ISUdIIiBpcyB0cnVlLCBi
ZWNhdXNlIHRoZSAndGhlbicgYW5kICdlbHNlJw0KPiA+IGJyYW5jaGVzIGFyZSBpZGVudGljYWwu
IFNob3VsZCBvbmUgb2YgdGhlIGJyYW5jaGVzIGJlIG1vZGlmaWVkLCBvciB0aGUNCj4gPiBlbnRp
cmUgJ2lmJyBzdGF0ZW1lbnQgcmVwbGFjZWQ/DQo+ID4gIyAyODExfMKgwqDCoH0NCj4gPiAjIDI4
MTJ8DQo+ID4gIyAyODEzfC0+IGlmICgoYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9I
SUdIKSB8fA0KPiA+ICMgMjgxNHzCoMKgwqDCoMKgwqAoYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNT
SV9TVEFURV9TVEFZX0hJR0gpKSB7DQo+ID4gIyAyODE1fMKgwqDCoGJ0Yzg4MjFhMmFudF9wc190
ZG1hKGJ0Y29leGlzdCwgTk9STUFMX0VYRUMsIHRydWUsIDIzKTsNCj4gPg0KPiA+IEVycm9yOiBJ
REVOVElDQUxfQlJBTkNIRVMgKENXRS0zOTgpOiBbI2RlZjIxM10NCj4gPiBrZXJuZWwtNS4xMS4w
LTAucmM3LjE1MS9saW51eC01LjExLjAtMC5yYzcuMTUxLmVsOS54ODZfNjQvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGM4ODIxYTJhbnQuYzoyOTQ3
Og0KPiA+IGlkZW50aWNhbF9icmFuY2hlczogVGhlIHNhbWUgY29kZSBpcyBleGVjdXRlZCByZWdh
cmRsZXNzIG9mIHdoZXRoZXINCj4gPiAiYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9I
SUdIIHx8IGJ0X3Jzc2lfc3RhdGUgPT0NCj4gPiBCVENfUlNTSV9TVEFURV9TVEFZX0hJR0giIGlz
IHRydWUsIGJlY2F1c2UgdGhlICd0aGVuJyBhbmQgJ2Vsc2UnDQo+ID4gYnJhbmNoZXMgYXJlIGlk
ZW50aWNhbC4gU2hvdWxkIG9uZSBvZiB0aGUgYnJhbmNoZXMgYmUgbW9kaWZpZWQsIG9yIHRoZQ0K
PiA+IGVudGlyZSAnaWYnIHN0YXRlbWVudCByZXBsYWNlZD8NCj4gPiAjIDI5NDV8wqDCoMKgfQ0K
PiA+ICMgMjk0NnwNCj4gPiAjIDI5NDd8LT4gaWYgKChidF9yc3NpX3N0YXRlID09IEJUQ19SU1NJ
X1NUQVRFX0hJR0gpIHx8DQo+ID4gIyAyOTQ4fMKgwqDCoMKgwqDCoChidF9yc3NpX3N0YXRlID09
IEJUQ19SU1NJX1NUQVRFX1NUQVlfSElHSCkpDQo+ID4gIyAyOTQ5fMKgwqDCoGJ0Yzg4MjFhMmFu
dF9wc190ZG1hKGJ0Y29leGlzdCwgTk9STUFMX0VYRUMsIHRydWUsIDI2KTsNCj4gPg0KPiA+IEVy
cm9yOiBJREVOVElDQUxfQlJBTkNIRVMgKENXRS0zOTgpOiBbI2RlZjIxNF0NCj4gPiBrZXJuZWwt
NS4xMS4wLTAucmM3LjE1MS9saW51eC01LjExLjAtMC5yYzcuMTUxLmVsOS54ODZfNjQvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGM4ODIxYTJhbnQu
YzozMTM1Og0KPiA+IGlkZW50aWNhbF9icmFuY2hlczogVGhlIHNhbWUgY29kZSBpcyBleGVjdXRl
ZCByZWdhcmRsZXNzIG9mIHdoZXRoZXINCj4gPiAid2lmaV9idyA9PSBCVENfV0lGSV9CV19MRUdB
Q1kiIGlzIHRydWUsIGJlY2F1c2UgdGhlICd0aGVuJyBhbmQgJ2Vsc2UnDQo+ID4gYnJhbmNoZXMg
YXJlIGlkZW50aWNhbC4gU2hvdWxkIG9uZSBvZiB0aGUgYnJhbmNoZXMgYmUgbW9kaWZpZWQsIG9y
IHRoZQ0KPiA+IGVudGlyZSAnaWYnIHN0YXRlbWVudCByZXBsYWNlZD8NCj4gPiAjIDMxMzN8wqDC
oMKgYnRjb2V4aXN0LT5idGNfZ2V0KGJ0Y29leGlzdCwgQlRDX0dFVF9VNF9XSUZJX0JXLCAmd2lm
aV9idyk7DQo+ID4gIyAzMTM0fA0KPiA+ICMgMzEzNXwtPiBpZiAod2lmaV9idyA9PSBCVENfV0lG
SV9CV19MRUdBQ1kpIHsNCj4gPiAjIDMxMzZ8wqDCoMKgLyogZm9yIEhJRCBhdCAxMWIvZyBtb2Rl
ICovDQo+ID4gIyAzMTM3fMKgwqDCoGJ0Yzg4MjFhMmFudF9jb2V4X3RhYmxlKGJ0Y29leGlzdCwg
Tk9STUFMX0VYRUMsIDB4NTVmZjU1ZmYsDQo+ID4NCj4gPiBFcnJvcjogSURFTlRJQ0FMX0JSQU5D
SEVTIChDV0UtMzk4KTogWyNkZWYyMTVdDQo+ID4ga2VybmVsLTUuMTEuMC0wLnJjNy4xNTEvbGlu
dXgtNS4xMS4wLTAucmM3LjE1MS5lbDkueDg2XzY0L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODgyMWEyYW50LmM6MzMyNDoNCj4gPiBpZGVudGlj
YWxfYnJhbmNoZXM6IFRoZSBzYW1lIGNvZGUgaXMgZXhlY3V0ZWQgcmVnYXJkbGVzcyBvZiB3aGV0
aGVyDQo+ID4gImJ0X3Jzc2lfc3RhdGUgPT0gQlRDX1JTU0lfU1RBVEVfSElHSCB8fCBidF9yc3Np
X3N0YXRlID09DQo+ID4gQlRDX1JTU0lfU1RBVEVfU1RBWV9ISUdIIiBpcyB0cnVlLCBiZWNhdXNl
IHRoZSAndGhlbicgYW5kICdlbHNlJw0KPiA+IGJyYW5jaGVzIGFyZSBpZGVudGljYWwuIFNob3Vs
ZCBvbmUgb2YgdGhlIGJyYW5jaGVzIGJlIG1vZGlmaWVkLCBvciB0aGUNCj4gPiBlbnRpcmUgJ2lm
JyBzdGF0ZW1lbnQgcmVwbGFjZWQ/DQo+ID4gIyAzMzIyfMKgwqDCoH0NCj4gPiAjIDMzMjN8DQo+
ID4gIyAzMzI0fC0+IGlmICgoYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9ISUdIKSB8
fA0KPiA+ICMgMzMyNXzCoMKgwqDCoMKgwqAoYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFU
RV9TVEFZX0hJR0gpKSB7DQo+ID4gIyAzMzI2fMKgwqDCoGJ0Yzg4MjFhMmFudF9wc190ZG1hKGJ0
Y29leGlzdCwgTk9STUFMX0VYRUMsIHRydWUsIDIzKTsNCj4gPg0KPiA+DQo+ID4gSW4gbXkgb3Bp
bmlvbiwgdGhleSBzZWVtIHRvIGJlIHJlYWwgYnVncy4gSG93ZXZlciwgaXQncyB2ZXJ5IGRpZmZp
Y3VsdA0KPiA+IHRvIGltYWdpbmUgd2hhdCBhY3Rpb25zIG11c3QgYmUgdGFrZW4gb24gZWFjaCBi
cmFuY2ggb2YgdGhlIGlmLWVsc2UNCj4gPiBiZWNhdXNlIHRoZXkgc3Ryb25nbHkgZGVwZW5kIG9u
IG1hZ2ljIG51bWJlcnMsIHdoaWNoIGFyZSBkaWZmZXJlbnQNCj4gPiBjb25maWd1cmF0aW9ucyBm
b3IgdGhlIGh3LCBJIGd1ZXNzLg0KPiA+DQo+ID4gQ2FuIHRoZSBtYWludGFpbmVycyBjb25maXJt
IGlmIHRoZXNlIGFyZSByZWFsIGJ1Z3MgYW5kIHNlZSBob3cgdG8gZml4IHRoZW0/DQo+ID4NCj4g
PiBSZWdhcmRzDQo+ID4gLS0NCj4gPiDDjcOxaWdvIEh1Z3VldA0KPiANCj4gSGVsbG8sDQo+IA0K
PiBBIGZldyB3ZWVrcyBhZ28gSSBzZW50IHRoZSBtZXNzYWdlIGFib3ZlIG5vdGlmeWluZyBhIHBv
dGVudGlhbCBidWcgaW4NCj4gcnRsd2lmaSBtb2R1bGUuIEkganVzdCB3YW50ZWQgdG8gYmUgc3Vy
ZSB0aGF0IGl0IGhhcyBiZWVuIHJlY2VpdmVkLg0KPiBDYW4gdGhlIG1haW50YWluZXJzIGFja25v
d2xlZGdlIHdoZXRoZXIgdGhleSBoYXZlIHNlZW4gaXQ/DQo+IA0KDQpIaSwNCg0KTm90IHJlYWwg
YnVncy4gVGhlIGNvZXhpc3RlbmNlIHByb2dyYW1tZXJzIHByZXNlcnZlIHRoZSBzYW1lIGNvZGUg
b2YNCmJyYW5jaGVzIGludGVudGlvbmFsbHkgdG8gZmluZSB0dW5lIHBlcmZvcm1hbmNlIGVhc2ll
ciwgYmVjYXVzZSBiYW5kd2lkdGggYW5kDQpSU1NJIHN0cmVuZ3RoIGFyZSBoaWdobHkgcmVsYXRl
ZCB0byBjb2V4aXN0ZW5jZSBwZXJmb3JtYW5jZS4NClRoZSBiYXNpYyBydWxlIG9mIHBlcmZvcm1h
bmNlIHR1bmluZyBpcyB0byBhc3NpZ24gbW9zdCB0aW1lIHNsb3QgdG8gQlQNCmZvciByZWFsdGlt
ZSBhcHBsaWNhdGlvbiwgYW5kIFdpRmkgdXNlcyByZW1haW5pbmcgdGltZSBzbG90IGJ1dCBkb24n
dCBsb3dlcg0KdGhhbiBsb3cgYm91bmQuDQoNCi0tDQpQaW5nLUtlDQo=
