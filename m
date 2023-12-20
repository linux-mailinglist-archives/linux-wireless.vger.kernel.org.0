Return-Path: <linux-wireless+bounces-1067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24978198A6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 07:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FA21F254F4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 06:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73851DA5E;
	Wed, 20 Dec 2023 06:33:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4E1D52B
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BK6XFQT0518777, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BK6XFQT0518777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:33:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Dec 2023 14:33:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 20 Dec 2023 14:33:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 20 Dec 2023 14:33:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Martin Kaistra
	<martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH 00/20] wifi: rtl8xxxu: Add concurrent mode for 8188f
Thread-Topic: [PATCH 00/20] wifi: rtl8xxxu: Add concurrent mode for 8188f
Thread-Index: AQHaMb+zIz6Afsg4L0qYGcXjaoHuWbCwpMUAgAETjXA=
Date: Wed, 20 Dec 2023 06:33:14 +0000
Message-ID: <30978c4d4d92493f81dbf6f7ca379e54@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <4f347036-4456-48be-829a-b8c39d5091ff@gmail.com>
In-Reply-To: <4f347036-4456-48be-829a-b8c39d5091ff@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIg
MjAsIDIwMjMgNjowMyBBTQ0KPiBUbzogTWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxp
bnV0cm9uaXguZGU+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEplcyBT
b3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5l
bC5vcmc+OyBQaW5nLUtlIFNoaWgNCj4gPHBrc2hpaEByZWFsdGVrLmNvbT47IFNlYmFzdGlhbiBB
bmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAwMC8yMF0gd2lmaTogcnRsOHh4eHU6IEFkZCBjb25jdXJyZW50IG1vZGUgZm9yIDgxODhm
DQo+IA0KPiBPbiAxOC8xMi8yMDIzIDE2OjM2LCBNYXJ0aW4gS2Fpc3RyYSB3cm90ZToNCj4gPiBU
aGlzIHNlcmllcyBhZGRzIHRoZSBwb3NzaWJpbGl0eSB0byB1c2UgdHdvIHZpcnR1YWwgaW50ZXJm
YWNlcyBvbiB0aGUNCj4gPiBzYW1lIGNoYW5uZWwuIFN1cHBvcnRlZCBjb21iaW5hdGlvbnMgYXJl
IFNUQStTVEEgYW5kIFNUQStBUC4gVGhlDQo+ID4gY29udmVyc2lvbiBvZiB0aGUgZHJpdmVyIHRv
IHN1cHBvcnQgbXVsdGlwbGUgaW50ZXJmYWNlcyBpcyBzcGxpdCBpbnRvDQo+ID4gaW5kaXZpZHVh
bCBwYXRjaGVzIHRvIGhvcGVmdWxseSBtYWtlIGl0IGVhc2llciB0byB1bmRlcnN0YW5kIHdoYXQg
aXMNCj4gPiBnb2luZyBvbi4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiAgIE1hcnRpbg0KPiA+DQo+
IA0KPiBOaWNlIHdvcmshIEknbSBnbGFkIHRvIHNlZSB0aGlzIGRyaXZlciBnZXQgbW9yZSBmZWF0
dXJlcy4NCg0KQWdyZWUhIEl0IHNlZW1zIHRoaXMgZHJpdmVyIGNhbiBwb3NzaWJsZSB0byBzdXBw
b3J0IFAyUCBhcyB3ZWxsLiANCg0KSSBoYXZlIHJldmlld2VkIHRoaXMgcGF0Y2hzZXQsIGFuZCBw
bGVhc2UgZmVlbCBmcmVlIHRvIGFkZCBteSByZXZpZXdlZC1ieQ0KICAgIFJldmlld2VkLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCmlmIEkgaGF2ZSBubyBjb21tZW50IG9u
IHBhdGNoZXMgYW5kIHlvdSBkb24ndCBjaGFuZ2UgdGhlbSBieSB2Mi4gDQoNClBpbmctS2UNCg0K

