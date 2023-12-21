Return-Path: <linux-wireless+bounces-1139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DEA81B042
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 09:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5CE4B20D61
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC016413;
	Thu, 21 Dec 2023 08:25:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612D315AFE
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BL8PgG521323722, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BL8PgG521323722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 16:25:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 21 Dec 2023 16:25:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 21 Dec 2023 16:25:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 21 Dec 2023 16:25:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "martin.kaistra@linutronix.de" <martin.kaistra@linutronix.de>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
Thread-Topic: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on
 port 0 transparent
Thread-Index: AQHaMb/t7UraxeutE0+U7Z3itK4it7Cxt0zAgAAj5oCAAQluAA==
Date: Thu, 21 Dec 2023 08:25:42 +0000
Message-ID: <97e91ccfa2d8118b15166a9f2f25a56f84b460c8.camel@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
	 <20231218143645.433356-20-martin.kaistra@linutronix.de>
	 <56eed6a3e237435f9d21082ca12eeaec@realtek.com>
	 <797e4962-2ff3-4ae5-a1a7-d4d964fb768d@linutronix.de>
In-Reply-To: <797e4962-2ff3-4ae5-a1a7-d4d964fb768d@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <66A69E75E5FF574E96EF7369DC674E69@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDE3OjM0ICswMTAwLCBNYXJ0aW4gS2Fpc3RyYSB3cm90ZToN
Cj4gRXh0ZXJuYWwgbWFpbC4NCj4gDQo+IA0KPiANCj4gQW0gMjAuMTIuMjMgdW0gMDc6Mjggc2No
cmllYiBQaW5nLUtlIFNoaWg6DQo+ID4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogTWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXgu
ZGU+DQo+ID4gPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDE4LCAyMDIzIDEwOjM3IFBNDQo+ID4g
PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogSmVzIFNvcmVu
c2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9y
Zz47IFBpbmctS2UgU2hpaA0KPiA+ID4gPHBrc2hpaEByZWFsdGVrLmNvbT47IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lv
cg0KPiA+ID4gPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCAx
OS8yMF0gd2lmaTogcnRsOHh4eHU6IG1ha2Ugc3VwcG9ydGluZyBBUCBtb2RlIG9ubHkgb24gcG9y
dCAwIHRyYW5zcGFyZW50DQo+ID4gPiANCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgdmlmID0gcHJp
di0+dmlmc1swXTsNCj4gPiA+ICsgICAgICAgcHJpdi0+dmlmc1swXSA9IHByaXYtPnZpZnNbMV07
DQo+ID4gPiArICAgICAgIHByaXYtPnZpZnNbMV0gPSB2aWY7DQo+ID4gPiArICAgICAgIHJ0bHZp
ZiA9IChzdHJ1Y3QgcnRsOHh4eHVfdmlmICopcHJpdi0+dmlmc1sxXS0+ZHJ2X3ByaXY7DQo+ID4g
PiArICAgICAgIHJ0bHZpZi0+cG9ydF9udW0gPSAxOw0KPiA+IA0KPiA+IG5pdDogV291bGQgaXQg
YmUgYmV0dGVyIHRvIHN3YXAgcG9ydF9udW0gYXMgd2VsbD8gQ3VycmVudGx5LCBwb3J0X251bSBv
ZiB2aWZzWzBdDQo+ID4gd2lsbCBiZSBzZXQgdG8gMCBieSBjYWxsZXIsIGJ1dCBub3Qgc3VyZSBp
ZiBmdXJ0aGVyIHBlb3BsZSBjb3VsZCBtaXN1c2UgdGhpcw0KPiA+IGZ1bmN0aW9uLg0KPiANCj4g
dGhlIG1haW4gcmVhc29uLCBJIGRpZCBub3QgaW5jbHVkZSBzZXR0aW5nIHBvcnRfbnVtIGZvciBw
cml2LT52aWZzWzBdLCBpcyB0aGF0DQo+IHByaXYtPnZpZnNbMF0gaXMgYSBOVUxMIHBvaW50ZXIg
aW4gdGhlIGN1cnJlbnQgd2F5IHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIGZyb20NCj4gcnRsOHh4
eHVfYWRkX2ludGVyZmFjZSgpLg0KPiANCj4gZG8geW91IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRv
IGFkZA0KPiANCj4gaWYgKHByaXYtPnZpZnNbMF0pDQo+ICAgICAgICAgcnRsdmlmID0gKHN0cnVj
dCBydGw4eHh4dV92aWYgKilwcml2LT52aWZzWzBdLT5kcnZfcHJpdjsNCj4gICAgICAgICBydGx2
aWYtPnBvcnRfbnVtID0gMDsNCj4gDQo+IGp1c3QgZm9yIGNvbXBsZXRlbmVzcyBzYWtlLCBldmVu
IHRob3VnaCB0aGlzIGNvZGUgcGF0aCB3aWxsIGN1cnJlbnRseSBuZXZlciBnZXQNCj4gZXhlY3V0
ZWQ/DQo+IA0KDQpJIG1pc3NlZCB0aGF0IHBvaW50LiBJIGp1c3QgZGlkIGZvY3VzIG9uICJzd2l0
Y2giLCBidXQgYWN0dWFsbHkgdGhpcyBpcw0KIm1vdmUiIGZyb20gcG9ydCAwIHRvIDEsIHJpZ2h0
PyANCg0KQXMgSSBrbm93LCB0d28gY2FzZXMgb25seSB3b3JrIG9uIHBvcnQgMC4gT25lIGlzIEFQ
IG1vZGUgdGhhdCB5b3UgYXJlDQpkb2luZywgYW5kIHRoZSBvdGhlciBpcyBQUyBpbiBTVEEgbW9k
ZSB0aGF0IGlzbid0IGltcGxlbWVudGVkIGJ5IHJ0bDh4eHh4dS4NCkZvciBBUCBtb2RlLCBjdXJy
ZW50IGltcGxlbWVudCBtb3ZpbmcgcG9ydCAwIHRvIDEgaXMgZmluZS4NCg0KSW4gdGhlIGZ1dHVy
ZSwgUFMgaW4gU1RBIG1vZGUgY291bGQgbmVlZCB0byBtb3ZlIHBvcnQgMSB0byAwLCBiZWNhdXNl
IA0Kd2UgbWF5IGRpc2Nvbm5lY3QgcG9ydCAwIGZpcnN0IGFuZCB3ZSB3YW50IFNUQSBvbiBwb3J0
IDEgZW50ZXJpbmcgUFMuDQoNCkJ1dCwgSSB0aGluayB3ZSBjYW4gZGVmZXIgdGhpcyB1bnRpbCB3
ZSByZWFsbHkgbmVlZCBpdC4gDQoNCg0K

