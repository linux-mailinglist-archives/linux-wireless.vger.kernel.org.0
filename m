Return-Path: <linux-wireless+bounces-7417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0D8C1D36
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBFF1C20AA5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595F6149C51;
	Fri, 10 May 2024 03:51:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024B171A7
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313117; cv=none; b=GJiIY2YtMNPoH38lesq8H13gNFA6TzrChvPp8U6nvYvmHN3/vS6Ak+r8lKKurDabb4wdVGAL8NVJaEFmKDorClpJYno/H4ncCltK+e7LN6BLhlH42JCF9zsQxzNqNJmSgsa5lym1b6QTeQ5JRYK9yfE4k1m1nOtyWD7KCni/4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313117; c=relaxed/simple;
	bh=npCrtIaqlLHIgctVLj+CbuZVoe0OuVGemTynDMAujAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZvtM4wOYbYFo8YiIj+IVzqdNllDkmKI4HOv7h53aZnkohpSV1QWSC+elncOEhSjQsR7IIU0N13Q1w3wOZJbCevN6u7XiviZPszJBjlRXojNth1+sMRXUjS8aAn3K64BQoQrZ52BkqfkLMW2aefWR1LXH3f0l6E7dy4C0voutOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44A3pT8m92313294, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44A3pT8m92313294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 11:51:29 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:51:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:51:29 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::c892:ed3a:bac3:bda7]) by
 RTEXDAG02.realtek.com.tw ([fe80::c892:ed3a:bac3:bda7%5]) with mapi id
 15.01.2507.035; Fri, 10 May 2024 11:51:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 08/11] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
Thread-Topic: [PATCH v5 08/11] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
Thread-Index: AQHaoTXwt3HPNnR04UOYN3uQmfiEX7GP19Gw
Date: Fri, 10 May 2024 03:51:29 +0000
Message-ID: <2c2589845b754597ac7f175120678898@realtek.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <efcc510f-b631-4b44-8b2d-42d501d6ba4e@gmail.com>
In-Reply-To: <efcc510f-b631-4b44-8b2d-42d501d6ba4e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIGZ1bmN0aW9ucyByZWxhdGVkIHRvIHRoZSBkeW5hbWljIG1lY2hhbmlzbSwgd2hp
Y2ggcnVucw0KPiBldmVyeSB0d28gc2Vjb25kcyB0byBhZGp1c3QgdG8gY2hhbmdlcyBpbiB0aGUg
ZW52aXJvbm1lbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGx3
aWZpL3J0bDgxOTJkdS9kbS5jICAgfCAxMjMgKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vd2ly
ZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9kbS5oICAgfCAgMTAgKysNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTMzIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L2RtLmMNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5
MmR1L2RtLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bHdpZmkvcnRsODE5MmR1L2RtLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bHdpZmkvcnRsODE5MmR1L2RtLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5hZGQ5MDlmNzcyNmYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L2RtLmMNCg0KWy4uLl0N
Cg0KPiArdm9pZCBydGw5MmR1X2RtX3dhdGNoZG9nKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0K
PiArew0KPiArICAgICAgIHN0cnVjdCBydGxfcHNfY3RsICpwcHNjID0gcnRsX3BzYyhydGxfcHJp
dihodykpOw0KPiArICAgICAgIGJvb2wgZndfY3VycmVudF9pbnBzbW9kZSA9IGZhbHNlOw0KPiAr
ICAgICAgIGJvb2wgZndwc19hd2FrZSA9IHRydWU7DQo+ICsNCj4gKyAgICAgICAvKiAxLiBSRiBp
cyBPRkYuIChObyBuZWVkIHRvIGRvIERNLikNCj4gKyAgICAgICAgKiAyLiBGdyBpcyB1bmRlciBw
b3dlciBzYXZpbmcgbW9kZSBmb3IgRndMUFMuDQo+ICsgICAgICAgICogICAgKFByZXZlbnQgZnJv
bSBTVy9GVyBJL08gcmFjaW5nLikNCj4gKyAgICAgICAgKiAzLiBJUFMgd29ya2l0ZW0gaXMgc2No
ZWR1bGVkLiAoUHJldmVudCBmcm9tIElQUyBzZXF1ZW5jZQ0KPiArICAgICAgICAqICAgIHRvIGJl
IHN3YXBwZWQgd2l0aCBETS4NCj4gKyAgICAgICAgKiA0LiBSRkNoYW5nZUluUHJvZ3Jlc3MgaXMg
VFJVRS4NCj4gKyAgICAgICAgKiAgICAoUHJldmVudCBmcm9tIGJyb2tlbiBieSBJUFMvSFcvU1cg
UmYgb2ZmLikNCj4gKyAgICAgICAgKi8NCj4gKw0KPiArICAgICAgIGlmIChwcHNjLT5yZnB3cl9z
dGF0ZSA9PSBFUkZPTiAmJiAhZndfY3VycmVudF9pbnBzbW9kZSAmJg0KPiArICAgICAgICAgICBm
d3BzX2F3YWtlICYmICFwcHNjLT5yZmNoYW5nZV9pbnByb2dyZXNzKSB7DQoNCm5pdDogdXNlIGVh
cmx5IHJldHVybg0KDQppZiAoUkZfT0ZGIHx8IEZXX0xQUyB8fCBJUFNfU0VDSEVEVUxFRCB8fCBS
Rl9DSEFOR0lORykNCiAgICByZXR1cm47DQoNCj4gKyAgICAgICAgICAgICAgIHJ0bDkyZF9kbV9w
d2RiX21vbml0b3IoaHcpOw0KPiArICAgICAgICAgICAgICAgcnRsOTJkX2RtX2ZhbHNlX2FsYXJt
X2NvdW50ZXJfc3RhdGlzdGljcyhodyk7DQo+ICsgICAgICAgICAgICAgICBydGw5MmRfZG1fZmlu
ZF9taW5pbXVtX3Jzc2koaHcpOw0KPiArICAgICAgICAgICAgICAgcnRsOTJkX2RtX2RpZyhodyk7
DQo+ICsgICAgICAgICAgICAgICBydGw5MmRfZG1fY2hlY2tfdHhwb3dlcl90cmFja2luZ190aGVy
bWFsX21ldGVyKGh3KTsNCj4gKyAgICAgICAgICAgICAgIHJ0bDkyZF9kbV9jaGVja19lZGNhX3R1
cmJvKGh3KTsNCj4gKyAgICAgICAgICAgICAgIHJ0bDkyZF9kbV8xcl9jY2EoaHcpOw0KPiArICAg
ICAgIH0NCj4gK30NCg0K

