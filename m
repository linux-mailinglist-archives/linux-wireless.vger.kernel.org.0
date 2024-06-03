Return-Path: <linux-wireless+bounces-8385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4238D796D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 02:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CD91C20897
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCAC1366;
	Mon,  3 Jun 2024 00:51:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA11362
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717375874; cv=none; b=PgM63L/Dtdt9pzXbBX/PA13VC8sT41/lJBDgVKT291X9MjzB8zP4T8gGm+AKRnQ08dua0fxeCkmi4UP7nIzRw+PfnFR75veY/wkWYrHKAqgmKzEcTHH5NfWylfv++Y06NLhllx7Hw8hJTLc5jd9I4IsqhuqvlpBsZWvnv7EKnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717375874; c=relaxed/simple;
	bh=IACVd8nrf6cR+d1OJVU3bMtY9XCUK4c2d57QJn+YO7g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mn8bTOwKwuCicX/Pw7k2MmEWu/Z7zYZCHLZQAS0J+brhq89Oz7xJmy9jpNJi2WUP3G4MgZCY5JQbdJ2eJfDpGr9mOTe2uauWvxDAeUBB0Ubf0SwuYvN8dNU2CmKEApBucf0FT5rdE49f/3fLLqpm4aszdmnW76Rbz7Pwfxv/rds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4530oqtH72060388, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4530oqtH72060388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 08:50:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 08:50:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Jun 2024 08:50:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 3 Jun 2024 08:50:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liam <mothsarecool524@proton.me>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Add Realtek RTL8812AU chipset to project rtw88
Thread-Topic: Add Realtek RTL8812AU chipset to project rtw88
Thread-Index: AQHatGeShDhp7EE6AkK5W6lzpBddprG1Nojw
Date: Mon, 3 Jun 2024 00:50:51 +0000
Message-ID: <e8b0d83bc11442ccb8621ea465c31938@realtek.com>
References: <j4XA74KT9pFZBalRpR2dCG07ohOgN6kwhU-Y8LPDUU53D7Kuk6vWQKbu635doolHWOQ96fL4fs7mNWP_zThhLfNvfpeGxQYATdPwfhSuWbc=@proton.me>
In-Reply-To: <j4XA74KT9pFZBalRpR2dCG07ohOgN6kwhU-Y8LPDUU53D7Kuk6vWQKbu635doolHWOQ96fL4fs7mNWP_zThhLfNvfpeGxQYATdPwfhSuWbc=@proton.me>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

TGlhbSA8bW90aHNhcmVjb29sNTI0QHByb3Rvbi5tZT4gd3JvdGU6DQo+IFRoaXMgZW1haWwgaXMg
ZGlyZWN0ZWQgdG8gdGhlIFJlYWx0ZWsgZW5naW5lZXJzIHdvcmtpbmcgb24gdGhlIHByb2plY3Qg
cnR3ODguDQo+IA0KPiBHb29kIGFmdGVybm9vbiBSZWFsdGVrIGVuZ2luZWVycywNCj4gDQo+IElu
IHRoZSBsaXN0IG9mIHN1cHBvcnRlZCBjaGlwc2V0cywgdGhlcmUgc2VlbXMgdG8gYmUgb25lIG1p
c3Npbmc6DQo+IA0KPiBSVEw4ODEyQVUNCj4gDQo+IFRoaXMgY2hpcHNldCBpcyB1c2VkIGluIHF1
aXRlIGEgbnVtYmVyIG9mIHNtYWxsZXIgVVNCIFdpLUZpIGFkYXB0ZXJzLCBzdWNoIGFzIHRoZSBO
RVRHRUFSIEE2MTAwLCBVR1JFRU4NCj4gQTEzMDAsIHNvIG9uIGFuZCBzbyBmb3J0aC4gSXQgbWF5
IGFsc28gYmUgdXNlZCBpbiBQQ0llIGNhcmRzIGFzIHdlbGwsIGJ1dCBJJ20gbm90IHF1aXRlIHN1
cmUgb24gdGhhdCBmcm9udC4NCj4gDQo+IEhlcmUncyBob3BpbmcgdGhlIGVmZm9ydHMgb2YgdGhl
IHByb2plY3QgZ28gc21vb3RobHkgYW5kIHBheSBvZmYsIHNvIHRoYXQgbW9yZSBvZiB1cyBjYW4g
ZW5qb3kgbm90IGhhdmluZw0KPiB0byBiZSB0ZXRoZXJlZCB2aWEgYW4gRXRoZXJuZXQgY2FibGUu
DQo+IA0KDQpSVEw4ODEyQUUgKFBDSUUgaW50ZXJmYWNlIG9mIFJUTDg4MTJBKSBpcyBzdXBwb3J0
ZWQgYnkgcnRsd2lmaSwgd2hpY2ggVVNCDQppbmZyYXN0cnVjdHVyZSBpcyBhbHNvIGJ1aWx0LCBz
byB0aGF0IGlzIGEgY2hvaWNlIHRvIHN1cHBvcnQgUlRMODgxMkFVLg0KUGF0Y2hlcyBhcmUgd2Vs
Y29tZS4gDQoNClBpbmctS2UgDQoNCg==

