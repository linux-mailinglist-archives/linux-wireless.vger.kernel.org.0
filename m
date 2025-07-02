Return-Path: <linux-wireless+bounces-24758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17205AF0CEF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 09:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E641C22B39
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1707229B21;
	Wed,  2 Jul 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gCo7i19V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD8149C64
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442435; cv=none; b=jkGHi16LerP8FzwYNVAa6BkPK6/mMZTB5mKRy7VZ5yn8QZqgOikvJMRJF+WFt7TcMN0vpWtk1b//RSjMPGVRDMfOY/uJpR2q/PctuoRJBAXlUkzT8eha39TQeN64PFb+bAuJkuvTFQlAf+tGkJtGRLwq2IliLA7OCJ08mjJgcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442435; c=relaxed/simple;
	bh=7V1NDz1AMGg/KE0IfTkNUubdvey4heToHgW24nMwOeA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvFyaAT8jWnbYXl2RS+CTr+63yzKOdFCuyti9KTQtNr+8NNF4EJruA7iCthD/6sQWsUQojWHnj+FVc3n+CYbNLSaYCG+0op7U5THuseTQ1hufGsAczZVm5ozW4VoxK7JlHn6RMO4rjg2YCy3ls/mIoVeXdxjz7RgbV8PvPZJvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gCo7i19V; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5627l2KI1407552, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751442423; bh=7V1NDz1AMGg/KE0IfTkNUubdvey4heToHgW24nMwOeA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gCo7i19V0e8iMk/S+lST+3TOboxzgeb/qMl008CUmI6Y//njN8+LJFocVsAFGZRFJ
	 kMryiRWLSXlwH9bkmaK4h1WgmrPugFpAutIWVaemWN2k/iCx/PnCRtroCr+yveKxrM
	 VviWj4AoLBdghEorkItiHjNaKjS6VreQhQZvHFToeM9B4eoMsn16jEh4Ub/4YPG/BV
	 bLQXZJWRFHM3m8wawCVOxZe0kkmaVjkOKRsAzdVq12yGlOTi7toibjlfZG0l1qUKkJ
	 4WXOCOi54gjEKgYPQ0AVdEReMnwOAXVzwg15oZCFtyg+/tJj+kTI9M03JQIse54hfi
	 eTh45TDA7YMbA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5627l2KI1407552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 15:47:03 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 15:47:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 2 Jul 2025 15:47:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 2 Jul 2025 15:47:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ansh Gupta <anshgupta1941@outlook.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: rtw89: RTL8852BE Frequent Bluetooth disconnections and occasional Wi-Fi dropouts
Thread-Topic: rtw89: RTL8852BE Frequent Bluetooth disconnections and
 occasional Wi-Fi dropouts
Thread-Index: AQHb6mPDvLIql/k04UqqEVq5M618M7QeMTtQ
Date: Wed, 2 Jul 2025 07:47:24 +0000
Message-ID: <1293cd1841414523ac2d159e69db482f@realtek.com>
References: <KL1PR01MB5322B34FA3997A94C6F12A3BB241A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
In-Reply-To: <KL1PR01MB5322B34FA3997A94C6F12A3BB241A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
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

QW5zaCBHdXB0YSA8YW5zaGd1cHRhMTk0MUBvdXRsb29rLmNvbT4gd3JvdGU6DQo+IEhlbGxvLA0K
PiANCj4gDQo+IE15IEJsdWV0b290aCBlYXJwaG9uZXMgZnJlcXVlbnRseSBkaXNjb25uZWN0IHdo
ZW4gbm8gbWVkaWEgaXMgcGxheWluZy4NCj4gSGVyZSBpcyB0aGUgc2NlbmFyaW8gdG8gbWFrZSBp
dCBjbGVhcmVyOg0KPiANCj4gMS4gSSBjb25uZWN0IHRvIG15IEJsdWV0b290aCBlYXJwaG9uZXMu
DQo+IA0KPiAyLiBJIHN0YXJ0IHN0cmVhbWluZyBhIHZpZGVvLg0KPiANCj4gMy4gV2hlbiB0aGUg
dmlkZW8gZW5kcywgSSBjaG9vc2UgYW5vdGhlciBvbmUgdG8gc3RyZWFtLg0KPiANCj4gNC4gQXMg
c29vbiBhcyB0aGUgbmV3IHZpZGVvIHN0YXJ0cyBwbGF5aW5nLCBCbHVldG9vdGggZGlzY29ubmVj
dHMuDQo+IA0KDQpJZiB5b3UgcGxheSBhIGxvY2FsIG11c2ljIHdpdGhvdXQgV2lGaSBjb25uZWN0
aW9uLCBkb2VzIGl0IHdvcmsgd2VsbD8NCg0KPiANCj4gQSBmZXcgcmVsYXRlZCB0aGluZ3MgYWxz
byBoYXBwZW4sIHN1Y2ggYXM6DQo+IA0KPiAxLiBEZWxheSBpbiBwcm92aWRpbmcgYXVkaW8gb3V0
cHV0IGZyb20gZWFycGhvbmVzIHdoZW4gYSB2aWRlbyBsb2FkcywNCj4gDQo+IDIuIFNsb3cgbmV0
d29yayAod2l0aCBibHVldG9vdGggb24pLCBkdWUgdG8gd2hpY2ggSSBjb3VsZCBub3Qgc3RyZWFt
DQo+IHZpZGVvcyB3aXRob3V0IGJ1ZmZlcmluZyBldmVyeSAxMC0yMCBzZWNvbmRzLA0KPiANCj4g
My4gT2NjYXNpb25hbCBXaS1GaSBhbmQgYmx1ZXRvb3RoIGRyb3BvdXRzIGF0IHRoZSBzYW1lIHRp
bWUuDQoNCklmIG9ubHkgV2lGaSBjb25uZWN0aW9uICh3aXRob3V0IEJsdWV0b290aCksIGRvZXMg
Y29ubmVjdGlvbiBkcm9wPw0KDQo+IA0KPiBUaGUgYXZhaWxhYmxlIG5ldHdvcmsgY29ubmVjdGlv
biBwb2ludChzKSB1c2VzIDIuNEdIeiBiYW5kLiBJIGhhdmUNCj4gY29uY2x1ZGVkIHRoYXQgdGhl
IGVhcnBob25lcyBhcmUgbm90IHByb2JsZW1hdGljIGFmdGVyIHRlc3RpbmcgdGhlbSBvbiBhDQo+
IFdpbmRvd3MgaW5zdGFsbGF0aW9uIG9uIHRoZSBzYW1lIGRldmljZSBhbmQgb24gbXkgcGhvbmUu
DQoNCkJsdWV0b290aCBvcGVyYXRlcyBvbiAyLjRHSHogYmFuZCwgc28gaXMgaXQgcG9zc2libGUg
dG8gY29ubmVjdCBBUCBvbg0KNSBHSHogYmFuZD8NCg0KPiANCj4gDQo+IEkgZGlzYWJsZWQgcG93
ZXIgc2F2aW5nIGZlYXR1cmVzIGFzIG1lbnRpb25lZCB3aXRoIHRoZSBkcml2ZXIgb3B0aW9ucyBp
bg0KPiAvZXRjL21vZHByb2JlLmQvcnR3ODkuY29uZiwgd2hpY2ggZGlkIG5vdCBmaXggdGhlIGlz
c3VlLiBJIHdlbnQgYWhlYWQgdG8NCj4gdG9nZ2xlIGRpc2FibGVfY2xrcmVxIGFzIHdlbGwgdG8g
c2VlIGlmIGl0IGRvZXMgc29tZXRoaW5nLCBpdCBkaWQgbm90DQo+IGZpeCB0aGUgcHJvYmxlbSBl
aXRoZXIuIEkgdG9nZ2xlZCBkaXNhYmxlX2Nsa3JlcSB0byBOIHJpZ2h0IGFmdGVyIGNoZWNraW5n
Lg0KPiANCj4gJCBjYXQgL2V0Yy9tb2Rwcm9iZS5kL3J0dzg5LmNvbmYNCj4gb3B0aW9ucyBydHc4
OV9wY2kgZGlzYWJsZV9jbGtyZXE9biBkaXNhYmxlX2FzcG1fbDE9eSBkaXNhYmxlX2FzcG1fbDFz
cz15DQo+IG9wdGlvbnMgcnR3ODlfY29yZSBkaXNhYmxlX3BzX21vZGU9eQ0KDQpUdXJuIG9mZiBw
b3dlciBzYXZlaW5nIGVudGlyZWx5IGJ5DQogIHN1ZG8gaXcgd2xhbjAgc2V0IHBvd2VyX3NhdmUg
b2ZmIA0KDQp0byBzZWUgaWYgZWFzZSBzeW1wdG9tLg0KDQoNCkFsbCBleHBlcmltZW50cyBhYm92
ZSBhcmUgdG8gY2xhcmlmeSBjYXVzZSANCg0KPiBbwqAgICA0LjM2NDMzMF0gcnR3ODlfODg1MmJl
IDAwMDA6MDI6MDAuMDogRmlybXdhcmUgdmVyc2lvbiAwLjI5LjI5LjgNCj4gW8KgICAgNS4wMzc2
MzNdIEJsdWV0b290aDogaGNpMDogUlRMOiBmdyB2ZXJzaW9uIDB4MDk4YjE1NGINCg0KSSBoYXZl
IGNvbmZpcm1lZCB0aGVzZSBhcmUgYWxyZWFkeSB0aGUgbGF0ZXN0IGZpcm13YXJlIG9mIFdpRmkg
YW5kIEJULg0KDQoNCg==

