Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0942373DB8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhEEOeh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:34:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48223 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhEEOeg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:34:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 145EXYY60002451, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 145EXYY60002451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 5 May 2021 22:33:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 22:33:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 22:33:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Wed, 5 May 2021 22:33:33 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "ihuguet@redhat.com" <ihuguet@redhat.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: Re: rtlwifi: potential bugs
Thread-Topic: rtlwifi: potential bugs
Thread-Index: AQHXOEApGs/bN0u4/kyWgoPFPSr6varUS50AgAANwICAAA2KgIAAEVOAgAAEzoCAAAOWgA==
Date:   Wed, 5 May 2021 14:33:32 +0000
Message-ID: <1620225209.1966.4.camel@realtek.com>
References: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
         <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com>
         <1620216779.15370.10.camel@realtek.com>
         <CACT4ouehaQsGr1UGqncvAFgay0v40Zv=O=oz5f8W=E+YmV=SYg@mail.gmail.com>
         <1620223407.28283.2.camel@realtek.com>
         <CACT4ouePVqwkFRYRLCE7TznfWG87OKwhR2ukAYxO+ijOgZ26Dg@mail.gmail.com>
In-Reply-To: <CACT4ouePVqwkFRYRLCE7TznfWG87OKwhR2ukAYxO+ijOgZ26Dg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.224.68.229]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvNSDkuIvljYggMTI6MDU6MDA=?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCF442DCD5B56043A3A0E25518A688B7@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/05/2021 14:12:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163495 [May 05 2021]
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
X-KSE-Antiphishing-Bases: 05/05/2021 14:16:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/05/2021 14:18:59
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163495 [May 05 2021]
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
X-KSE-Antiphishing-Bases: 05/05/2021 14:21:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTA1IGF0IDE2OjIwICswMjAwLCBJbmlnbyBIdWd1ZXQgd3JvdGU6DQo+
IElmIGl0J3Mgbm8gcHJvYmxlbSB0byBhZGQgdGhlbSwgYSBjb21tZW50IFNUQVJUSU5HIFdJVEgN
Cj4gYGNvdmVyaXR5W2lkZW50aWNhbF9icmFuY2hlc11gIHNob3VsZCBzdXBwcmVzcyB0aGUgd2Fy
bmluZ3MuDQo+IA0KPiBFeGFtcGxlOg0KPiANCj4gLyogRXhwbGFuYXRpb24gd2h5IHRoaXMgY29k
ZSBpcyBmaW5lDQo+IMKgKiBhbmQgZ3JlYXQNCj4gwqAqLw0KPiAvKiBjb3Zlcml0eVtpZGVudGlj
YWxfYnJhbmNoZXNdICovDQo+IGlmICguLi4pDQo+IMKgwqDCoMKgwqDCoMKgwqAuLi4NCj4gDQo+
IFRoYW5rcyENCj4gDQo+IE9uIFdlZCwgTWF5IDUsIDIwMjEgYXQgNDowMyBQTSBQa3NoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIDIwMjEtMDUtMDUgYXQg
MTM6MDEgKzAwMDAsIEluaWdvIEh1Z3VldCB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+
IFRoYW5rcyBmb3IgdGhlIGluZm8uIE1heWJlIHdlIHNob3VsZCBjb25zaWRlciBhZGRpbmcgc29t
ZSBjb21tZW50cyB0bw0KPiA+ID4gY2xhcmlmeSB0aGlzPyBPdGhlciBwZW9wbGUgbWlnaHQgYWxz
byB0aGluayB0aGVzZSBhcmUgYnVncy4uLg0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPg0K
PiA+ID4gT24gV2VkLCBNYXkgNSwgMjAyMSBhdCAyOjEzIFBNIFBrc2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gV2VkLCAyMDIxLTA1LTA1IGF0IDEx
OjIzICswMDAwLCBJbmlnbyBIdWd1ZXQgd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCBBcHIgMjMs
IDIwMjEgYXQgMjo1NiBQTSBJbmlnbyBIdWd1ZXQgPGlodWd1ZXRAcmVkaGF0LmNvbT4gd3JvdGU6
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSGVsbG8sDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gRXhlY3V0aW5nIHNvbWUgc3RhdGljIGFuYWx5c2lzIG9uIHRoZSBrZXJuZWwsIHdlJ3ZlIGdv
dCB0aGlzIHJlc3VsdHMNCj4gPiA+ID4gPiA+IGFmZmVjdGluZyBydGx3aWZpIGRyaXZlcnM6DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRXJyb3I6IElERU5USUNBTF9CUkFOQ0hFUyAoQ1dFLTM5
OCk6IFsjZGVmMjEyXQ0KPiA+ID4gPiA+ID4ga2VybmVsLTUuMTEuMC0wLnJjNy4xNTEvbGludXgt
NS4xMS4wLTAucmM3LjE1MS5lbDkueDg2XzY0L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsd2lmaS9idGNvZXhpc3QvaGFsYnRjODgyMWEyYW50LmM6MjgxMzoNCj4gPiA+ID4gPiA+IGlk
ZW50aWNhbF9icmFuY2hlczogVGhlIHNhbWUgY29kZSBpcyBleGVjdXRlZCByZWdhcmRsZXNzIG9m
IHdoZXRoZXINCj4gPiA+ID4gPiA+ICJidF9yc3NpX3N0YXRlID09IEJUQ19SU1NJX1NUQVRFX0hJ
R0ggfHwgYnRfcnNzaV9zdGF0ZSA9PQ0KPiA+ID4gPiA+ID4gQlRDX1JTU0lfU1RBVEVfU1RBWV9I
SUdIIiBpcyB0cnVlLCBiZWNhdXNlIHRoZSAndGhlbicgYW5kICdlbHNlJw0KPiA+ID4gPiA+ID4g
YnJhbmNoZXMgYXJlIGlkZW50aWNhbC4gU2hvdWxkIG9uZSBvZiB0aGUgYnJhbmNoZXMgYmUgbW9k
aWZpZWQsIG9yIHRoZQ0KPiA+ID4gPiA+ID4gZW50aXJlICdpZicgc3RhdGVtZW50IHJlcGxhY2Vk
Pw0KPiA+ID4gPiA+ID4gIyAyODExfMKgwqDCoH0NCj4gPiA+ID4gPiA+ICMgMjgxMnwNCj4gPiA+
ID4gPiA+ICMgMjgxM3wtPiBpZiAoKGJ0X3Jzc2lfc3RhdGUgPT0gQlRDX1JTU0lfU1RBVEVfSElH
SCkgfHwNCj4gPiA+ID4gPiA+ICMgMjgxNHzCoMKgwqDCoMKgwqAoYnRfcnNzaV9zdGF0ZSA9PSBC
VENfUlNTSV9TVEFURV9TVEFZX0hJR0gpKSB7DQo+ID4gPiA+ID4gPiAjIDI4MTV8wqDCoMKgYnRj
ODgyMWEyYW50X3BzX3RkbWEoYnRjb2V4aXN0LCBOT1JNQUxfRVhFQywgdHJ1ZSwgMjMpOw0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEVycm9yOiBJREVOVElDQUxfQlJBTkNIRVMgKENXRS0zOTgp
OiBbI2RlZjIxM10NCj4gPiA+ID4gPiA+IGtlcm5lbC01LjExLjAtMC5yYzcuMTUxL2xpbnV4LTUu
MTEuMC0wLnJjNy4xNTEuZWw5Lng4Nl82NC9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bHdpZmkvYnRjb2V4aXN0L2hhbGJ0Yzg4MjFhMmFudC5jOjI5NDc6DQo+ID4gPiA+ID4gPiBpZGVu
dGljYWxfYnJhbmNoZXM6IFRoZSBzYW1lIGNvZGUgaXMgZXhlY3V0ZWQgcmVnYXJkbGVzcyBvZiB3
aGV0aGVyDQo+ID4gPiA+ID4gPiAiYnRfcnNzaV9zdGF0ZSA9PSBCVENfUlNTSV9TVEFURV9ISUdI
IHx8IGJ0X3Jzc2lfc3RhdGUgPT0NCj4gPiA+ID4gPiA+IEJUQ19SU1NJX1NUQVRFX1NUQVlfSElH
SCIgaXMgdHJ1ZSwgYmVjYXVzZSB0aGUgJ3RoZW4nIGFuZCAnZWxzZScNCj4gPiA+ID4gPiA+IGJy
YW5jaGVzIGFyZSBpZGVudGljYWwuIFNob3VsZCBvbmUgb2YgdGhlIGJyYW5jaGVzIGJlIG1vZGlm
aWVkLCBvciB0aGUNCj4gPiA+ID4gPiA+IGVudGlyZSAnaWYnIHN0YXRlbWVudCByZXBsYWNlZD8N
Cj4gPiA+ID4gPiA+ICMgMjk0NXzCoMKgwqB9DQo+ID4gPiA+ID4gPiAjIDI5NDZ8DQo+ID4gPiA+
ID4gPiAjIDI5NDd8LT4gaWYgKChidF9yc3NpX3N0YXRlID09IEJUQ19SU1NJX1NUQVRFX0hJR0gp
IHx8DQo+ID4gPiA+ID4gPiAjIDI5NDh8wqDCoMKgwqDCoMKgKGJ0X3Jzc2lfc3RhdGUgPT0gQlRD
X1JTU0lfU1RBVEVfU1RBWV9ISUdIKSkNCj4gPiA+ID4gPiA+ICMgMjk0OXzCoMKgwqBidGM4ODIx
YTJhbnRfcHNfdGRtYShidGNvZXhpc3QsIE5PUk1BTF9FWEVDLCB0cnVlLCAyNik7DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gRXJyb3I6IElERU5USUNBTF9CUkFOQ0hFUyAoQ1dFLTM5OCk6IFsj
ZGVmMjE0XQ0KPiA+ID4gPiA+ID4ga2VybmVsLTUuMTEuMC0wLnJjNy4xNTEvbGludXgtNS4xMS4w
LTAucmM3LjE1MS5lbDkueDg2XzY0L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lm
aS9idGNvZXhpc3QvaGFsYnRjODgyMWEyYW50LmM6MzEzNToNCj4gPiA+ID4gPiA+IGlkZW50aWNh
bF9icmFuY2hlczogVGhlIHNhbWUgY29kZSBpcyBleGVjdXRlZCByZWdhcmRsZXNzIG9mIHdoZXRo
ZXINCj4gPiA+ID4gPiA+ICJ3aWZpX2J3ID09IEJUQ19XSUZJX0JXX0xFR0FDWSIgaXMgdHJ1ZSwg
YmVjYXVzZSB0aGUgJ3RoZW4nIGFuZCAnZWxzZScNCj4gPiA+ID4gPiA+IGJyYW5jaGVzIGFyZSBp
ZGVudGljYWwuIFNob3VsZCBvbmUgb2YgdGhlIGJyYW5jaGVzIGJlIG1vZGlmaWVkLCBvciB0aGUN
Cj4gPiA+ID4gPiA+IGVudGlyZSAnaWYnIHN0YXRlbWVudCByZXBsYWNlZD8NCj4gPiA+ID4gPiA+
ICMgMzEzM3zCoMKgwqBidGNvZXhpc3QtPmJ0Y19nZXQoYnRjb2V4aXN0LCBCVENfR0VUX1U0X1dJ
RklfQlcsICZ3aWZpX2J3KTsNCj4gPiA+ID4gPiA+ICMgMzEzNHwNCj4gPiA+ID4gPiA+ICMgMzEz
NXwtPiBpZiAod2lmaV9idyA9PSBCVENfV0lGSV9CV19MRUdBQ1kpIHsNCj4gPiA+ID4gPiA+ICMg
MzEzNnzCoMKgwqAvKiBmb3IgSElEIGF0IDExYi9nIG1vZGUgKi8NCj4gPiA+ID4gPiA+ICMgMzEz
N3zCoMKgwqBidGM4ODIxYTJhbnRfY29leF90YWJsZShidGNvZXhpc3QsIE5PUk1BTF9FWEVDLCAw
eDU1ZmY1NWZmLA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEVycm9yOiBJREVOVElDQUxfQlJB
TkNIRVMgKENXRS0zOTgpOiBbI2RlZjIxNV0NCj4gPiA+ID4gPiA+IGtlcm5lbC01LjExLjAtMC5y
YzcuMTUxL2xpbnV4LTUuMTEuMC0wLnJjNy4xNTEuZWw5Lng4Nl82NC9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bHdpZmkvYnRjb2V4aXN0L2hhbGJ0Yzg4MjFhMmFudC5jOjMzMjQ6DQo+
ID4gPiA+ID4gPiBpZGVudGljYWxfYnJhbmNoZXM6IFRoZSBzYW1lIGNvZGUgaXMgZXhlY3V0ZWQg
cmVnYXJkbGVzcyBvZiB3aGV0aGVyDQo+ID4gPiA+ID4gPiAiYnRfcnNzaV9zdGF0ZSA9PSBCVENf
UlNTSV9TVEFURV9ISUdIIHx8IGJ0X3Jzc2lfc3RhdGUgPT0NCj4gPiA+ID4gPiA+IEJUQ19SU1NJ
X1NUQVRFX1NUQVlfSElHSCIgaXMgdHJ1ZSwgYmVjYXVzZSB0aGUgJ3RoZW4nIGFuZCAnZWxzZScN
Cj4gPiA+ID4gPiA+IGJyYW5jaGVzIGFyZSBpZGVudGljYWwuIFNob3VsZCBvbmUgb2YgdGhlIGJy
YW5jaGVzIGJlIG1vZGlmaWVkLCBvciB0aGUNCj4gPiA+ID4gPiA+IGVudGlyZSAnaWYnIHN0YXRl
bWVudCByZXBsYWNlZD8NCj4gPiA+ID4gPiA+ICMgMzMyMnzCoMKgwqB9DQo+ID4gPiA+ID4gPiAj
IDMzMjN8DQo+ID4gPiA+ID4gPiAjIDMzMjR8LT4gaWYgKChidF9yc3NpX3N0YXRlID09IEJUQ19S
U1NJX1NUQVRFX0hJR0gpIHx8DQo+ID4gPiA+ID4gPiAjIDMzMjV8wqDCoMKgwqDCoMKgKGJ0X3Jz
c2lfc3RhdGUgPT0gQlRDX1JTU0lfU1RBVEVfU1RBWV9ISUdIKSkgew0KPiA+ID4gPiA+ID4gIyAz
MzI2fMKgwqDCoGJ0Yzg4MjFhMmFudF9wc190ZG1hKGJ0Y29leGlzdCwgTk9STUFMX0VYRUMsIHRy
dWUsIDIzKTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSW4gbXkgb3Bp
bmlvbiwgdGhleSBzZWVtIHRvIGJlIHJlYWwgYnVncy4gSG93ZXZlciwgaXQncyB2ZXJ5IGRpZmZp
Y3VsdA0KPiA+ID4gPiA+ID4gdG8gaW1hZ2luZSB3aGF0IGFjdGlvbnMgbXVzdCBiZSB0YWtlbiBv
biBlYWNoIGJyYW5jaCBvZiB0aGUgaWYtZWxzZQ0KPiA+ID4gPiA+ID4gYmVjYXVzZSB0aGV5IHN0
cm9uZ2x5IGRlcGVuZCBvbiBtYWdpYyBudW1iZXJzLCB3aGljaCBhcmUgZGlmZmVyZW50DQo+ID4g
PiA+ID4gPiBjb25maWd1cmF0aW9ucyBmb3IgdGhlIGh3LCBJIGd1ZXNzLg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IENhbiB0aGUgbWFpbnRhaW5lcnMgY29uZmlybSBpZiB0aGVzZSBhcmUgcmVh
bCBidWdzIGFuZCBzZWUgaG93IHRvIGZpeCB0aGVtPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IFJlZ2FyZHMNCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiDDjcOxaWdvIEh1Z3VldA0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gSGVsbG8sDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBIGZldyB3ZWVr
cyBhZ28gSSBzZW50IHRoZSBtZXNzYWdlIGFib3ZlIG5vdGlmeWluZyBhIHBvdGVudGlhbCBidWcg
aW4NCj4gPiA+ID4gPiBydGx3aWZpIG1vZHVsZS4gSSBqdXN0IHdhbnRlZCB0byBiZSBzdXJlIHRo
YXQgaXQgaGFzIGJlZW4gcmVjZWl2ZWQuDQo+ID4gPiA+ID4gQ2FuIHRoZSBtYWludGFpbmVycyBh
Y2tub3dsZWRnZSB3aGV0aGVyIHRoZXkgaGF2ZSBzZWVuIGl0Pw0KPiA+ID4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IEhpLA0KPiA+ID4gPg0KPiA+ID4gPiBOb3QgcmVhbCBidWdzLiBUaGUgY29leGlz
dGVuY2UgcHJvZ3JhbW1lcnMgcHJlc2VydmUgdGhlIHNhbWUgY29kZSBvZg0KPiA+ID4gPiBicmFu
Y2hlcyBpbnRlbnRpb25hbGx5IHRvIGZpbmUgdHVuZSBwZXJmb3JtYW5jZSBlYXNpZXIsIGJlY2F1
c2UgYmFuZHdpZHRoIGFuZA0KPiA+ID4gPiBSU1NJIHN0cmVuZ3RoIGFyZSBoaWdobHkgcmVsYXRl
ZCB0byBjb2V4aXN0ZW5jZSBwZXJmb3JtYW5jZS4NCj4gPiA+ID4gVGhlIGJhc2ljIHJ1bGUgb2Yg
cGVyZm9ybWFuY2UgdHVuaW5nIGlzIHRvIGFzc2lnbiBtb3N0IHRpbWUgc2xvdCB0byBCVA0KPiA+
ID4gPiBmb3IgcmVhbHRpbWUgYXBwbGljYXRpb24sIGFuZCBXaUZpIHVzZXMgcmVtYWluaW5nIHRp
bWUgc2xvdCBidXQgZG9uJ3QgbG93ZXINCj4gPiA+ID4gdGhhbiBsb3cgYm91bmQuDQo+ID4gPiA+
DQo+ID4gPiA+DQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+IEkgY2FuIGFkZCBjb21tZW50cy4gRG8g
eW91IG5lZWQgYW55IGtleXdvcmQgd2l0aGluIGNvbW1lbnQgdG8gYXZvaWQgeW91cg0KPiA+IGNo
ZWNraW5nIHRvb2wgd2FybnMgdGhpcyBmYWxzZSBhbGFybT8NCj4gPg0KDQpJIGRvICJnaXQgZ3Jl
cCBjb3Zlcml0eSB8IHdjIC1sIiBhbmQgdGhlcmUgYXJlIG9ubHkgOCBpbnN0YW5jZXMuDQpJJ20g
bm90IHN1cmUgaWYgSSBjYW4gYWRkIGNvbW1lbnRzIHdpdGggImNvdmVyaXR5IiBtYXJrZXIuDQoN
Ci0tDQpQaW5nLUtlDQoNCg==
