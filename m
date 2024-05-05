Return-Path: <linux-wireless+bounces-7176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2498BBF14
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 04:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD0EB21036
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E72EDC;
	Sun,  5 May 2024 02:22:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00394ED8
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714875771; cv=none; b=U9gKoOz/i0lD9LAI2H6Gl1zt8uyVADuu3gEgk/zZbpoTgSZp1vE3085hcFwpi2gtAm6pbgH4nDLN79802gQ41JR0w35yez+33jzx13Z0+7+BjlHKai82PcHg1I8C+kot7ndvKN573/pSgyOuVc3PaRBCuNmYvwh0WHig2rX6sTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714875771; c=relaxed/simple;
	bh=5G3oAMFA7Q/zAKMpufq1pbdLnDt+189XrsbqnYQLhX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAo9zOb5/LeipypYIFStheArEsndEdsvQuKIHyrZzhFIs0fRDzPFPX8RCHoypXP/dYaPPiV5UHfEYRE9Lc88PswrzjRm2HTq6MXG2dnN3BNRie0zWAmf7CUmVJti1C+QTPnRNYCdPgVqGPlGItqWGBkggqJNUSVijBcGwZGxz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4452Mb4D2790203, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4452Mb4D2790203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 May 2024 10:22:37 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 10:22:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 10:22:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Sun, 5 May 2024 10:22:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: rtw-next-2024-05-04
Thread-Topic: pull-request: rtw-next-2024-05-04
Thread-Index: AQHanbtZT6OtPHricEuEHKld+5GqvLGGIpqAgABE2wCAAK2+C4AAT2OA
Date: Sun, 5 May 2024 02:22:36 +0000
Message-ID: <6df3012b6edb9aa8bffa170c1d9144750494bee8.camel@realtek.com>
References: <333d56f0-ef24-4946-958d-e804cf9c733b@RTEXMBS04.realtek.com.tw>
	 <171480660387.2072516.10612946227059882367.kvalo@kernel.org>
	 <03e00a7f47c86323f34748853ba38859b4d52695.camel@realtek.com>
	 <87seyxn1dw.fsf@kernel.org>
In-Reply-To: <87seyxn1dw.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ED8EE0617311E47B3561F6D191102EE@realtek.com>
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

T24gU2F0LCAyMDI0LTA1LTA0IGF0IDE2OjM4ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gT24g
U2F0LCAyMDI0LTA1LTA0IGF0IDA3OjEwICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiA+ID4g
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkL2h3X2NvbW1vbi5j
Ojk4NjoyOg0KPiA+ID4gLi9pbmNsdWRlL2xpbnV4L2JpdGZpZWxkLmg6MTg5OjE1OiB3YXJuaW5n
OiAncmF0ZV9tYXNrJyBpcyB1c2VkDQo+ID4gPiB1bmluaXRpYWxpemVkIFstV3VuaW5pdGlhbGl6
ZWRdDQo+ID4gPiANCj4gPiANCj4gPiBJIGhhdmUgdXBkYXRlZCBnY2MgdG8gMTMuMi4xIChsb2Nh
bCBidWlsZCksIGJ1dCBzdGlsbCBjYW4ndCBzZWUgdGhpcyB3YXJuaW5nLg0KPiANCj4gSSdtIG5v
dCBzdXJlIGlmIHlvdSBhd2FyZSB0aGF0IGNyb3NzdG9vbCBwcm92aWRlcyBhbiBlYXN5IHdheSB0
byB0ZXN0DQo+IGRpZmZlcmVudCBjb21waWxlcnMuIE1vcmUgaW5mbyBoZXJlOg0KPiANCj4gaHR0
cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vdXNlcnMvZHJpdmVycy9hdGgxMGsvY29k
aW5nc3R5bGUjdG9vbHMNCg0KDQpJIGRpZG4ndCBrbm93IHRoYXQgYmVmb3JlLCBhbmQgSSB1c2Ug
dGhhdCBjb252ZW5pZW50IGNyb3NzIGJ1aWxkIG5vdy4gOi0pDQoNCkEgcXVlc3Rpb24gYWJvdXQg
R05VbWFrZWZpbGUsIGl0IHNlZW1zIG1pc3MNCg0KICBpbmNsdWRlIE1ha2VmaWxlDQoNCk90aGVy
d2lzZSwgJ21ha2UnIHRvbGQgbWUgbm8gcnVsZXMgdG8gbWFrZS4gDQoNCj4gDQo+ID4gVGhlbiwg
SSBmb3JjZSB0byBhZGQgLVd1bmluaXRpYWxpemVkIGFuZCBkZWxldGUgLVduby1tYXliZS11bmlu
aXRpYWxpemVkDQo+ID4gbG9jYWxseSwgYW5kIEkgY2FuIHNlZSB0aGlzIHdhcm5pbmcgKGJ1dCAt
V21heWJlLXVuaW5pdGlhbGl6ZWQgaW5zdGVhZCkuDQo+ID4gDQo+ID4gSSBkaWQgc3VzcGVjdCB3
aXJlbGVzcy1uZXh0IHRyZWUgZG9lcyBtb3JlIGNvbXBpbGVyIG9wdGlvbnMsIHNvIEkgYWxzbw0K
PiA+IHRyaWVkIHRvIG1lcmdlIHRoZSB0cmVlLCBidXQgc3RpbGwgdGhlIHNhbWUuDQo+IA0KPiBX
ZWlyZCwgbWF5YmUgaXQncyBkdWUgdG8gZGlmZmVyZW50IGtjb25maWcgb3B0aW9ucz8gSSBoYXZl
IGF0dGFjaGVkIG15DQo+IC5jb25maWcgd2hpY2ggSSB1c2UgdG8gY29tcGlsZSB0ZXN0IHdpcmVs
ZXNzIHRyZWVzLg0KDQpVc2luZyB5b3VyIC5jb25maWcgY2FuIHJlcHJvZHVjZSB0aGUgc3ltcHRv
bSwgYW5kIHRoZW4gSSB0cnkgdG8gYmlzZWN0IENPTkZJR194eHguDQpUaGUgY2F1c2UgaXMgIkNP
TkZJR19ERUJVR19TRUNUSU9OX01JU01BVENIPXkiLiBNeSAuY29uZmlnIGRpZG4ndCBoYXZlIHRo
YXQuDQoNCkkgYWxzbyB0cmllZCBteSBvcmlnaW5hbCBjb21waWxlciB0aGF0IGNhbiBhbHNvIHNl
ZSB0aGUgd2FybmluZyB3aXRoIG5ldyAuY29uZmlnLg0KDQo+IA0KPiA+IFRvIHByZXZlbnQgYmxv
Y2tpbmcgcHVsbC1yZXF1ZXN0LCBJIHdvdWxkIG1ha2UgcGF0Y2ggYW5kIHNlbmQgcHVsbC1yZXF1
ZXN0DQo+ID4gYnkgeW91ciBmaW5kaW5nLiBJIHdpbGwgY29udGludWUgdG8gZGlnIHRoZSBjYXVz
ZSBhZnRlcndhcmQuDQo+IA0KPiBJIGRvbid0IHNlZSBhbnkgd2FybmluZ3Mgd2l0aCB2MiBhbnlt
b3JlLiBUaGFua3MgZm9yIHRoZSBxdWljayBmaXghDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgdGlt
ZSBvbiB3ZWVrZW5kLiA6LSkNCg0KDQo=

