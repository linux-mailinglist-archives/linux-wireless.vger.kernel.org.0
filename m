Return-Path: <linux-wireless+bounces-1144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA681B6A5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 13:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED66A1C23007
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E476DB4;
	Thu, 21 Dec 2023 12:51:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7D76DA3
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BLCos4U31427669, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BLCos4U31427669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 20:50:54 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 21 Dec 2023 20:50:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 21 Dec 2023 20:50:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 21 Dec 2023 20:50:54 +0800
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
Thread-Index: AQHaMb/t7UraxeutE0+U7Z3itK4it7Cxt0zAgAAj5oCAAQluAIAAKeiAgAAgL4A=
Date: Thu, 21 Dec 2023 12:50:54 +0000
Message-ID: <63bdc9685e553cb745f1e1ae0acbeee4233413ab.camel@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
	 <20231218143645.433356-20-martin.kaistra@linutronix.de>
	 <56eed6a3e237435f9d21082ca12eeaec@realtek.com>
	 <797e4962-2ff3-4ae5-a1a7-d4d964fb768d@linutronix.de>
	 <97e91ccfa2d8118b15166a9f2f25a56f84b460c8.camel@realtek.com>
	 <2c444230-bf30-427e-a498-877ed6d3e7cd@linutronix.de>
In-Reply-To: <2c444230-bf30-427e-a498-877ed6d3e7cd@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2147B501C95844DAF92870461B77E5A@realtek.com>
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

T24gVGh1LCAyMDIzLTEyLTIxIGF0IDExOjU0ICswMTAwLCBNYXJ0aW4gS2Fpc3RyYSB3cm90ZToN
Cj4gDQo+IEFtIDIxLjEyLjIzIHVtIDA5OjI1IHNjaHJpZWIgUGluZy1LZSBTaGloOg0KPiA+IE9u
IFdlZCwgMjAyMy0xMi0yMCBhdCAxNzozNCArMDEwMCwgTWFydGluIEthaXN0cmEgd3JvdGU6DQo+
ID4gPiANCj4gPiA+IEFtIDIwLjEyLjIzIHVtIDA3OjI4IHNjaHJpZWIgUGluZy1LZSBTaGloOg0K
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogTWFy
dGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+ID4gPiA+ID4gU2Vu
dDogTW9uZGF5LCBEZWNlbWJlciAxOCwgMjAyMyAxMDozNyBQTQ0KPiA+ID4gPiA+IFRvOiBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiBDYzogSmVzIFNvcmVuc2VuIDxK
ZXMuU29yZW5zZW5AZ21haWwuY29tPjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IFBp
bmctS2UgU2hpaA0KPiA+ID4gPiA+IDxwa3NoaWhAcmVhbHRlay5jb20+OyBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT47IFNlYmFzdGlhbiBBbmRyemVqDQo+ID4gPiA+
ID4gU2lld2lvcg0KPiA+ID4gPiA+IDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+ID4gPiA+ID4g
U3ViamVjdDogW1BBVENIIDE5LzIwXSB3aWZpOiBydGw4eHh4dTogbWFrZSBzdXBwb3J0aW5nIEFQ
IG1vZGUgb25seSBvbiBwb3J0IDAgdHJhbnNwYXJlbnQNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gKyAgICAgICB2aWYgPSBwcml2LT52aWZzWzBdOw0KPiA+ID4gPiA+ICsgICAg
ICAgcHJpdi0+dmlmc1swXSA9IHByaXYtPnZpZnNbMV07DQo+ID4gPiA+ID4gKyAgICAgICBwcml2
LT52aWZzWzFdID0gdmlmOw0KPiA+ID4gPiA+ICsgICAgICAgcnRsdmlmID0gKHN0cnVjdCBydGw4
eHh4dV92aWYgKilwcml2LT52aWZzWzFdLT5kcnZfcHJpdjsNCj4gPiA+ID4gPiArICAgICAgIHJ0
bHZpZi0+cG9ydF9udW0gPSAxOw0KPiA+ID4gPiANCj4gPiA+ID4gbml0OiBXb3VsZCBpdCBiZSBi
ZXR0ZXIgdG8gc3dhcCBwb3J0X251bSBhcyB3ZWxsPyBDdXJyZW50bHksIHBvcnRfbnVtIG9mIHZp
ZnNbMF0NCj4gPiA+ID4gd2lsbCBiZSBzZXQgdG8gMCBieSBjYWxsZXIsIGJ1dCBub3Qgc3VyZSBp
ZiBmdXJ0aGVyIHBlb3BsZSBjb3VsZCBtaXN1c2UgdGhpcw0KPiA+ID4gPiBmdW5jdGlvbi4NCj4g
PiA+IA0KPiA+ID4gdGhlIG1haW4gcmVhc29uLCBJIGRpZCBub3QgaW5jbHVkZSBzZXR0aW5nIHBv
cnRfbnVtIGZvciBwcml2LT52aWZzWzBdLCBpcyB0aGF0DQo+ID4gPiBwcml2LT52aWZzWzBdIGlz
IGEgTlVMTCBwb2ludGVyIGluIHRoZSBjdXJyZW50IHdheSB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxl
ZCBmcm9tDQo+ID4gPiBydGw4eHh4dV9hZGRfaW50ZXJmYWNlKCkuDQo+ID4gPiANCj4gPiA+IGRv
IHlvdSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBhZGQNCj4gPiA+IA0KPiA+ID4gaWYgKHByaXYt
PnZpZnNbMF0pDQo+ID4gPiAgICAgICAgICBydGx2aWYgPSAoc3RydWN0IHJ0bDh4eHh1X3ZpZiAq
KXByaXYtPnZpZnNbMF0tPmRydl9wcml2Ow0KPiA+ID4gICAgICAgICAgcnRsdmlmLT5wb3J0X251
bSA9IDA7DQo+ID4gPiANCj4gPiA+IGp1c3QgZm9yIGNvbXBsZXRlbmVzcyBzYWtlLCBldmVuIHRo
b3VnaCB0aGlzIGNvZGUgcGF0aCB3aWxsIGN1cnJlbnRseSBuZXZlciBnZXQNCj4gPiA+IGV4ZWN1
dGVkPw0KPiA+ID4gDQo+ID4gDQo+ID4gSSBtaXNzZWQgdGhhdCBwb2ludC4gSSBqdXN0IGRpZCBm
b2N1cyBvbiAic3dpdGNoIiwgYnV0IGFjdHVhbGx5IHRoaXMgaXMNCj4gPiAibW92ZSIgZnJvbSBw
b3J0IDAgdG8gMSwgcmlnaHQ/DQo+IA0KPiBZZXMsIGN1cnJlbnRseSwgdGhlIGZ1bmN0aW9uIGlz
IG9ubHkgdXNlZCB0byBtb3ZlIHRoZSBTVEEgbW9kZSBpbnRlcmZhY2UgZnJvbSAwDQo+IHRvIDEg
aW4gb3JkZXIgdG8gbWFrZSByb29tIGZvciBBUCBvbiAwLg0KPiANCj4gSSB3aWxsIGxlYXZlIHRo
aXMgcGF0Y2ggYXMgaXMgZm9yIHYyLiBXaGVuIHRoZSBmdW5jdGlvbiBpcyB1c2VkIGluIHRoZSBm
dXR1cmUNCj4gZm9yIGEgZGlmZmVyZW50IHNjZW5hcmlvLCB0aGUgcG9zc2liaWxpdHkgb2Ygdmlm
c1swXSBvciB2aWZzWzFdIGJlaW5nIE5VTEwgbmVlZHMNCj4gdG8gYmUgdGhvdWdodCB0aHJvdWdo
IGFueXdheSBhbmQgaWYgbmVjZXNzYXJ5IHRoZSBzZXR0aW5nIG9mIHBvcnRfbnVtID0gMCBjYW4g
YmUNCj4gYWRkZWQgdGhlbiBhcyB3ZWxsLg0KPiANCg0KV291bGQgeW91IGxpa2UgdG8gYWRkIGEg
Y29tbWVudCBsaWtlIGFib3ZlIGRlc2NyaXB0aW9uIHRvIGhlbHAgcGVvcGxlIHRvDQp1bmRlcnN0
YW5kIHlvdXIgdGhpbmtpbmc/DQoNCkFueXdheSwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1l
LiBQbGVhc2UgYWRkIG15IHJldmlld2VkLWJ5IGJ5IHYyLg0KDQoNCg==

