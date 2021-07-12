Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1183C46C2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGLG2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 02:28:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53481 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhGLG06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 02:26:58 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16C6O1YV0006928, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16C6O1YV0006928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Jul 2021 14:24:01 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 14:24:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 14:24:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Mon, 12 Jul 2021 14:24:00 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 13/24] rtw89: 8852a: add 8852a specific files
Thread-Topic: [PATCH 13/24] rtw89: 8852a: add 8852a specific files
Thread-Index: AQHXZA3ewqaybdVDZUavwvYocs019qs7SnGAgAN5flA=
Date:   Mon, 12 Jul 2021 06:24:00 +0000
Message-ID: <de0ed6250b864d63ae39d7778b6b7b63@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-14-pkshih@realtek.com>
 <20210710052753.GA485@pengutronix.de>
In-Reply-To: <20210710052753.GA485@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTEg5LiL5Y2IIDAxOjA3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTIg5LiK5Y2IIDAyOjMxOjAw?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/12/2021 06:10:42
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164973 [Jul 12 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/12/2021 06:13:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9sZWtzaWogUmVtcGVsIFtt
YWlsdG86by5yZW1wZWxAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDEw
LCAyMDIxIDE6MjggUE0NCj4gVG86IFBrc2hpaA0KPiBDYzoga3ZhbG9AY29kZWF1cm9yYS5vcmc7
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEz
LzI0XSBydHc4OTogODg1MmE6IGFkZCA4ODUyYSBzcGVjaWZpYyBmaWxlcw0KPiANCj4gT24gRnJp
LCBKdW4gMTgsIDIwMjEgYXQgMDI6NDY6MTRQTSArMDgwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0K
PiA+ICtzdGF0aWMgc3RydWN0IHJ0dzg5X2hmY19wYXJhbV9pbmkgcnR3ODg1MmFfaGZjX3BhcmFt
X2luaV9wY2llW10gPSB7DQo+ID4gKwlbUlRXODlfUVRBX1NDQ10gPSB7cnR3ODg1MmFfaGZjX2No
Y2ZnX3BjaWUsICZydHc4ODUyYV9oZmNfcHViY2ZnX3BjaWUsDQo+ID4gKwkJCSAgICZydHdfaGZj
X3ByZWNjZmdfcGNpZSwgUlRXODlfSENJRkNfUE9IfSwNCj4gPiArCVtSVFc4OV9RVEFfREJDQ10g
PSB7cnR3ODg1MmFfaGZjX2NoY2ZnX3BjaWUsICZydHc4ODUyYV9oZmNfcHViY2ZnX3BjaWUsDQo+
ID4gKwkJCSAgICAmcnR3X2hmY19wcmVjY2ZnX3BjaWUsIFJUVzg5X0hDSUZDX1BPSH0sDQo+ID4g
KwlbUlRXODlfUVRBX1NDQ19TVEZdID0ge3J0dzg4NTJhX2hmY19jaGNmZ19wY2llX3N0ZiwNCj4g
PiArCQkJICAgICAgICZydHc4ODUyYV9oZmNfcHViY2ZnX3BjaWVfc3RmLA0KPiA+ICsJCQkgICAg
ICAgJnJ0d19oZmNfcHJlY2NmZ19wY2llX3N0ZiwgUlRXODlfSENJRkNfU1RGfSwNCj4gPiArCVtS
VFc4OV9RVEFfREJDQ19TVEZdID0ge3J0dzg4NTJhX2hmY19jaGNmZ19wY2llX3N0ZiwNCj4gPiAr
CQkJCSZydHc4ODUyYV9oZmNfcHViY2ZnX3BjaWVfc3RmLA0KPiA+ICsJCQkJJnJ0d19oZmNfcHJl
Y2NmZ19wY2llX3N0ZiwgUlRXODlfSENJRkNfU1RGfSwNCj4gPiArCVtSVFc4OV9RVEFfU1VfVFBd
ID0ge3J0dzg4NTJhX2hmY19jaGNmZ19wY2llX3N1dHAsDQo+ID4gKwkJCSAgICAgJnJ0dzg4NTJh
X2hmY19wdWJjZmdfcGNpZV9zdXRwLA0KPiA+ICsJCQkgICAgICZydHdfaGZjX3ByZWNjZmdfcGNp
ZSwgUlRXODlfSENJRkNfUE9IfSwNCj4gPiArCVtSVFc4OV9RVEFfRExGV10gPSB7TlVMTCwgTlVM
TCwgJnJ0d19oZmNfcHJlY2NmZ19wY2llLCBSVFc4OV9IQ0lGQ19QT0h9LA0KPiA+ICsJW1JUVzg5
X1FUQV9MQU1PREVdID0ge3J0dzg4NTJhX2hmY19jaGNmZ19wY2llX2xhLA0KPiA+ICsJCQkgICAg
ICAmcnR3ODg1MmFfaGZjX3B1YmNmZ19wY2llX2xhLA0KPiA+ICsJCQkgICAgICAmcnR3X2hmY19w
cmVjY2ZnX3BjaWUsIFJUVzg5X0hDSUZDX1BPSH0sDQo+ID4gKwlbUlRXODlfUVRBX0lOVkFMSURd
ID0ge05VTEx9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBydHc4OV9kbGVf
bWVtIHJ0dzg4NTJhX2RsZV9tZW1fcGNpZVtdID0gew0KPiA+ICsJW1JUVzg5X1FUQV9TQ0NdID0g
e1JUVzg5X1FUQV9TQ0MsICZ3ZGVfc2l6ZTAsICZwbGVfc2l6ZTAsICZ3ZGVfcXQwLA0KPiA+ICsJ
CQkgICAgJndkZV9xdDAsICZwbGVfcXQ0LCAmcGxlX3F0NX0sDQo+ID4gKwlbUlRXODlfUVRBX0RC
Q0NdID0ge1JUVzg5X1FUQV9EQkNDLCAmd2RlX3NpemUwLCAmcGxlX3NpemUwLCAmd2RlX3F0MCwN
Cj4gPiArCQkJICAgICZ3ZGVfcXQwLCAmcGxlX3F0MCwgJnBsZV9xdDF9LA0KPiA+ICsJW1JUVzg5
X1FUQV9TQ0NfU1RGXSA9IHtSVFc4OV9RVEFfU0NDX1NURiwgJndkZV9zaXplMSwgJnBsZV9zaXpl
MiwNCj4gPiArCQkJICAgICAgICZ3ZGVfcXQxLCAmd2RlX3F0MSwgJnBsZV9xdDgsICZwbGVfcXQ5
fSwNCj4gPiArCVtSVFc4OV9RVEFfREJDQ19TVEZdID0ge1JUVzg5X1FUQV9EQkNDX1NURiwgJndk
ZV9zaXplMSwgJnBsZV9zaXplMiwNCj4gPiArCQkJCSZ3ZGVfcXQxLCAmd2RlX3F0MSwgJnBsZV9x
dDEwLCAmcGxlX3F0MTF9LA0KPiA+ICsJW1JUVzg5X1FUQV9TVV9UUF0gPSB7UlRXODlfUVRBX1NV
X1RQLCAmd2RlX3NpemUzLCAmcGxlX3NpemUzLA0KPiA+ICsJCQkgICAgICZ3ZGVfcXQzLCAmd2Rl
X3F0MywgJnBsZV9xdDEyLCAmcGxlX3F0MTJ9LA0KPiA+ICsJW1JUVzg5X1FUQV9ETEZXXSA9IHtS
VFc4OV9RVEFfRExGVywgJndkZV9zaXplNCwgJnBsZV9zaXplNCwNCj4gPiArCQkJICAgICZ3ZGVf
cXQ0LCAmd2RlX3F0NCwgJnBsZV9xdDEzLCAmcGxlX3F0MTN9LA0KPiA+ICsJW1JUVzg5X1FUQV9M
QU1PREVdID0ge1JUVzg5X1FUQV9MQU1PREUsICZ3ZGVfc2l6ZTEwLCAmcGxlX3NpemUxMCwNCj4g
PiArCQkJICAgICAgJndkZV9xdDksICZ3ZGVfcXQ5LCAmcGxlX3F0MjMsICZwbGVfcXQyNH0sDQo+
ID4gKwlbUlRXODlfUVRBX0lOVkFMSURdID0ge1JUVzg5X1FUQV9JTlZBTElELCBOVUxMLCBOVUxM
LCBOVUxMLCBOVUxMLCBOVUxMLA0KPiA+ICsJCQkgICAgICAgTlVMTH0sDQo+ID4gK307DQo+IA0K
PiBJRiBJIHNlZSBpdCBjb3JyZWN0bHksIG9ubHkgc29tZSBvZiB0aGlzIFJUVzg5X1FUQV8qIG1v
ZGVzIGFyZSBhY3R1YWxseQ0KPiB1c2VkLg0KPiBJZiB0aGlzIG1vZGVzIGFyZSBub3QgdXNlZCBi
eSB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgZHJpdmVyLCBwbGVhc2UNCj4gcmVtb3ZlIGl0Lg0K
PiANCj4gUlRXODlfUVRBX1NDQywgUlRXODlfUVRBX0RMRlcgYW5kIFJUVzg5X1FUQV9JTlZBTElE
IC0gYXJlIHJlcXVlc3RlZA0KPiBSVFc4OV9RVEFfREJDQywgUlRXODlfUVRBX1NVX1RQIC0gbm90
IHVzZWQuIElmIHNvLCBwbGVhc2UgcmVtb3ZlLg0KPiBSVFc4OV9RVEFfU0NDX1NURiwgUlRXODlf
UVRBX0RCQ0NfU1RGIGFuZCBSVFc4OV9RVEFfTEFNT0RFIC0ga2luZCBvZiB1c2VkIGJ1dA0KPiBu
ZXZlciBzZXQvcmVxdWVzdGVkPyBJZiBzbywgcGxlYXNlIHJlbW92ZSB0aGUgbW9kZXMgYW5kIHRo
ZSBjb2RlIHdoaWNoDQo+IGRlcGVuZHMgb24gaXQuIEZvciBleGFtcGxlIGRsZV9yc3ZkX3NpemUo
KSBpcyBleGVjdXRlZCBpZiBSVFc4OV9RVEFfTEFNT0RFIGlzDQo+IHNldCwgYnV0IEkgY2FuIGZp
bmQgYW55IHBsYXkgd2hlcmUgaXQgaXMgYWN0dWFsbHkgc2V0Lg0KPiANCg0KV2lsbCByZW1vdmUg
dW51c2VkIHBhcnRzLg0KDQoNCg==
