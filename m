Return-Path: <linux-wireless+bounces-1914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC0382D3E9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 06:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19591F21487
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6923BE;
	Mon, 15 Jan 2024 05:42:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28D23B7
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F5gFOM13586925, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F5gFOM13586925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 13:42:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 15 Jan 2024 13:42:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 13:42:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Mon, 15 Jan 2024 13:42:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Index: AQHaRam9Hy6mYhlr3USS49QlLcoixLDaXnbA
Date: Mon, 15 Jan 2024 05:42:15 +0000
Message-ID: <c369eeb8b3014f068d1c60b42b44e206@realtek.com>
References: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
In-Reply-To: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDEz
LCAyMDI0IDY6NTAgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBMYXJyeSBGaW5nZXIgPExhcnJ5
LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+IFN1YmplY3Q6IFtQQVRDSF0gd2lmaTogcnRsd2lmaTog
cnRsODE5MmRlOiBGaXggYnl0ZSBvcmRlciBvZiBjaGlwIHZlcnNpb24NCj4gDQo+IFRoZSBjaGlw
IHZlcnNpb24gc3RvcmVkIGluIHRoZSBlZnVzZSBpcyBjdXJyZW50bHkgYXNzdW1lZCB0byBiZSBp
bg0KPiBiaWcgZW5kaWFuIG9yZGVyOg0KPiANCj4gI2RlZmluZSBFRVBST01FX0NISVBfVkVSU0lP
Tl9MICAgICAgICAgICAgICAgICAgMHgzRkYNCj4gI2RlZmluZSBFRVBST01FX0NISVBfVkVSU0lP
Tl9IICAgICAgICAgICAgICAgICAgMHgzRkUNCj4gDQo+IEJ1dCBvdGhlciAyLWJ5dGUgdGhpbmdz
IGluIHRoZSBlZnVzZSBhcmUgc3RvcmVkIGluIGxpdHRsZSBlbmRpYW4gb3JkZXIuDQo+IEZvciBl
eGFtcGxlLCB0aGUgRUVQUk9NIElELCB0aGUgdmVuZG9yIElELCB0aGUgcHJvZHVjdCBJRC4NCj4g
DQo+IFRoZSBvdXQtb2Yta2VybmVsIGRyaXZlciBmb3IgdGhlIFVTQiB2ZXJzaW9uIG9mIHRoZSBj
aGlwIHVzZXMgdGhlIHNhbWUNCj4gbWFjcm9zIGFuZCB2ZXJzaW9uIGRldGVjdGlvbiBjb2RlIGFz
IHRoaXMgZHJpdmVyLg0KDQpJIHJ1biB2ZW5kb3IgZHJpdmVyIHdpdGggODE5MkRVLCBhbmQgZ290
IGNvcnJlY3QgMHhjYzMzLiANCg0KZWZ1c2VbRUVQUk9NRV9DSElQX1ZFUlNJT05fSF0gPSBlZnVz
ZVsweDNmZV0gPSBjdXR2YWx1ZVsxXSA9IDB4Y2MNCmVmdXNlW0VFUFJPTUVfQ0hJUF9WRVJTSU9O
X0xdID0gZWZ1c2VbMHgzZmZdID0gY3V0dmFsdWVbMF0gPSAweDMzDQoNClNvLCANCg0KY2hoaXB2
YWx1ZSA9IChjdXR2YWx1ZVsxXSA8PCA4KSB8IGN1dHZhbHVlWzBdID0gKDB4Y2MgPDwgOCkgfCAw
eDMzID0gMHhjYzMzOw0KDQo+IFRoZXkgcmVjb2duaXNlDQo+IDB4YWE1NSwgMHg5OTY2LCBhbmQg
MHhjYzMzIGFzIGNvcnJlY3QgdmVyc2lvbnMuIFdpdGggdGhlIG9yaWdpbmFsDQo+IG1hY3Jvcywg
bXkgZGV2aWNlJ3MgdmVyc2lvbiBpcyB0aGUgdW5yZWNvZ25pc2VkIHZhbHVlIG9mIDB4MzNjYy4g
VGhpcw0KPiBzZWVtcyBsaWtlIGEgbWlzdGFrZS4NCg0KQ2FuIHlvdSBjaGVjayB0aGUgZWZ1c2Ug
dmFsdWUgeW91IHJlYWQgb3V0Pw0KDQoNCg==

