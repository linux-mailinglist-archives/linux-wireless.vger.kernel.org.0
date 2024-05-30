Return-Path: <linux-wireless+bounces-8287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F448D43FE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 05:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3E928676D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E51CD2C;
	Thu, 30 May 2024 03:13:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C2F9F7
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038830; cv=none; b=bnvuYG5kt+l1em2RSFRFTICULY0+tKXQOMrt4LFassMIIEuBjL+Rykfg+/xnYeR3AzpF+8oL8dv2DdfBIQAXMkv/SL4f/vTPLK0cMXfAMPqUlFCWXpetINt0DWFmYYHLjlOE2KmJShdfvGbDfoFrsa7TJHhHmMWTiAqgBYUSGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038830; c=relaxed/simple;
	bh=pXslQ4P8d/Flf2YEf2zLA1N10ty7MotRTV3sC2ARESI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0K6HurwCDCQc3QRFJ4qnqYIb7JTB0H5zxegLYqW31U+KaJRFw04dSo7LbJ5QR8AgV/9NaehM4DE7LPzrs2tjjIY/nIptYKUq5GGnislJs6gpGYzL1jAVxLomPiA211ghakzwiPKAr+K1o2lk7CsdjVWS6uaftBlZf39G36ZoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44U3DcTX2239275, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44U3DcTX2239275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 11:13:38 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:13:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 30 May 2024 11:13:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 30 May 2024 11:13:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>
Subject: RE: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
Thread-Topic: wifi: rtw88: 8821CU hangs after some number of power-off/on
 cycles
Thread-Index: AQHasFw+pvHPaxxLgUK305GcfZdkyrGsA2eA///v6wCAAX/iEIAAZrWAgAE7nYA=
Date: Thu, 30 May 2024 03:13:38 +0000
Message-ID: <b9c85972ab634364bf8a705a4f4513fd@realtek.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com>
 <CA+GA0_sQ_Bnp8CUq1Pmxf7zut1Kocaxbw4iXT4hYC5_ceXb7WQ@mail.gmail.com>
 <3cc9cc75468d487c988dbacd8dfc5f57@realtek.com>
 <CA+GA0_tUy0EuXm0CGYa8SsS78oRNHUanBNwRf_BLXERa1=MYdg@mail.gmail.com>
In-Reply-To: <CA+GA0_tUy0EuXm0CGYa8SsS78oRNHUanBNwRf_BLXERa1=MYdg@mail.gmail.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiDFm3Iu
LCAyOSBtYWogMjAyNCBvIDAzOjUyIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiBu
YXBpc2HFgihhKToNCj4gPg0KPiA+IE1hcmNpbiDFmmx1c2FyeiA8bWFyY2luLnNsdXNhcnpAZ21h
aWwuY29tPiB3cm90ZToNCj4gPiA+IHd0LiwgMjggbWFqIDIwMjQgbyAwNTo1MiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4gbmFwaXNhxYIoYSk6DQo+ID4gPiA+DQo+ID4gPiA+IE1h
cmNpbiDFmmx1c2FyeiA8bWFyY2luLnNsdXNhcnpAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEkgZm91bmQgb3V0IHRoYXQgdGhlIHJlYXNvbiBmb3IgdGhvc2UgaGFuZ3Mg
aXMgYSBwb3dlci1vZmYrb24gc2VxdWVuY2UgdGhhdCdzDQo+ID4gPiA+ID4gdHJpZ2dlcmVkIGJ5
IHRoZSBhYm92ZSBzdGVwcy4NCj4gPiA+ID4NCj4gPiA+ID4gVG8gYXZvaWQgcG93ZXItb2ZmL29u
IHNlcXVlbmNlIG9uY2UgZGV2aWNlIGJlY29tZXMgaWRsZSwgSSB3b3VsZCBsaWtlIHRvIGFkZA0K
PiA+ID4gPiBhIGlwc19kaXNhYmxlZCBoZWxwZXIuIFBsZWFzZSByZXZlcnQgeW91ciBjaGFuZ2Vz
IGFuZCBhcHBseSBteSBhdHRhY2hlZCBwYXRjaC4NCj4gPiA+DQo+ID4gPiBNeSBmaXJzdCBhdHRl
bXB0IHdhcyB2ZXJ5IHNpbWlsYXIsIGFuZCBpdCBmaXhlZCBzb21lIGNhc2VzIGJ1dCBub3QgYWxs
IG9mIHRoZW0uDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBkdWUgdG8gdGhlIGV4aXN0ZW5jZSBvZiBh
IHNlY29uZCBzb3VyY2Ugb2YgcG93ZXItb2ZmcyAtIHJ0d19vcHNfc3RvcCwNCj4gPiA+IHdoaWNo
IGlzIGNhbGxlZCwgZS5nLiwgb24gZG93bmluZyB0aGUgaW50ZXJmYWNlIChpZmNvbmZpZyB3bGFu
MCBkb3duKS4NCj4gPg0KPiA+IFBsZWFzZSB0cnkgYXR0YWNoZWQgdjIgcGF0Y2guIEkgd291bGQg
bGlrZSB0byBoYXZlIGFuIGV4cGxpY2l0IGhlbHBlcg0KPiA+IChpLmUuIGFsd2F5c19wb3dlcl9v
biBpbiB2MikgdG8gaGF2ZSB0aGlzIGZpeCwgc28gZGF5cyBsYXRlciBwZW9wbGUgY2FuIGJlIGVh
c3kNCj4gPiB0byB1bmRlcnN0YW5kIGhvdyBpdCB3b3Jrcy4gTm90IHByZWZlciBhZGp1c3Rpbmcg
ZXhpc3RpbmcgZmxhZ3MgdG8gaW1wbGljaXRseQ0KPiA+IGhhdmUgYmVoYXZpb3IgeW91IHdhbnQu
DQo+IA0KPiBTbywgZG8geW91IHRoaW5rIHRoaXMgaXMgYSBjaGlwIGlzc3VlLCBub3QganVzdCBz
b21lIGRyaXZlciBtaXNjb25maWd1cmF0aW9uPw0KDQpJIGFza2VkIGludGVybmFsIFVTQiBXaUZp
IHBlb3BsZSB3aG8gc2F5IHZlbmRvciBkcml2ZXJzIG9mIFVTQi9TRElPIGNhbid0DQpwb3dlci1v
bi8tb2ZmIGZyZXF1ZW50bHkgYnV0IG5vdCB2ZXJ5IHN1cmUgaWYgaGFyZHdhcmUgaXNzdWUgb3Ig
ZHJpdmVyIGlzc3VlLg0KDQo+IA0KPiBJJ20gYXNraW5nIGJlY2F1c2UgaWYgd2UgYXJlIGdvaW5n
IGluIHRoaXMgZGlyZWN0aW9uLCB0aGVyZSdzIHNvbWV0aGluZw0KPiBtb3JlIHRvIGZpeC4uLiBX
aXRoIHlvdXIgdjIsIHZlcnkgZnJlcXVlbnRseSwgSSBoaXQgV0FSTl9PTighbG9jYWwtPnN0YXJ0
ZWQpIGluDQo+IGllZWU4MDIxMV9yeF9uYXBpIChpbiB3aXJlbGVzcy1uZXh0LCB0aGUgY29kZSB3
YXMgbW92ZWQgdG8gaWVlZTgwMjExX3J4X2xpc3QpLg0KPiANCj4gV2l0aCBteSBwYXRjaCwgSSBj
aGVja2VkIGFuZCBoaXQgdGhhdCBXQVJOX09OLCB0b28sIGJ1dCB2ZXJ5IG9jY2FzaW9uYWxseS4N
Cj4gDQo+IEkgdGhpbmsgdGhlIGRpZmZlcmVuY2UgaXMgaW4gd2hhdCBoYXBwZW5zIGluIHJ0d19p
cHNfZW50ZXIgLSBJIGRpc2FibGVkIG9ubHkNCj4gdGhlIHBvd2VyX29mZiwgYnV0IHlvdSBhbHNv
IGRpc2FibGVkIGV2ZXJ5dGhpbmcgZWxzZSwgaW5jbHVkaW5nIHRoZSBjYW5jZWxhdGlvbg0KPiBv
ZiB3b3JrX3N0cnVjdHMuDQo+IA0KPiBUaGUgd2FybmluZyBpdHNlbGYgc291bmRzIGhhcm1sZXNz
LCBidXQgSSB0aGluayB1c2VycyBzaG91bGQgbmV2ZXIgc2VlIHN1Y2gNCj4gd2FybmluZ3MsIHNv
IHRoaXMgbmVlZHMgdG8gYmUgZml4ZWQgc29tZWhvdy4gUHJvYmFibHkgc29tZSBhZGRpdGlvbmFs
DQo+IHdvcmtfc3RydWN0KHMpIG5lZWQgdG8gYmUgY2FuY2VsZWQ/DQo+IA0KDQpJIGZvcmdvdCB0
byBzYXkgbXkgcGF0Y2ggaXMgY29tcGlsZWQgdGVzdCBvbmx5LCBhbmQgSSBkaWRuJ3QgY29uc2lk
ZXIgZmxvdw0KdG9vIG11Y2gsIGp1c3QgdG8gY2xvc2UgdGhlIGJlaGF2aW9yIG9mIHlvdXIgcGF0
Y2hlcy4gWW91IGNhbiBpbXByb3ZlIG15IHBhdGNoDQp0byBiZSBtb3JlIHJlbGlhYmxlIHRvIGF2
b2lkIFdBUk5fT04oKS4gIA0KDQpQaW5nLUtlDQoNCg==

