Return-Path: <linux-wireless+bounces-5419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301E88F4EE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 02:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457351C26DC3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 01:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55301A38;
	Thu, 28 Mar 2024 01:53:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B01804A
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590815; cv=none; b=Cz/HcjSZHYkV36bTbw6Xwl7YxELQ0qboTLDV6dSNwnHImQg9BGh7fDsDtxWcwKbzDC61wtOYICPKQzo4AFhlp0m5cWn39QYi0C1Na0ITbBGSy3PeGZOppgYWPsG3WPIQ3x6qR+fpMaKZ9TpMA9hIagDO7X7K7pDS8waTbMTcgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590815; c=relaxed/simple;
	bh=BV3fMvUAmpfNxG7F0xDzuERBCHrPAOdJYribb3B/8z0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WLFmgrZsWYH/mRS5t174DdejJdvXPNVsUZgKjZ0m7U9EjfFtq3BbWIo7o0CqdommQugPfPAUGeJr4vL4b71gM2n8U9T7zIU5s34um0rK1ok+k5y7ACBCpsFwM3tNcd6ZDsoX+EYsIIgs63Aq9v98u4fExsFXL75ggDJtNj/0f6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42S1rTS711720035, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42S1rTS711720035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:53:29 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:53:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:53:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Thu, 28 Mar 2024 09:53:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw88: station mode only for SDIO chips
Thread-Topic: [PATCH v2] wifi: rtw88: station mode only for SDIO chips
Thread-Index: AQHaf9/EEjhNZDi1xUuyuSajGXSn8rFLobMAgAA9lAA=
Date: Thu, 28 Mar 2024 01:53:28 +0000
Message-ID: <0be24bf38d23307be2a0dc8ccf1101575c2cff29.camel@realtek.com>
References: <20240327004155.7172-1-pkshih@realtek.com>
	 <CAFBinCB5SiP3r-iK3ENUSxsdzaKQ+ZEjAcY0Mn7di54rABRewA@mail.gmail.com>
In-Reply-To: <CAFBinCB5SiP3r-iK3ENUSxsdzaKQ+ZEjAcY0Mn7di54rABRewA@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3612DCAF56E8842884C506AF7E434E9@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDIzOjExICswMTAwLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdy
b3RlOg0KPiANCj4gT24gV2VkLCBNYXIgMjcsIDIwMjQgYXQgMTo0M+KAr0FNIFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPiBTaW5jZSBvbmx5IHN0YXRpb24gbW9k
ZSBoYXMgYmVlbiB0ZXN0ZWQgb24gU0RJTyBjaGlwcywgb25seSBrZWVwIGl0IHN1cHBvcnQNCj4g
PiBmb3IgU0RJTyBjaGlwcyB0byByZWZsZWN0IGNvcnJlY3Qgc3VwcG9ydGVkIGZlYXR1cmVzLg0K
PiA+IA0KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzg3
d21wdTFkbzYuZnNmQGtlcm5lbC5vcmcvVC8jdA0KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXdpcmVsZXNzLzM2OTcyZmY1LTBjNDgtNGJkMi04ZjlhLTk2NDliZmEyNDIy
NUBsZXhpbmEuaW4vDQo+ID4gQ2M6IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5z
dGluZ2xAZ29vZ2xlbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IEFja2VkLWJ5OiBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0
aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPg0KDQpUaGFua3MgZm9yIHRoZSBhY2suIA0K
DQpOb3JtYWxseSBBY2tlZC1ieSBpcyBhZGRlZCBieSBtYWludGFpbmVyLCBzbyBJIHdpbGwgY2hh
bmdlIHRvIFJldmlld2VkLWJ5DQp3aGVuIGFwcGx5aW5nIHRoaXMgcGF0Y2guIA0KDQoNCg==

