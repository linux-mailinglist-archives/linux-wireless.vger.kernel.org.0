Return-Path: <linux-wireless+bounces-5308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998ED88D372
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 01:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C7B2347F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E7FC19;
	Wed, 27 Mar 2024 00:41:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68D179AE
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711500106; cv=none; b=OXfaduULrQ2EA+yoG9BITeZZgGFVBW96vrspQMeEbYH4ZPPTT5hSHJX72V7DPJSx5M4RZxVVgFRLdo+P5yrOAQnPbsLUcqjaCEU1VOsbFUzwhd8LlUrY+CaD1x0tObultlQ71iTZhLPgNDCP0HCEQZh7PpsYRiyRCE6kDtZJsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711500106; c=relaxed/simple;
	bh=GnpIP5VwCuB0dK5YUQeRwTP8QsvqvR+ImFQfkXNsbfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrOI2/mCFWee121YVERTB465NUnXcIxIlZiAHhq9FyzaUG0dZbe483EGjfM1d/7CKxmfsjhQ1Ivj69/Gc2OWT5sTi3WHcATWsZ81ZZqsvPVmlNPTKQyQYmS+VzDTeC8XQbWZRt428IYKrJgxtweksCxqvgvKpthbu170tysfevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42R0feylF153041, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42R0feylF153041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 08:41:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 08:41:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 08:41:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Wed, 27 Mar 2024 08:41:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: station mode only for SDIO chips
Thread-Topic: [PATCH] wifi: rtw89: station mode only for SDIO chips
Thread-Index: AQHafx+2ZD/RcxmKpkalB8Pt6sYvvLFJ5NsAgABVh4A=
Date: Wed, 27 Mar 2024 00:41:39 +0000
Message-ID: <3d18a17216c0352d656dd4783d131c8f65d26370.camel@realtek.com>
References: <20240326014707.17458-1-pkshih@realtek.com>
	 <CAFBinCDdagAbmTBx_4qezbaPwrEK+5YaQhTZm_YjnrMc4OSJ6g@mail.gmail.com>
In-Reply-To: <CAFBinCDdagAbmTBx_4qezbaPwrEK+5YaQhTZm_YjnrMc4OSJ6g@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D8D7D5A43A6ED41BE6FF98170C30C93@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVHVlLCAyMDI0LTAzLTI2IGF0IDIwOjM0ICswMTAwLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdy
b3RlOg0KPiANCj4gSGVsbG8gUGluZy1LZSwNCj4gDQo+IE9uIFR1ZSwgTWFyIDI2LCAyMDI0IGF0
IDI6NDjigK9BTSBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4g
U2luY2Ugb25seSBzdGF0aW9uIG1vZGUgaGFzIGJlZW4gdGVzdGVkIG9uIFNESU8gY2hpcHMsIG9u
bHkga2VlcCBpdCBzdXBwb3J0DQo+ID4gZm9yIFNESU8gY2hpcHMgdG8gcmVmbGVjdCBjb3JyZWN0
IHN1cHBvcnRlZCBmZWF0dXJlcy4NCj4gT3ZlcmFsbCBJJ20gZmluZSB3aXRoIHRoaXMgcGF0Y2gs
IHRoYW5rcyBmb3IgdGFraW5nIGNhcmUgb2YgaXQhDQo+IA0KPiBJIG9ubHkgaGF2ZSBvbmUgc21h
bGwgY29tbWVudDogdGhlIHN1YmplY3QgbGluZSBzaG91bGQgc3RhcnQgd2l0aA0KPiAid2lmaTog
cnR3ODg6IC4uLiIgKGN1cnJlbnRseSBpdCBzdGF0ZXMgcnR3ODkpDQoNCkFoLiBTb21laG93IEkg
bWFkZSB0aGlzIG1pc3Rha2UuIEknbSBhZGRpbmcgYSBydWxlIHRvIGF2b2lkIHRoaXMgaW4gbXkg
c2NyaXB0cw0KbG9jYWxseS4gVGhhbmtzIGZvciBwb2ludGluZyBvdXQgdGhpcy4gDQoNCg0KPiBX
aXRoIHRoYXQgY2hhbmdlZDoNCj4gQWNrZWQtYnk6IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRp
bi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+DQo+IA0KPiBBbHNvIEknbSBob3BpbmcgdGhh
dCBzb21lIHBlb3BsZSB3aWxsIHN0ZXAgdXAgYW5kIGZpbmQgdGhlIG1pc3NpbmcNCj4gbGluayB0
byBnZXQgQVAgbW9kZSB3b3JraW5nIG9uIFNESU8gY2hpcHMuIEkgY3VycmVudGx5IGRvbid0IGhh
dmUgdGltZQ0KPiBmb3IgdGhpcy4NCj4gDQoNCkkgaG9wZSBzby4gVGhhbmtzIGZvciB0aGUgZWZm
b3J0IHlvdSBoYXZlIG1hZGUuIDopDQoNClBpbmctS2UNCg0K

