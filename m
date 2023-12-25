Return-Path: <linux-wireless+bounces-1277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720181DE42
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 06:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20072281601
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 05:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3B10F1;
	Mon, 25 Dec 2023 05:32:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C310EE
	for <linux-wireless@vger.kernel.org>; Mon, 25 Dec 2023 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BP5WLOM03735436, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BP5WLOM03735436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Dec 2023 13:32:21 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 25 Dec 2023 13:32:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 25 Dec 2023 13:32:20 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Mon, 25 Dec 2023 13:32:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v3 00/21] wifi: rtl8xxxu: Add concurrent mode for 8188f
Thread-Topic: [PATCH v3 00/21] wifi: rtl8xxxu: Add concurrent mode for 8188f
Thread-Index: AQHaNvKIUge7Bjkmr0eAPKm/bDMQS7C5d3sw
Date: Mon, 25 Dec 2023 05:32:20 +0000
Message-ID: <78b88700354e473b8db5a92e286cb0ea@realtek.com>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
 <CAKFoaw3TVZmp3LEcy4Oo1ZBy_vvOxivuvmdD+TT+Ou4Zy19cJA@mail.gmail.com>
In-Reply-To: <CAKFoaw3TVZmp3LEcy4Oo1ZBy_vvOxivuvmdD+TT+Ou4Zy19cJA@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

DQoNCk9uIEZyaSwgRGVjIDIyLCAyMDIzIGF0IDY6MTXigK9QTSBNYXJ0aW4gS2Fpc3RyYQ0KPG1h
cnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPg0KPiBUaGlzIHNlcmllcyBhZGRz
IHRoZSBwb3NzaWJpbGl0eSB0byB1c2UgdHdvIHZpcnR1YWwgaW50ZXJmYWNlcyBvbiB0aGUNCj4g
c2FtZSBjaGFubmVsLiBTdXBwb3J0ZWQgY29tYmluYXRpb25zIGFyZSBTVEErU1RBIGFuZCBTVEEr
QVAuIFRoZQ0KPiBjb252ZXJzaW9uIG9mIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCBtdWx0aXBsZSBp
bnRlcmZhY2VzIGlzIHNwbGl0IGludG8NCj4gaW5kaXZpZHVhbCBwYXRjaGVzIHRvIGhvcGVmdWxs
eSBtYWtlIGl0IGVhc2llciB0byB1bmRlcnN0YW5kIHdoYXQgaXMNCj4gZ29pbmcgb24uDQo+DQo+
IFRoYW5rcywNCj4gICBNYXJ0aW4NCj4NCj4gY2hhbmdlcyBmcm9tIHYyLT52MzoNCj4gLSBjb2xs
ZWN0IHJldmlld2VkLWJ5IHRhZ3MNCj4gLSBmaXggY2hlY2twYXRjaCB3YXJuaW5nIGZvciBjb21t
ZW50DQoNClRoYW5rcyBmb3IgdGhpcyBncmVhdCB3b3JrISBJIGhhdmUgYWRkZWQgbXkgcmV2aWV3
ZWQtYnkgdG8gYWxsIHBhdGNoZXMuIA0KDQoNCg0K

