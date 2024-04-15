Return-Path: <linux-wireless+bounces-6292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD88A4662
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 02:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F14A2823C5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 00:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95417F8;
	Mon, 15 Apr 2024 00:46:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FE639
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141962; cv=none; b=M2bAB44EKrNq9AMDAQfme8jm/vodZ9HWKkkMvABMB2slQn1O3paQMmLdVuV684Z2WnoVE29Y8bUQFyJQeNQLIOxo/TUkG/mzknLpLKk7hEdIAWgzcjhgr4HKfxA6hd5a5o0hvpw70zsqJIjss9AsM1MkOLusEZlXNciBXu1YTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141962; c=relaxed/simple;
	bh=eW2m4lwHSA+9dx+jBS/L6J88tMJak7mrjsUEGGB8onQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uu6AKUnE4kmgcGSX7QlKIo57NEp7FynuVIIA1O6K38acFv4vFeUgLw0sGBrS9fyizr7Lr2pfmOBREIfdqh2acof6JYyg+O60ZHoOj22ona9B1QmoWnd8VTkf2RP3aWEqE0Dv7wwW2i6ABKMEhes1ig/fhs2cOg8dTrqbCbEA9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43F0jJz95338191, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43F0jJz95338191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 08:45:20 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 08:45:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 08:45:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 15 Apr 2024 08:45:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@lwfinger.net>, Kalle Valo <kvalo@kernel.org>
CC: Larry Finger <Larry.Finger@gmail.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART Bluetooth
Thread-Topic: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART
 Bluetooth
Thread-Index: AQHai6+3Zq0VJBVgFk2i9wweb2CUxrFiTTdQ//+KnwCAAM8JgYAAJv+AgAW1RzA=
Date: Mon, 15 Apr 2024 00:45:20 +0000
Message-ID: <d3141ad7a7a9455f8a6dbcdd3f46eecf@realtek.com>
References: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
 <5af71338f3904aac9d2c237637c851e7@realtek.com>
 <287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net>
 <87o7agjs00.fsf@kernel.org>
 <46745fe7-a43d-4f7c-b247-f0fde01ee63e@lwfinger.net>
In-Reply-To: <46745fe7-a43d-4f7c-b247-f0fde01ee63e@lwfinger.net>
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

TGFycnkgRmluZ2VyIDxsYXJyeS5maW5nZXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEkgb3Jp
Z2luYWxseSB3b25kZXJlZCBpZiB0aGVyZSB3YXMgYSBwb3dlciBwcm9ibGVtIHdoZW4gYm90aCB3
ZXJlIHNpbXVsdGFuZW91c2x5DQo+IHN0YXJ0ZWQsIGJ1dCBJIHNlZSB0aGF0IGlzIG5vdCB0aGUg
Y2FzZS4gVG8gcmVpdGVyYXRlLCB0aGUgQlQgbXVzdCBzdGFydCBmaXJzdA0KPiBhbmQgY29tcGxl
dGUgVUFSVCBpbml0aWFsaXphdGlvbiBiZWZvcmUgdGhlIHdpZmkgc3RhcnRzIGluaXRpYWxpemlu
Zy4gSXQgc2VlbXMNCj4gdG8gbWUgdGhhdCBhIHN1aXRhYmxlIG1zbGVlcCgpIGF0IHRoZSBzdGFy
dCBvZiB0aGUgU0RJTyBwcm9iZSByb3V0aW5lIHNlZW1zIHRvDQo+IGJlIGEgdmlhYmxlIHdvcmth
cm91bmQgZXZlbiB0aG91Z2ggaXQgaXMgbm90IGFlc3RoZXRpY2FsbHkgcGxlYXNpbmcuIEEgc2xl
ZXAgb2YNCj4gMTUwIG1zIGlzIHRvbyBzaG9ydCwgYnV0IDUwMCBzZWVtcyB0byB3b3JrIHJlbGlh
Ymx5Lg0KDQpTdWdnZXN0IHRvIGFwcGx5IHRoaXMgd29ya2Fyb3VuZCBidXQgb25seSBpZiBVQVJU
LUJUICsgU0RJTy1XaUZpLCBiZWNhdXNlIFNESU8NCmV4cGVydHMgZGlkbid0IHJlbWVtYmVyIHRo
ZXkgaGF2ZSBtZXQgdGhpcyBwcm9ibGVtLiBUaGV5IG5lZWQgcmVhbCBoYXJkd2FyZSB0bw0KbWVh
c3VyZSBzaWduYWxzIHRvIGtub3cgd2hhdCBpdCBpcyB3cm9uZywgYnV0IHVuZm9ydHVuYXRlbHkg
dGhleSBkb24ndCBoYXZlDQpiYW5kd2lkdGggdG8gcHJvY2VzcyB0aGlzIGJlY2F1c2Ugb2YgbGlt
aXRhdGlvbiBvZiBodW1hbiByZXNvdXJjZXMuIFNvcnJ5DQpmb3IgdGhhdC4NCg0KUGluZy1LZQ0K
DQo=

