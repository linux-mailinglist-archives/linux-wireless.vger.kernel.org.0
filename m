Return-Path: <linux-wireless+bounces-11772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EBA95AAA4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 03:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0762815FF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143ED299;
	Thu, 22 Aug 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bs3GfkLj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549828EF
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291215; cv=none; b=UgNwMiiu0vOQquWjHBYPjJAAw42s4w8ByD79mvb1uh+XL+RzQ00L9lv4PyjIB6TWqHLTZJ1Y/lfPsr6il37/UZal7gan4x+5fgJ+FPBMCN259FPZPVselwEdJFHODA3LWSsXjLsHVMdDq99mxJBpBwFJdek68TO7FJ8r+Cfuu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291215; c=relaxed/simple;
	bh=uO3k6B1BxmEX4VQIFnz6xRDWeq7N1fZCnuRpxp9cdGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ETWsf+VxQkDsJ1cjK1sJhrdmBRj7EHVMSr54nQLV0gN2TqUhqs38g76X5/14UXNwzN79EfIfCZd6UOntDmPh+NnnCKGh6Bq8zQCf2UzK3T1gPnMmyAx8vX7juA49VqRHQ+mGxkDjNJWXLYWBQVU46uRJ8wXkpqX3D2sDCbOLvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bs3GfkLj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M1khFtB3393437, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724291203; bh=uO3k6B1BxmEX4VQIFnz6xRDWeq7N1fZCnuRpxp9cdGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bs3GfkLjCwYH7dYIHrLzblphuB4ODSUtnK7VYY8z0ulDbTDWgUmk6wbEsHWiplv8Q
	 h9E/r+LJHsZfAaJiupKx9VbLxwJQ/vpnbIYk9lUgr8Dr8GZUXzwJJO4fp3RIEGRM9P
	 ACpl5Jb+aKlfGdUAzOdoMG7VecGFSbFzCD6RH34DyZ/ckLRqDVC5YysGzOyfyccXOK
	 EZI5pNz1W96HNNsYcb8MwC1bqPIN1wL3DlNETgxpeonvuS7fkOZsr5OW59WeHD2cpC
	 miyRImmV9p1CcA8JwAFNDt1vf4rodnShCRWx2lKTYvyqKtmlzNDqSBrYKk5DkJPt1c
	 nth7O3+VJFJfg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M1khFtB3393437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 09:46:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:46:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Aug 2024 09:46:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 22 Aug 2024 09:46:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "pbrobinson@gmail.com" <pbrobinson@gmail.com>
Subject: RE: [PATCH 1/2] wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
Thread-Topic: [PATCH 1/2] wifi: mac80211: export ieee80211_purge_tx_queue()
 for drivers
Thread-Index: AQHa8gVfni8UYhlrUEejFq+acMri8rItqPMAgACnBiCABDWg8A==
Date: Thu, 22 Aug 2024 01:46:43 +0000
Message-ID: <e5b68e528f1d46b4932931a8e001bec7@realtek.com>
References: <20240819065855.25678-1-pkshih@realtek.com>
 <554fce82a0c10e0718b9066cbc1e37c67395741b.camel@sipsolutions.net>
 <5c03af1717a54f0a9f76dbac45d8066a@realtek.com>
In-Reply-To: <5c03af1717a54f0a9f76dbac45d8066a@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBKb2hhbm5lcyBCZXJn
IDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiB3cm90ZToNCj4gPiA+ICsvKioNCj4gPiA+ICsg
KiBpZWVlODAyMTFfcHVyZ2VfdHhfcXVldWUgLSBwdXJnZSBUWCBza2IgcXVldWUNCj4gPiA+ICsg
KiBAaHc6IHRoZSBoYXJkd2FyZQ0KPiA+ID4gKyAqIEBza2JzOiB0aGUgc2ticw0KPiA+ID4gKyAq
DQo+ID4gPiArICogRnJlZSBhIHNldCBvZiB0cmFuc21pdCBza2JzLiBVc2UgdGhpcyBmdW5jdGlv
biB3aGVuIGRldmljZSBpcyBnb2luZyB0byBzdG9wDQo+ID4gPiArICogYnV0IHNvbWUgdHJhbnNt
aXQgc2ticyB3aXRob3V0IFRYIHN0YXR1cyBhcmUgc3RpbGwgcXVldWVkLg0KPiA+ID4gKyAqLw0K
PiA+ID4gK3ZvaWQgaWVlZTgwMjExX3B1cmdlX3R4X3F1ZXVlKHN0cnVjdCBpZWVlODAyMTFfaHcg
Kmh3LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBza19idWZmX2hl
YWQgKnNrYnMpOw0KPiA+DQo+ID4gVW5saWtlIHNrYl9xdWV1ZV9wdXJnZSgpL3NrYl9xdWV1ZV9w
dXJnZV9yZWFzb24oKSwgdGhpcyBkb2Vzbid0IHRha2UgdGhlDQo+ID4gbG9jaywgdGhhdCBzZWVt
cyBpbXBvcnRhbnQgdG8gbm90ZSBoZXJlPw0KPiANCj4gVGhhbmtzLiBJIHdhc24ndCBhd2FyZSBv
ZiBsb2NrLCBhbmQgcnR3ODggbmVlZHMgYSBsb2NrIHZlcnNpb24gYmVjYXVzZQ0KPiBpdHMgVFgg
d29yayBpc24ndCBzdG9wcGVkIHlldCB3aGlsZSBjYWxsaW5nIGllZWU4MDIxMV9wdXJnZV90eF9x
dWV1ZSgpLg0KPiANCj4gSSBoYXZlIHRocmVlIGNhbmRpZGF0ZSBvcHRpb25zOg0KPiANCj4gMS4g
YWRkIHNwaW5fbG9jayBieSBkcml2ZXIgYmVmb3JlIGNhbGxpbmcgaWVlZTgwMjExX3B1cmdlX3R4
X3F1ZXVlKCkuDQo+IA0KPiAyLiBtb3ZlIG9yaWdpbmFsIGllZWU4MDIxMV9wdXJnZV90eF9xdWV1
ZSgpIHRvIF9faWVlZTgwMjExX3B1cmdlX3R4X3F1ZXVlKCksDQo+ICAgIGFuZCBhZGQgYW4gbmV3
IGxvY2sgdmVyc2lvbiBvZiBpZWVlODAyMTFfcHVyZ2VfdHhfcXVldWUoKS4NCj4gDQo+IDMuIGNo
YW5nZSBydHc4OCBkZWluaXQgZmxvdyB0byBlbnN1cmUgc3RvcHBpbmcgVFggd29yayBiZWZvcmUg
Y2FsbGluZw0KPiAgICBpZWVlODAyMTFfcHVyZ2VfdHhfcXVldWUoKQ0KPiANCj4gSSBwcmVmZXIg
b3B0aW9uIDMuIEJ1dCB3YW50IHlvdXIgb3BpbmlvbiBpZiBvcHRpb24gMiBpcyB3b3J0aCB0byBk
bz8NCj4gDQoNCkkgaGF2ZSBjaG9zZW4gb3B0aW9uIDMsIHNvIGp1c3QgZXhwb3J0IGllZWU4MDIx
MV9wdXJnZV90eF9xdWV1ZSgpIGFuZCBubw0KbmVlZCB0byB0b3VjaCBpZWVlODAyMTFfcHVyZ2Vf
dHhfcXVldWUoKSBmdXJ0aGVyLiBTZW50IHYyIGFsb25nIHdpdGgNCnN1Z2dlc3RlZCBjb21tZW50
cy4gDQoNCg0K

