Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51BA36F306
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Apr 2021 01:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhD2XoJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 19:44:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50294 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhD2XoI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 19:44:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13TNhEW31015035, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13TNhEW31015035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Apr 2021 07:43:14 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 30 Apr 2021 07:43:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 30 Apr 2021 07:43:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Fri, 30 Apr 2021 07:43:12 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "briannorris@chromium.org" <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH v4 13/19] rtw89: 8852a: add 8852a specific files
Thread-Topic: [PATCH v4 13/19] rtw89: 8852a: add 8852a specific files
Thread-Index: AQHXPM49PxtB+Doz90uTeXPis0u1MKrLeI8AgAAqjIA=
Date:   Thu, 29 Apr 2021 23:43:12 +0000
Message-ID: <1619739791.1874.18.camel@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
         <20210429080149.7068-14-pkshih@realtek.com> <YIsg3iv6d4L6n9Uk@google.com>
In-Reply-To: <YIsg3iv6d4L6n9Uk@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.224.74.234]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkg5LiL5Y2IIDEwOjAwOjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <095833042F5A0B43B8DF94CBA6E3C8DD@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 23:30:43
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163420 [Apr 29 2021]
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
X-KSE-Antiphishing-Bases: 04/29/2021 23:34:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 23:30:43
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163420 [Apr 29 2021]
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
X-KSE-Antiphishing-Bases: 04/29/2021 23:34:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTI5IGF0IDIxOjEwICswMDAwLCBCcmlhbiBOb3JyaXMgd3JvdGU6DQo+
IEhpLA0KPiANCj4gT24gVGh1LCBBcHIgMjksIDIwMjEgYXQgMDQ6MDE6NDNQTSArMDgwMCwgUGlu
Zy1LZSBTaGloIHdyb3RlOg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJhLmMNCj4gPiBAQCAtMCwwICsxLDIwNDcg
QEANCj4gLi4uDQo+ID4gK3N0YXRpYyB2b2lkIHJ0dzg4NTJhX2J0Y19pbml0X2NmZyhzdHJ1Y3Qg
cnR3ODlfZGV2ICpydHdkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBydHc4OV9idGMgKmJ0YyA9
ICZydHdkZXYtPmJ0YzsNCj4gPiArCXN0cnVjdCBydHc4OV9idGNfbW9kdWxlICptb2R1bGUgPSAm
YnRjLT5tZGluZm87DQo+ID4gKwljb25zdCBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvICpjaGlwID0g
cnR3ZGV2LT5jaGlwOw0KPiA+ICsJY29uc3Qgc3RydWN0IHJ0dzg5X21hY19heF9jb2V4IGNvZXhf
cGFyYW1zID0gew0KPiA+ICsJCS5wdGFfbW9kZSA9IFJUVzg5X01BQ19BWF9DT0VYX1JUS19NT0RF
LA0KPiA+ICsJCS5kaXJlY3Rpb24gPSBSVFc4OV9NQUNfQVhfQ09FWF9JTk5FUiwNCj4gPiArCX07
DQo+ID4gKw0KPiA+ICsJLyogUFRBIGluaXTCoMKgKi8NCj4gPiArCXJ0dzg5X21hY19jb2V4X2lu
aXQocnR3ZGV2LCAmY29leF9wYXJhbXMpOw0KPiA+ICsNCj4gPiArCS8qIHNldCBXTCBUeCByZXNw
b25zZSA9IEhpLVByaSAqLw0KPiA+ICsJY2hpcC0+b3BzLT5idGNfc2V0X3dsX3ByaShydHdkZXYs
IEJUQ19QUklfTUFTS19UWF9SRVNQLCB0cnVlKTsNCj4gPiArDQo+ID4gKwkvKiBzZXQgcmYgZ250
IGRlYnVnIG9mZiAqLw0KPiA+ICsJcnR3ODlfd3JpdGVfcmYocnR3ZGV2LCBSRl9QQVRIX0EsIFJS
X1dMU0VMLCAweGZmZmZmLCAweDApOw0KPiANCj4gSSBmaXJlZCB0aGlzIHVwIGFuZCBxdWlja2x5
IHJhbiBpbnRvIHRoaXM6DQo+IA0KPiBbIDE3NDYuMDYxMDE1XSBCVUc6IHNsZWVwaW5nIGZ1bmN0
aW9uIGNhbGxlZCBmcm9tIGludmFsaWQgY29udGV4dCBhdCBrZXJuZWwvbG9ja2luZy9tdXRleC5j
OjI4MQ0KPiBbIDE3NDYuMDYxMDI5XSBpbl9hdG9taWMoKTogMCwgaXJxc19kaXNhYmxlZCgpOiAw
LCBub25fYmxvY2s6IDAsIHBpZDogODM4LCBuYW1lOiB3cGFfc3VwcGxpY2FudA0KPiBbIDE3NDYu
MDYxMDM3XSBDUFU6IDIgUElEOiA4MzggQ29tbTogd3BhX3N1cHBsaWNhbnQgVGFpbnRlZDogR8Kg
wqDCoMKgwqDCoMKgwqBXwqDCoMKgwqDCoMKgwqDCoMKgNS4xMC4yNyAjMw0KPiAuLi4NCj4gWyAx
NzQ2LjA2MTA0N10gQ2FsbCBUcmFjZToNCj4gWyAxNzQ2LjA2MTA2MV3CoMKgZHVtcF9zdGFjaysw
eDllLzB4ZTkNCj4gWyAxNzQ2LjA2MTA4MF3CoMKgX19fbWlnaHRfc2xlZXArMHgxNTQvMHgxNmEN
Cj4gWyAxNzQ2LjA2MTA5M13CoMKgbXV0ZXhfbG9jaysweDIwLzB4M2MNCj4gWyAxNzQ2LjA2MTEw
Nl3CoMKgcnR3ODg1MmFfYnRjX2luaXRfY2ZnKzB4NjAvMHgxNzcgW3J0dzg5X2NvcmVdDQo+IFsg
MTc0Ni4wNjExMjddwqDCoHJ0dzg5X2J0Y19udGZ5X3JhZGlvX3N0YXRlKzB4YjgvMHgxMTUgW3J0
dzg5X2NvcmVdDQo+IFsgMTc0Ni4wNjExNTNdwqDCoF9faXRlcmF0ZV9pbnRlcmZhY2VzKzB4YTkv
MHgxMDkgW21hYzgwMjExXQ0KPiBbIDE3NDYuMDYxMTY1XcKgwqA/IHJ0dzg5X2xlYXZlX2xwcysw
eDQ0LzB4NDQgW3J0dzg5X2NvcmVdDQo+IFsgMTc0Ni4wNjExNzVdwqDCoD8gcnR3ODlfbGVhdmVf
bHBzKzB4NDQvMHg0NCBbcnR3ODlfY29yZV0NCj4gWyAxNzQ2LjA2MTE5NF3CoMKgaWVlZTgwMjEx
X2l0ZXJhdGVfYWN0aXZlX2ludGVyZmFjZXNfYXRvbWljKzB4MzMvMHg0MCBbbWFjODAyMTFdDQo+
IFsgMTc0Ni4wNjEyMDVdwqDCoHJ0dzg5X29wc19zd19zY2FuX3N0YXJ0KzB4MmUvMHg0OCBbcnR3
ODlfY29yZV0NCj4gWyAxNzQ2LjA2MTIzNF3CoMKgZHJ2X3N3X3NjYW5fc3RhcnQrMHg5Ny8weGYw
IFttYWM4MDIxMV0NCj4gWyAxNzQ2LjA2MTI2MV3CoMKgX19pZWVlODAyMTFfc3RhcnRfc2Nhbisw
eDNjNy8weDRhZSBbbWFjODAyMTFdDQo+IFsgMTc0Ni4wNjEyODRdwqDCoGllZWU4MDIxMV9yZXF1
ZXN0X3NjYW4rMHgzMy8weDRmIFttYWM4MDIxMV0NCj4gWyAxNzQ2LjA2MTMwN13CoMKgcmRldl9z
Y2FuKzB4NzIvMHhkMSBbY2ZnODAyMTFdDQo+IFsgMTc0Ni4wNjEzMzVdwqDCoG5sODAyMTFfdHJp
Z2dlcl9zY2FuKzB4NjEwLzB4NjY5IFtjZmc4MDIxMV0NCj4gWyAxNzQ2LjA2MTM0OV3CoMKgZ2Vu
bF9yY3ZfbXNnKzB4M2IwLzB4M2UwDQo+IFsgMTc0Ni4wNjEzNzJdwqDCoD8gbmw4MDIxMV91cGRh
dGVfbWVzaF9jb25maWcrMHgxYjcvMHgxYjcgW2NmZzgwMjExXQ0KPiBbIDE3NDYuMDYxMzgyXcKg
wqA/IGdlbmxfcmN2KzB4MzYvMHgzNg0KPiBbIDE3NDYuMDYxMzg3XcKgwqBuZXRsaW5rX3Jjdl9z
a2IrMHg4OS8weGZiDQo+IFsgMTc0Ni4wNjEzOTRdwqDCoGdlbmxfcmN2KzB4MjgvMHgzNg0KPiBb
IDE3NDYuMDYxNDAwXcKgwqBuZXRsaW5rX3VuaWNhc3QrMHgxNjkvMHgyM2INCj4gWyAxNzQ2LjA2
MTQwOF3CoMKgbmV0bGlua19zZW5kbXNnKzB4Mzc5LzB4M2YxDQo+IFsgMTc0Ni4wNjE0MTZdwqDC
oHNvY2tfc2VuZG1zZysweDcyLzB4NzYNCj4gWyAxNzQ2LjA2MTQyM13CoMKgX19fX3N5c19zZW5k
bXNnKzB4MTcxLzB4MWVhDQo+IFsgMTc0Ni4wNjE0MjldwqDCoD8gY29weV9tc2doZHJfZnJvbV91
c2VyKzB4ODIvMHhhYQ0KPiBbIDE3NDYuMDYxNDM2XcKgwqBfX19zeXNfc2VuZG1zZysweGEwLzB4
ZGMNCj4gWyAxNzQ2LjA2MTQ0NV3CoMKgPyBfY29weV9mcm9tX3VzZXIrMHg3MC8weDljDQo+IFsg
MTc0Ni4wNjE0NTFdwqDCoF9fc3lzX3NlbmRtc2crMHg4Yy8weGM2DQo+IFsgMTc0Ni4wNjE0NjBd
wqDCoGRvX3N5c2NhbGxfNjQrMHg0My8weDU1DQo+IFsgMTc0Ni4wNjE0NjddwqDCoGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCj4gDQo+IHJ0dzg5X3dyaXRlX3JmKCkg
aXMgaG9sZGluZyBhIG11dGV4IChyZl9tdXRleCkuIEp1ZGdpbmcgYnkgaXRzIHRyaXZpYWwNCj4g
dXNhZ2UgKGl0J3Mgb25seSBwcm90ZWN0aW5nIHJlZ2lzdGVyIHJlYWRzL3dyaXRlcyksIGl0IHBy
b2JhYmx5IGNvdWxkIGJlDQo+IGEgc3BpbmxvY2sgaW5zdGVhZCAtLSBhbHRob3VnaCBJIGRvIG5v
dGUgc29tZSBtYWdpYyB1ZGVsYXkoKXMgaW4gdGhlcmUuDQo+IA0KDQpUaGUgdWRlbGF5KCkgaXMg
bmVlZGVkIHRvIGVuc3VyZSB0aGUgaW5kaXJlY3Qtd3JpdGUgY29ycmVjdC4NCg0KPiBBbHRlcm5h
dGl2ZWx5LCBpdCBsb29rcyBsaWtlIHlvdSdkIGJlIHNhZmUgbW92aW5nIHRvIHRoZSBub24tYXRv
bWljDQo+IGllZWU4MDIxMV9pdGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzKCkgaW4gcnR3ODlfbGVh
dmVfbHBzKCkuDQo+IA0KDQpGb3IgbW9zdCBjYXNlcyBvZsKgcnR3ODlfbGVhdmVfbHBzKCksIHdl
IGNhbiB1c2XCoGllZWU4MDIxMV9pdGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzKCksDQp3aGljaCBo
b2xkIGlmbGlzdF9tdHggbG9jaywgZXhjZXB0IHRvwqANCg0KCWllZWU4MDIxMV9yZWNhbGNfcHMo
bG9jYWwpOwkvLyBoZWxkIGlmbGlzdF9tdHggbG9jaw0KCQkuLi4NCgkJaWVlZTgwMjExX2h3X2Nv
bmZpZw0KCQkJLi4uDQoJCQlydHc4OV9sZWF2ZV9scHMoKQ0KCQkJCS4uLg0KCQkJCWllZWU4MDIx
MV9pdGVyYXRlX2FjdGl2ZV9pbnRlcmZhY2VzKCkNCg0KVGhhdCB3aWxsIGxlYWRzIGRlYWRsb2Nr
Lg0KDQpBbm90aGVyIHZhcmlhbnQgaWVlZTgwMjExX2l0ZXJhdGVfYWN0aXZlX2ludGVyZmFjZXNf
bXR4KCkgdGhhdCBkb2Vzbid0DQpob2xkIGEgbG9jayBtYXkgYmUgYSBzb2x1dGlvbi4gVGhlIHRo
ZSBjb21tZW50IHNheXMgIlRoaXMgdmVyc2lvbiBjYW4NCm9ubHkgYmUgdXNlZCB3aGlsZSBob2xk
aW5nIHRoZSBSVE5MLiIsIGFuZCB0aGUgY29kZSB3aXRoaW4gdGhlIGZ1bmN0aW9uDQpzYXlzICJs
b2NrZGVwX2Fzc2VydF93aXBoeShody0+d2lwaHkpOyIuIEknbSBub3Qgc3VyZSBpZiBJIGNhbiB1
c2UgaXQNCnRvIHByZXZlbnQgbG9ja2luZyBpZmxpc3RfbXR4IHR3aWNlLg0KDQpJZiBJIGNhbiB1
c2UgaXQsIEkgY2FuIGFkZCBhIGFyZ3VtZW50ICdtdHgnLCBsaWtlIHJ0dzg5X2xlYXZlX2xwcyhy
dHdkZXYsIGJvb2wgbXR4KSwNCnRvIGp1ZGdlIHVzaW5nIGllZWU4MDIxMV9pdGVyYXRlX2FjdGl2
ZV9pbnRlcmZhY2VzKCkgb3IgaWVlZTgwMjExX2l0ZXJhdGVfYWN0aXZlX2ludGVyZmFjZXNfbXR4
KCkuDQoNCkknbSBhbHNvIHRoaW5raW5nIHRoYXQgd2UgY2FuIHN0aWxsIHVzZcKgaWVlZTgwMjEx
X2l0ZXJhdGVfYWN0aXZlX2ludGVyZmFjZXNfYXRvbWljKCkNCnRvIG1lcmVseSBjb2xsZWN0wqBy
dHd2aWYtPm1hY19pZCBsaXN0LCBhbmQgdXNlIGEgbG9vcCB0byBkbyBsZWF2ZV9scHMNCm91dCBv
ZiB0aGUgYXRvbWljIGl0ZXJhdGUuDQoNCi0tDQpQaW5nLUtlDQoNCg0K
