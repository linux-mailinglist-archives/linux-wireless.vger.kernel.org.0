Return-Path: <linux-wireless+bounces-26074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B96DAB17AA3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 02:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071651AA4700
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 00:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55E182D3;
	Fri,  1 Aug 2025 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jkO5HSky"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69FB8C11;
	Fri,  1 Aug 2025 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008582; cv=none; b=qtL8mTuZaMjFzjueJIvdXf2436TlL/3S9paRn7w1tfN1oc2ZxbVT4MCV3baLPqV8wnuhUSuXKnp32ENUWoIMzNqHij6iU/kvSkR4OLtrEAC/SWUeigdRc7MCFeo1oT3+IDH/UdebfTa30A/odeh3dOWAkKfjrDFbMFo2SJAWKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008582; c=relaxed/simple;
	bh=NTl19locgjkpOHb1sevFzTM/gmsxCTxvN7Z+nyrlYbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UEeWXEbTdYi/B7V06rsm4t/OTR1osvovF7335wlU3XnojfalfTj576gmwJMIBFk0gU9NtgNQnqpHzYMfZSk8cZRGfjeY1E/4Kj5p5uGQX6eXJg7nvgsFMuP6nwlMs1XgHNLwReFpV2qs0qg/YdJAf6jKAAhbvh2xYuN/dl3kajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jkO5HSky; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5710a3lS52044039, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754008563; bh=NTl19locgjkpOHb1sevFzTM/gmsxCTxvN7Z+nyrlYbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jkO5HSkytm8jnDIBqvqtj0VAybAz5Ds4Skfm219u+ZFdOQiBH1PCV217wnhFvKmVg
	 MyykVM1X+lseVfu/jbBgH9Vt9PtmuCmub66w7QX41RJxNzR2Kt7T6Dr8YDcM6sqi0L
	 4MdaQBPDzHRw2WDtTqoBCt1tu6P3PzRQUR3nF/tBAaix8JXvwDhFmd5gT+ZZfzHQFJ
	 rZmyh0WKxeBmDa6wIfsGcr3RdVFgy8ri3UNHzT2Yv+WouAAyGdyaaUP8gLowD1pIqQ
	 dWKByuKYxNiDgjqh02zWD1cOkwX3bo6Jq3XYXt3KPfQhTsXp52IWkhSoHzkcfKL2oj
	 793owHBtPHY/g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5710a3lS52044039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 08:36:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 08:36:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Aug 2025 08:36:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Fri, 1 Aug 2025 08:36:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sean Anderson <sean.anderson@linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bitterblue
 Smith" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Topic: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Index: AQHcANxb3F/NWj2ltUS/9AXHQ44SQ7RJzkeggAA2TWCAAiO5AIAAzSBg
Date: Fri, 1 Aug 2025 00:36:03 +0000
Message-ID: <3de4e7b1ff574e90bef6d670d0e941a4@realtek.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
 <20250729204437.164320-1-sean.anderson@linux.dev>
 <e8e68a94bb9940509233153f9764c397@realtek.com>
 <b4a69a44-bb9d-4c1d-b628-9204ed8c623e@linux.dev>
In-Reply-To: <b4a69a44-bb9d-4c1d-b628-9204ed8c623e@linux.dev>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

U2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+IHdyb3RlOg0KPiBPbiA3LzI5
LzI1IDIzOjQyLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+IHdyb3RlOg0KPiA+PiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxp
bnV4LmRldj4gd3JvdGU6DQo+ID4+ID4gVGhlcmUgYXJlIG1vcmUgdW5zdXBwb3J0ZWQgZnVuY3Rp
b25zIHRoYW4ganVzdCBMT1dSVF9SVFkuIEltcHJvdmUgb24NCj4gPj4gPiBjb21taXQgM2I2NjUx
OWIwMjNiICgid2lmaTogcnR3ODk6IHBoeTogYWRkIGR1bW15IGMyaCBoYW5kbGVyIHRvIGF2b2lk
DQo+ID4+ID4gd2FybmluZyBtZXNzYWdlIikgYnkgcHJpbnRpbmcgYSBtZXNzYWdlIGp1c3Qgb25j
ZSB3aGVuIHdlIGZpcnN0DQo+ID4+ID4gZW5jb3VudGVyIGFuIHVuc3VwcG9ydGVkIGNsYXNzLg0K
PiA+Pg0KPiA+PiBPbmNlIEkgZW5jb3VudGVyIGFuIHVuc3VwcG9ydGVkIGNsYXNzL2Z1bmMsIEkn
bGwgY2hlY2sgZmlybXdhcmUgdGVhbSBpZiB0aGUNCj4gPj4gQzJIIGV2ZW50cyBjYW4gYmUgaWdu
b3JlZC4gSWYgc28sIEkgYWRkIGEgZHVtbXkgZnVuY3Rpb24gdG8gYXZvaWQgdGhlIG1lc3NhZ2Uu
DQo+ID4+IElmIG5vdCwgSSBzaG91bGQgYWRkIGNvZGUgdG8gaGFuZGxlIHRoZSBldmVudC4NCj4g
Pj4NCj4gPj4gRG8geW91IHdhbnQgdG8gc2VlIHRoZSBtZXNzYWdlIGV2ZW4gdGhvdWdoIGl0IG9u
bHkgYXBwZWFycyBvbmNlPw0KPiA+Pg0KPiA+PiA+IERvIHRoZSBzYW1lIGZvciBlYWNoIHVuc3Vw
cG9ydGVkIGZ1bmMgb2YNCj4gPj4gPiB0aGUgc3VwcG9ydGVkIGNsYXNzZXMuIFRoaXMgcHJldmVu
dHMgbWVzc2FnZXMgbGlrZQ0KPiA+PiA+DQo+ID4+ID4gcnR3ODlfODkyMmFlIDAwMDA6ODE6MDAu
MDogUEhZIGMyaCBjbGFzcyAyIG5vdCBzdXBwb3J0DQo+ID4NCj4gPiBJcyB0aGlzIGEgcmVhbCBl
eGFtcGxlPw0KPiANCj4gVGhpcyBpcyBhIHJlYWwgZXhhbXBsZS4NCj4gDQo+ID4gV2UgaGF2ZSBo
YW5kbGVkIGNsYXNzIDIgKFJUVzg5X1BIWV9DMkhfQ0xBU1NfRE0pLCBubz8NCj4gDQo+IElmIGZ1
bmMgIT0gUlRXODlfUEhZX0MySF9ETV9GVU5DX0xPV1JUX1JUWSB0aGVuIHdlIGZhbGwgdGhyb3Vn
aCB0byB0aGUNCj4gZGVmYXVsdCBjYXNlLg0KDQpPaC4gSSBzZWUuIA0KDQo+IA0KPiA+IFBsZWFz
ZSBwb2ludCBvdXQgdGhlIGNsYXNzIC8gZnVuYyB5b3UgZW5jb3VudGVyZWQuIFRoZW4gSSBjYW4g
bG9vayB1cCB2ZW5kb3INCj4gPiBkcml2ZXIgb3IgY29udGFjdCBpbnRlcm5hbCBmaXJtd2FyZSB0
ZWFtIHRvIGtub3cgaWYgd2Ugc2hvdWxkIGltcGxlbWVudCBvcg0KPiA+IGp1c3QgYWRkIGEgZHVt
bXkgZnVuY3Rpb24uDQo+ID4NCj4gPiBJZiB3ZSBkZWZlciBpdCwgSSBkb24ndCBrbm93IHdoZW4g
d2UgY2FuIGRvIGl0Lg0KPiANCj4gcnR3ODlfODkyMmFlIDAwMDA6ODE6MDAuMDogUEhZIGMyaCBj
bGFzcyAyIGZ1bmMgMTIgbm90IHN1cHBvcnRlZA0KPiANCg0KVGhlIEMySCBldmVudCBoYW5kbGVy
IGhhcyBiZWVuIGFkZGVkIGJ5IFsxXS4NCg0KWzFdIGQzMWM0MjQ2NmIxYSAoIndpZmk6IHJ0dzg5
OiBwaHk6IGFkZCBDMkggZXZlbnQgaGFuZGxlciBmb3IgcmVwb3J0IG9mIEZXIHNjYW4iKQ0KDQoN
Cg==

