Return-Path: <linux-wireless+bounces-25985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E975B10510
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E5E1CC04E2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB41A08BC;
	Thu, 24 Jul 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gqkI/szA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25320279DAD
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347120; cv=none; b=tSoWt/zAn99NC0wH907V3CC6hCN91173FHiIxAIW9p9mtwx0OpfDd43Jlas60DBlNSc87rnLyOi58kUG55cwcIq2nC/6Gc0YnD+HPw//llz7GieJcxUmwS7XqU6bZ/9Nb1S5TFBx73WZg1sUdFMhkG53eONm7GNatk/FrjS/iXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347120; c=relaxed/simple;
	bh=M6mgfGP/Hp91PP+lK3l4yT/aNb368yDDGDtzap2iHz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bvxXmlIYkYG0LfFsBFik2EoIBuWRk3PdtaQEeyF1XwzuaHgMDJRz07XWOO9raHLycqrPwE51yL4QMd6uU4UW7I0sgcGro4bUrNdZ0TTqun+wm62IuP0eIUxAApdB6xiVVXnG7fdJubdCgNhpjiNYCAi1XTEXvLXkLLZg5EPfywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gqkI/szA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56O8ml7xB194637, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753346927; bh=M6mgfGP/Hp91PP+lK3l4yT/aNb368yDDGDtzap2iHz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gqkI/szAmW6KLugGe7eXlQinUMWwEm+rZFraziBGaEWe5J5ot6vcM1A4BV2p6EayQ
	 SvN6MhACj1padby3rkfHlSWP/i2E1M/NP8i+6B5pG4v0y+rl1jqDHhbYG3dczM34UM
	 tu10wYwLH+R6HGPRlGR6S9hA19GGFXuHX1RSPKz/mu7rCo926tQ9bPykEUHJQkXa+i
	 9eAOsnaV1RDvJsfLswetK3aVvIn3W5f1BM2u1D8w3VrI4DLjM0xOSUO0PO98lZzOZK
	 Hi7sczFO+pnIeo67FMKDevd2f3hS4y6DAunB18hb5qXiEZRNEJ2GNpv2GLbpwqACj3
	 4gk+SqUMslROw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56O8ml7xB194637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:48:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 16:48:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Jul 2025 16:48:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 24 Jul 2025 16:48:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: RE: [DESIGN RFC] Critical Update handling in the kernel
Thread-Topic: [DESIGN RFC] Critical Update handling in the kernel
Thread-Index: AQHb9tctaakFDhkEZkqxOSgZJa1WNbQ9uciAgANE8KA=
Date: Thu, 24 Jul 2025 08:48:46 +0000
Message-ID: <fce447412112421887a1a81f5ada850e@realtek.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
In-Reply-To: <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IA0KPiA+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPUEVO
IFFVRVNUSU9OUw0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IEJlZm9yZSB3ZSBtb3ZlIGZv
cndhcmQgd2l0aCBpbXBsZW1lbnRhdGlvbiwgd2UnZCBsaWtlIHRvIGNvbmZpcm0gd2hldGhlcg0K
PiA+IHRoZSBwcm9wb3NlZCBkZXNpZ24gbG9va3Mgc291bmQuIEFyZSB0aGVyZSBhbnkgY29uY2Vy
bnMgb3IgcG90ZW50aWFsIGlzc3Vlcw0KPiA+IHdlIHNob3VsZCBiZSBhd2FyZSBvZj8NCj4gPg0K
PiA+IE91dCBvZiBjdXJpb3NpdHksIHdlJ3JlIGFsc28gaW50ZXJlc3RlZCBpbiB1bmRlcnN0YW5k
aW5nIGhvdyBvdGhlciB2ZW5kb3JzDQo+ID4gYXJlIGN1cnJlbnRseSBoYW5kbGluZyB0aGlzIGZl
YXR1cmUgaW4gdGhlaXIgZG93bnN0cmVhbSBkcml2ZXJzLiBJcyBpdA0KPiA+IHR5cGljYWxseSBv
ZmZsb2FkZWQgdG8gZmlybXdhcmUsIG9yIGlzIHRoZSBsb2dpYyBpbXBsZW1lbnRlZCBpbiB0aGUg
a2VybmVsPw0KPiA+IEp1c3Qgd2FudCB0byBjb25maXJtIHdoZXRoZXIgYWxsIHRoaXMgd2lsbCBi
ZSB1c2VkIG9ubHkgYnkgbWFjODAyMTFfaHdzaW0NCj4gPiBvciB3aWxsIHRoZXJlIGJlIGFueSBh
Y3R1YWwgdXNlcnM/DQo+IA0KPiBJIHRoaW5rIFBpbmctS2UgcHJldmlvdXNseSBpbmRpY2F0ZWQg
dGhhdCB0aGV5IHdlcmUgcGxhbm5pbmcgdG8gZG8NCj4gdGhpbmdzIGhvc3Qgc2lkZT8gSSdtIG5v
dCBzdXBlciBmYW1pbGlhciB3aXRoIHRoZSB0aW1pbmcgY29uc3RyYWludHMNCj4gdGhvdWdoLCBz
byBJJ20gbm90IHN1cmUgd2hhdCB0aGF0IG1pZ2h0IGltcGx5Lg0KDQpZZXMsIFJlYWx0ZWsgdmVu
ZG9yIGRyaXZlciBoYW5kbGVzIHRoZSBmZWF0dXJlIGluIGhvc3QgZHJpdmVyLiBIYXZpbmcgbm90
DQp0ZXN0ZWQgQ1NBIGFuZCBNTCBwcm9jZWR1cmUgbWVudGlvbmVkIGluIHRoaXMgZGlzY3Vzc2lv
biB0aHJlYWQsIHdlDQphcmUgYWxzbyBub3Qgc3VyZSBob3cgdGltaW5nIGNvbnN0cmFpbnQgdG8g
ZXZhbHVhdGUgaWYgd2UgaGF2ZSB0byBpbXBsZW1lbnQNCnRoZSBmZWF0dXJlIGluIGZpcm13YXJl
LiAgDQoNClBpbmctS2UNCg0K

