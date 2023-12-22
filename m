Return-Path: <linux-wireless+bounces-1192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F182381C2F9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 03:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC5E1C20B45
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B64539A;
	Fri, 22 Dec 2023 02:02:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F285390
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM22HdxC1807408, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM22HdxC1807408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 10:02:17 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 22 Dec 2023 10:02:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 Dec 2023 10:02:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 22 Dec 2023 10:02:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v2 00/21] wifi: rtl8xxxu: Add concurrent mode for 8188f
Thread-Topic: [PATCH v2 00/21] wifi: rtl8xxxu: Add concurrent mode for 8188f
Thread-Index: AQHaNHo7g519qW0C+UWy6hXFww1/hLC0i5jQ
Date: Fri, 22 Dec 2023 02:02:14 +0000
Message-ID: <da461682d3c348dd965a35bb3ceebb2f@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <CAKFoaw2b3ZB9u+jZ0gCCSrxXr1Viq3-3jsvKAgrpwDxvufYydQ@mail.gmail.com>
In-Reply-To: <CAKFoaw2b3ZB9u+jZ0gCCSrxXr1Viq3-3jsvKAgrpwDxvufYydQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQpPbiBGcmksIERlYyAyMiwgMjAyMyBhdCAxMjo0NOKAr0FNIE1hcnRpbiBLYWlzdHJhDQo8bWFy
dGluLmthaXN0cmFAbGludXRyb25peC5kZT4gd3JvdGU6DQo+DQo+IFRoaXMgc2VyaWVzIGFkZHMg
dGhlIHBvc3NpYmlsaXR5IHRvIHVzZSB0d28gdmlydHVhbCBpbnRlcmZhY2VzIG9uIHRoZQ0KPiBz
YW1lIGNoYW5uZWwuIFN1cHBvcnRlZCBjb21iaW5hdGlvbnMgYXJlIFNUQStTVEEgYW5kIFNUQStB
UC4gVGhlDQo+IGNvbnZlcnNpb24gb2YgdGhlIGRyaXZlciB0byBzdXBwb3J0IG11bHRpcGxlIGlu
dGVyZmFjZXMgaXMgc3BsaXQgaW50bw0KPiBpbmRpdmlkdWFsIHBhdGNoZXMgdG8gaG9wZWZ1bGx5
IG1ha2UgaXQgZWFzaWVyIHRvIHVuZGVyc3RhbmQgd2hhdCBpcw0KPiBnb2luZyBvbi4NCj4NCj4g
VGhhbmtzLA0KPiAgIE1hcnRpbg0KPg0KPiBjaGFuZ2VzIGZvciB2MjoNCj4gLSBjb2xsZWN0IHJl
dmlld2VkLWJ5IHRhZ3MNCg0KUGxlYXNlIGNvbGxlY3QgbXkgcmV2aWV3ZWQtYnkgYWdhaW4gYnkg
djMuIFRoYW5rcy4gDQoNCj4gLSBjb2Rpbmcgc3R5bGUgY2hhbmdlc3MNCj4gLSBpZ25vcmUgQ0ZP
IGZvciBTVEErU1RBDQo+IC0gZXh0ZW5kIHdhdGNoZG9nX2NhbGxiYWNrIHRvIGNhbGwgcmVmcmVz
aF9yYXRlX21hc2sgZm9yIGJvdGggaW50ZXJmYWNlcw0KDQpBcyBjb21tZW50cywgeW91IGNhbiBk
ZWNpZGUgaWYgZXh0ZW5kIGl0IHRvIGFsbCBzdGF0aW9ucyBmb3IgQVAgbW9kZS4NCg0KPiAtIHJl
bW92ZSBwb3J0X251bSBjaGVjayBmb3IgQkVBQ09OIGNoYW5nZSBub3RpZmljYXRpb25zDQo+IC0g
YWRkIG1hY2lkcyBmb3IgU1RBIG1vZGUNCj4gLSBhZGQgbnVtYmVyIG9mIHNlYyBjYW0gZW50cmll
cyB0byBydGw4eHh4dV9maWxlb3BzDQo+IC0gYWRkIGNvbW1lbnQgdG8gc3dpdGNoX3BvcnRzIGFi
b3V0IHVzaW5nIHRoZSBmdW5jdGlvbiBpbiB0aGUgZnV0dXJlDQoNCkEgbml0IGNvbW1lbnQgZm9y
IHRoaXMgcGF0Y2guIA0KDQoNCg==

