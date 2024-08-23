Return-Path: <linux-wireless+bounces-11817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8F895C2A4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 02:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39AF1F23CA0
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18254B66F;
	Fri, 23 Aug 2024 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YM4UQWwX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21631171A5
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724374751; cv=none; b=aG94v3uTJKDukYO+PR8CG5eubefYB+7rXbPPiHNjCtNKtdmFEzIjVJupNbiyHdPY/K5Ah+oyNGA9qSg9BeTpXCJhjO+usIdbL42MKmuJljRSNO4txF1JuRLFISp088bIXHY6imYlu/5Vq74OuhIN+E3x6APMaULDBV6qO1ODBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724374751; c=relaxed/simple;
	bh=LC0YsIRmLH6WGleLIVmrQd2uGiF7wCuGhNLmoVilsMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c7VrsVD5NXOB4U7X3E7iUK1Ohs6ulfzvRbh6lXa3Xmn7K8AtcI0BXS/s3RBQMPFXBUI6jZnQ/AcRJzYY4QeDqAwBz0sK43ROonGBR0ETCGP6EtGyq3BvwhPOSq7w+faqaXSmJh6Lztw9Ct+BshUKwo10w1G2cEsHLWiSdjbhles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YM4UQWwX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47N0wu5uB341684, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724374736; bh=LC0YsIRmLH6WGleLIVmrQd2uGiF7wCuGhNLmoVilsMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YM4UQWwXUgQgDTW6hXRz4Lqq0e3ESMiptaujP3vYFwDGLZTZtjTt5hQjFtmY5ouLY
	 djeV6HNQKdQaeugco0n3akueDUbIZEr7Rohrrik6HLWC7bTSgrDxDCmx4tYrHSXfJ+
	 NS8I9mk3A2XHjHsTy26gT+j6qDc3LbSSimc9TTdOES8CvaInZ7KqvZXcsfwuFOerXR
	 CIBR4RgQpZ4EOQXFbBb5Nz1c+39w5y1HuY/KrlbmDllvRPIO4m74GnrTwuDb2TSqws
	 XYgfD3WFAJETlvW4n79yU/mphpE/L/iiG8vZSuG7k7cQkTVqVzl2lSAyi7EMNEQiLq
	 ZIxnzZm9e0SGQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47N0wu5uB341684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 08:58:56 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 08:58:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Aug 2024 08:58:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 23 Aug 2024 08:58:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Nick Morrow <usbwifi2024@gmail.com>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH V2] linux-firmware: Add firmware for RTL8812AU device
Thread-Topic: [PATCH V2] linux-firmware: Add firmware for RTL8812AU device
Thread-Index: AQHa9MSID1+G4fkYOk+1V5IwmOeYj7I0BAFA
Date: Fri, 23 Aug 2024 00:58:56 +0000
Message-ID: <774a7dd01718448da4048e966f5430f1@realtek.com>
References: <f815d748-6578-441e-b61e-0a220d45e168@gmail.com>
In-Reply-To: <f815d748-6578-441e-b61e-0a220d45e168@gmail.com>
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

K2xpbnV4LXdpcmVsZXNzDQoNCkhpIE5pY2ssDQoNClBsZWFzZSBhbHdheXMgQ2MgbGludXgtd2ly
ZWxlc3MgZm9yIHJ0dzg4IGZpcm13YXJlLiANCg0KQW5kIHN1YmplY3QgcHJlZml4IHdvdWxkIGJl
ICJydHc4ODogLi4uIg0KDQpOaWNrIE1vcnJvdyA8dXNid2lmaTIwMjRAZ21haWwuY29tPiB3cm90
ZToNCj4gVGhpcyBmaXJtd2FyZSB3YXMgZXh0cmFjdGVkIGZyb20gdGhlICAyMDIxMDcwOCAtIHY1
LjEzLjYtMjMgcmVsZWFzZSBvZg0KPiB0aGUgdmVuZG9yIGRyaXZlciBmb3IgdGhpcyBkZXZpY2Ug
YW5kIGlzIGJlbGlldmVkIHRvIGJlIHRoZSBsYXRlc3QNCj4gcmVsZWFzZSBieSBSZWFsdGVrLiBU
ZXN0aW5nIG9mIHRoZSBuZXcgZHJpdmVyIGhhcyBiZWVuIGFjY29tcGxpc2hlZA0KPiB1c2luZyB0
aGlzIGZpcm13YXJlLiBOdW1lcm91cyB0ZXN0ZXJzIGhhdmUgYmVlbiBpbnZvbHZlZC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE5pY2sgTW9ycm93IDxVU0JXaUZpMjAyNEBnbWFpbC5jb20+DQo+IC0t
LQ0KPiB2MjoNCj4gICAgLSBObyBjaGFuZ2UuIFJlc3VibWl0dGVkIG5vdyB0aGF0IHRoZSBkcml2
ZXIgaXMgaW4gcmV2aWV3Lg0KPiAtLS0NCj4gICBXSEVOQ0UgICAgICAgICAgICAgICAgfCAgIDEg
Kw0KPiAgIHJ0dzg4L1JFQURNRSAgICAgICAgICB8ICAgMyArKysNCj4gICBydHc4OC9ydHc4ODEy
YV9mdy5iaW4gfCBCaW4gMCAtPiAyNzAzMCBieXRlcw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHJ0dzg4L3J0dzg4MTJhX2Z3LmJp
bg0KPiANCj4gZGlmZiAtLWdpdCBhL1dIRU5DRSBiL1dIRU5DRQ0KPiBpbmRleCA4YWViZTU2Yi4u
ZDZiZDQ4MTQgMTAwNjQ0DQo+IC0tLSBhL1dIRU5DRQ0KPiArKysgYi9XSEVOQ0UNCj4gQEAgLTMy
NzAsNiArMzI3MCw3IEBAIExpY2VuY2U6IFJlZGlzdHJpYnV0YWJsZS4gU2VlIExJQ0VOQ0UucnRs
d2lmaV9maXJtd2FyZS50eHQgZm9yIGRldGFpbHMuDQo+ICAgRHJpdmVyOiBydHc4OCAtIFJlYWx0
ZWsgODAyLjExYWMgV0xBTiBkcml2ZXIgZm9yIFJUTDg4MjJCRSBhbmQgUlRMODgyMkNFDQo+IA0K
PiAgIEluZm86IFNlbnQgdG8gTGFycnkgRmluZ2VyIGJ5IFJlYWx0ZWsgZW5naW5lZXIgWWFuLUhz
dWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+ICtGaWxlOiBydHc4OC9ydHc4ODEy
YV9mdy5iaW4NCj4gICBGaWxlOiBydHc4OC9ydHc4ODIxYV9mdy5iaW4NCg0KSSBmYWlsZWQgdG8g
YXBwbHkgdGhpcyBwYXRjaCwgZXZlbiB0aGlzIHRleHR1YWwgcGFydC4gDQoNClR3byBsZWFkaW5n
IHNwYWNlcyBiZWZvcmUgIkZpbGU6IHJ0dzg4L3J0dzg4MjFhX2Z3LmJpbiIsIGJ1dCBhY3R1YWxs
eSB0aGlzDQpzaG91bGQgYmUgb25seSBvbmUuIE5vdCBzdXJlIHdoYXQgaXMgd3JvbmcuDQoNCg0K
PiAgIEZpbGU6IHJ0dzg4L3J0dzg4MjJiX2Z3LmJpbg0KPiAgIEZpbGU6IHJ0dzg4L3J0dzg4MjJj
X2Z3LmJpbg0KPiBkaWZmIC0tZ2l0IGEvcnR3ODgvUkVBRE1FIGIvcnR3ODgvUkVBRE1FDQo+IGlu
ZGV4IDQ2OWRiMmY3Li5lZjNhNzUwNSAxMDA2NDQNCj4gLS0tIGEvcnR3ODgvUkVBRE1FDQo+ICsr
KyBiL3J0dzg4L1JFQURNRQ0KPiBAQCAtMTksNiArMTksOSBAQCBleGNlcHQgdGhhdCB0aGUgZGV2
aWNlIGNhbm5vdCBiZSB3YWtlbiBmcm9tIHRoZSB3aXJlbGVzcyBOSUNzLg0KPiANCj4gICBDdXJy
ZW50bHkgc3VwcG9ydGVkIGRldmljZXMgd2l0aCBjb3JyZXNwb25kaW5nIGZpcm13YXJlczoNCj4g
DQo+ICtSVEw4ODEyQVUNCj4gKyAgICBydHc4ODEyYV9mdy5iaW4NCj4gKw0KPiAgIFJUTDg4MjFB
VQ0KPiAgICAgICBydHc4ODIxYV9mdy5iaW4NCg0KU2ltaWxhciBwcm9ibGVtIGhlcmUuIA0KDQoN
Cg==

