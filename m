Return-Path: <linux-wireless+bounces-8825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF390486C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 03:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC161F25C64
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 01:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905EA15C9;
	Wed, 12 Jun 2024 01:31:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FB10F2
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155861; cv=none; b=J7fogprm8wlli6QL64I4i6PdiTj5jDZ58RaBlclbW9QTeX86sC+LLMemK7/WlvZzDs0SwlVKZ8hRti4npG5oCX78meKo/d7t/sqylEwAYk49Rl1ClAQQX4Fx0ejFSaxf9ClIeBq0Vk0d3l480crSxNyt4Gi9t0o6QHBbRetvBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155861; c=relaxed/simple;
	bh=Sr3QXcx767H1ipXCsb8zQJNbxcWvLj1D0zYoNefZebY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEN13yOn6As6BwhvZ47H63r+fVSHBiD1tPXqDjAA6e7IRg8MN6ukmba0Tb7pGRkPyxxJo8wAQrgM/TjZimFiWAYPnjbOqywluL1bnQwm88uflnKMZcNA1L8aKpBBTC79cet9hj83iqXhjEmpMHf0ALf45RAK7Z9CPa7DjWjD8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C1UhDT2694345, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C1UhDT2694345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 09:30:43 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 09:30:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 09:30:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 09:30:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle
 Valo" <kvalo@kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?=
	<mslusarz@renau.com>
Subject: RE: rtw88 multicast failure in AP mode
Thread-Topic: rtw88 multicast failure in AP mode
Thread-Index: AQHauOwsgeUJhnLB0Eaji1GrCgk797HB3EwggAALqwCAAXTlIA==
Date: Wed, 12 Jun 2024 01:30:40 +0000
Message-ID: <c5b42d8b818b4bd5ac8a6921a29f9f18@realtek.com>
References: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
 <868343c920c24204972ddaa108e5d00e@realtek.com>
 <CA+GA0_vA1KRRyvnURfdjwVv5JBkRhkjdQnwrRWWKmZs9_z-X1w@mail.gmail.com>
In-Reply-To: <CA+GA0_vA1KRRyvnURfdjwVv5JBkRhkjdQnwrRWWKmZs9_z-X1w@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiB3dC4s
IDExIGN6ZSAyMDI0IG8gMDQ6MzIgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IG5h
cGlzYcWCKGEpOg0KPiA+DQo+ID4gTWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFp
bC5jb20+IHdyb3RlOg0KPiA+ID4gTGV0J3MgYXNzdW1lIHdlIGhhdmUgMyBzeXN0ZW1zOiBBIGFu
ZCBCIHVzZSA4ODIxQ1UgY2hpcCwgYW5kIEMgdXNlcw0KPiA+ID4gYW5vdGhlciBjaGlwIGZyb20g
YSBkaWZmZXJlbnQgdmVuZG9yLg0KPiA+ID4NCj4gPiA+IElmIEEgaXMgaW4gQVAgbW9kZSBhbmQg
QSBhbmQgQiB1c2UgdGhlIHJ0dzg4IGRyaXZlciwgcGluZ2luZyBBIGZyb20gQg0KPiA+ID4gYW5k
IEMgYnkgbG9jYWwgbmFtZSBkb2Vzbid0IHdvcmsgYmVjYXVzZSBuYW1lIHJlc29sdXRpb24gZmFp
bHM6IGF2YWhpDQo+ID4gPiBvbiBCIGFuZCBDIHNlbmRzIGEgbXVsdGljYXN0IHJlcXVlc3QgdG8g
cmVzb2x2ZSBBLmxvY2FsLCBBIHNlZXMgaXQgYW5kDQo+ID4gPiByZXNwb25kcywgYnV0IG5laXRo
ZXIgQiBub3IgQyBzZWVzIHRoZSByZXNwb25zZS4NCj4gPiA+DQo+ID4gPiBJbiB0aGUgc2FtZSBz
aXR1YXRpb24sIGJ1dCB3aXRoIEEgYW5kIEIgdXNpbmcgdGhlIHJ0bDg4MjFjdSBkcml2ZXINCj4g
PiA+IChmcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9tb3Jyb3duci84ODIxY3UtMjAyMTA5MTYuZ2l0
KSwgZXZlcnl0aGluZw0KPiA+ID4gd29ya3MgLSBCIGFuZCBDIHNlZSBBJ3MgcmVzcG9uc2UgYW5k
IGNhbiByZXNvbHZlIEEubG9jYWwuDQo+ID4gPg0KPiA+ID4gSWYgQyBpcyBpbiBBUCBtb2RlLCBy
ZXNvbHZpbmcgQyBmcm9tIEEgYW5kIEIgYWxzbyB3b3Jrcy4NCj4gPiA+DQo+ID4gPiBUaGlzIGxl
YWRzIG1lIHRvIGJlbGlldmUgdGhlcmUncyBzb21ldGhpbmcgd3Jvbmcgd2l0aCBydHc4OCB3aGVu
DQo+ID4gPiBzZW5kaW5nIG11bHRpY2FzdCBwYWNrZXRzIGluIEFQIG1vZGUuDQo+ID4NCj4gPiBI
YXZlIHlvdSBjYXB0dXJlZCBhaXIgcGFja2V0cyBzZW50IGJ5IEMgKEFQIG1vZGUpPyAoVG8gY2hl
Y2sgaWYgVFggcHJvcGVybHkuKQ0KPiANCj4gWWVzLCBJIHNlZSBwYWNrZXRzIGluIGJvdGggZGly
ZWN0aW9ucyBvbiBib3RoIEMgYW5kIEEgaWYgQyBpcyBpbiBBUCBtb2RlLg0KPiANCj4gPiBIYXZl
IHlvdSB0cmllZCBub24tc2VjdXJlIGNvbm5lY3Rpb24/IChUbyBjaGVjayBpZiBlbmNyeXB0aW9u
IHByb3Blcmx5LikNCj4gDQo+IE5vdGhpbmcgY2hhbmdlcyAtIHJ0dzg4IGluIEFQIG1vZGUgc2Vu
ZHMgbXVsdGljYXN0IHBhY2tldHMsIGJ1dCBvdGhlcg0KPiBkZXZpY2VzIGRvbid0IHNlZSB0aGVt
Lg0KDQpIb3cgY2FuIHlvdSBhc3NlcnQgb3RoZXIgZGV2aWNlcyBkb24ndCBzZWUgdGhlbT8gUmVj
ZWl2ZXJzIGRvbid0IEFDSyANCm11bHRpY2FzdC9icm9hZGNhc3QgcGFja2V0cywgc28gaGF2ZSB5
b3UgYWRkZWQgZGVidWcgbG9nIGluIEEgb3IgQj8NCg0KQ29tcGFyZSBhaXIgcGFja2V0cyBpbiBu
b24tc2VjdXJlIGNvbm5lY3Rpb24gYmV0d2VlbiB3aGF0IEEgYW5kIEMgcGxheXMgQVAgbW9kZS4N
CkZpbmRpbmcgdGhlaXIgZGlmZmVyZW5jZSBtaWdodCBoZWxwIHRvIGFkZHJlc3MgcHJvYmxlbS4N
Cg0KDQo=

