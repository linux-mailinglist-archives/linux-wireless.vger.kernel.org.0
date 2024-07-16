Return-Path: <linux-wireless+bounces-10248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F3931F0B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 04:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC621C21613
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 02:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B315E9B;
	Tue, 16 Jul 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mRhy4LzV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8F1170F
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098572; cv=none; b=Ji+MDFsZkYQfueFQvSswZMBSzC62ZYtkrX4IpZJscNqZxTxxBgFycecZX9h7YogAS2zFmnDXFDqQBdJhNmotSQT1xbxE6qPJylFokjsSs82288ru6Hm3jFX7nzDyCMdEAF9Vkgxyra9XRh+O/sbw/hwG5EFrG2tBkgTKE1nNc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098572; c=relaxed/simple;
	bh=2kWXORceaMz/Tlcjy39mXwZMGDonNFx1M+oSq5xSsGw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qAemIJL6SSlbkv2lZ0F344sUTMGd6wnEy8d/WyVMmJbwP6lryXKKudPeakoiUBb3KdQ0gKyb2XSQ1wlcJzJA+SyQM/1KNkQuVoQhR0qbrcUTT/lke729/tiOvG+6g+acMzWDzgIdvL8+kZQNkVqYIaUMdhvoL2bBFDE8ljbXBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mRhy4LzV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46G2u4wtD360508, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721098564; bh=2kWXORceaMz/Tlcjy39mXwZMGDonNFx1M+oSq5xSsGw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-ID:Content-Transfer-Encoding:MIME-Version;
	b=mRhy4LzVC0xcxwKKEayS/miTGq5fphDHabaRGK6FjBsZIFVHZ7XOqnH7jyDsqkCX1
	 EW/aHTGziFIIwJHNoKO+VZxicukFEdmH4jisx8ka3s+yNbNfKKz7ILUFvZDp3WVbRJ
	 8x8IHkyc6NeogLsjh8SQQgPvKYC74qfzdi6eFCsnI8ODVm0CtWAXDo4w5ajrm1kkfe
	 hIsouI0kdRex/LQ+YOVx0FDMEXTY5TaGEi5+Imb8n5bNOsDfi9vtDD4tGB6WTyLgOw
	 XfYlMt3+A5e/7uCCJ4WR4/xktp3bY7nylrGYKdBAA9bfRwqaWOhmxSAmBaif2nS3b3
	 FT51DoOASdI/g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46G2u4wtD360508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 10:56:04 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 10:56:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jul 2024 10:56:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Jul 2024 10:56:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: Re: rtw88: The debugfs interface reads registers from the wrong device
Thread-Topic: rtw88: The debugfs interface reads registers from the wrong
 device
Thread-Index: AQHa1qbdlNhPu3M8PEuf9XqbWbxrtbH3IEAAgADosQCAABroAA==
Date: Tue, 16 Jul 2024 02:56:03 +0000
Message-ID: <cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com>
References: <e28bbf72-678a-438b-b5dc-d4ae8b8f71f0@gmail.com>
	 <77b8adc4-daa9-4869-8773-c5de9eb84299@gmail.com>
	 <1d00170b5f0a39bdff6f759de300a402209ace03.camel@realtek.com>
In-Reply-To: <1d00170b5f0a39bdff6f759de300a402209ace03.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E3A26B11277454C898308ABCC1271AC@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA3LTE2IGF0IDAxOjE5ICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IE9uIE1vbiwgMjAyNC0wNy0xNSBhdCAxNDoyNiArMDMwMCwgQml0dGVyYmx1ZSBTbWl0aCB3cm90
ZToNCj4gPiBPbiAxNS8wNy8yMDI0IDE0OjA1LCBCaXR0ZXJibHVlIFNtaXRoIHdyb3RlOg0KPiA+
ID4gSGksDQo+ID4gPiANCj4gPiA+IFRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSwgeW91IG5lZWQg
YSBjb21wdXRlciB3aXRoIHR3byB3aWZpDQo+ID4gPiBkZXZpY2VzIHN1cHBvcnRlZCBieSBydHc4
OC4gSXQncyBlc3BlY2lhbGx5IGVhc3kgdG8gbm90aWNlDQo+ID4gPiB0aGUgcHJvYmxlbSBpZiBv
bmUgb2YgdGhlIGRldmljZXMgaXMgVVNCIGFuZCB0aGUgb3RoZXIgaXMgUENJLA0KPiA+ID4gYmVj
YXVzZSB0aGUgUENJIGRldmljZSB3aWxsIGhhdmUgdmFyaW91cyB2YWx1ZXMgaW4gdGhlDQo+ID4g
PiByZWdpc3RlcnMgMHgzMDAuLjB4M2ZmLCBidXQgdGhlIFVTQiBkZXZpY2Ugd2lsbCBoYXZlIGFs
bA0KPiA+ID4gMHhlYWVhZWFlYSB0aGVyZS4NCj4gPiA+IA0KPiA+ID4gMS4gTGV0J3MgYXNzdW1l
IHRoZSBkcml2ZXIgZm9yIHRoZSBQQ0kgZGV2aWNlIGlzIGFscmVhZHkgbG9hZGVkLg0KPiA+ID4g
ICAgSSBoYXZlIFJUTDg4MjJDRS4NCj4gPiA+IA0KPiA+ID4gMi4gTW91bnQgZGVidWdmczoNCj4g
PiA+IA0KPiA+ID4gICAgIyBtb3VudCAtdCBkZWJ1Z2ZzIG5vbmUgL3N5cy9rZXJuZWwvZGVidWcN
Cj4gPiA+IA0KPiA+ID4gMy4gQ2hlY2sgcGFnZSAweDMwMDoNCj4gPiA+IA0KPiA+ID4gICAgIyBj
YXQgL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeTAvcnR3ODgvbWFjXzMNCj4gPiA+ICAg
ICAgMDAwMDAzMDAgIGY3MTM4MDAwICAgIDMzMzMwMDAwICAgIGZmZmZiMDAwICAgIDAwMDAwMDAw
DQo+ID4gPiAgICAgIC4uLi4uDQo+ID4gPiANCj4gPiA+IDQuIFBsdWcgdGhlIFVTQiBkZXZpY2Uu
IEkgdXNlZCBSVEw4ODExQ1UuDQo+ID4gPiANCj4gPiA+IDUuIENoZWNrIHBhZ2UgMHgzMDAgYWdh
aW46DQo+ID4gPiANCj4gPiA+ICAgICMgY2F0IC9zeXMva2VybmVsL2RlYnVnL2llZWU4MDIxMS9w
aHkwL3J0dzg4L21hY18zDQo+ID4gPiAgICAgIDAwMDAwMzAwICBlYWVhZWFlYSAgICBlYWVhZWFl
YSAgICBlYWVhZWFlYSAgICBlYWVhZWFlYQ0KPiA+ID4gICAgICAuLi4uLg0KPiA+ID4gDQo+ID4g
PiA2LiBCb251czogdW5sb2FkIHJ0dzg4Xzg4MjFjdSBhbmQgY2hlY2sgcGFnZSAweDMwMCBhZ2Fp
biB0byBnZXQNCj4gPiA+ICAgIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlOg0KPiA+ID4gDQo+
ID4gPiAgICAjIHJtbW9kIHJ0dzg4Xzg4MjFjdQ0KPiA+ID4gICAgIyBjYXQgL3N5cy9rZXJuZWwv
ZGVidWcvaWVlZTgwMjExL3BoeTAvcnR3ODgvbWFjXzMNCj4gPiANCj4gPiBJIGZvcmdvdCB0byBz
YXk6IG15IGtlcm5lbCBpcyA2LjkuOC1hcmNoMS0xIGZyb20gQXJjaCBMaW51eC4NCj4gPiBUaGUg
cHJvYmxlbSBhbHNvIGhhcHBlbnMgd2l0aCBrZXJuZWwgNi45LjggcGx1cyBydHc4OCBmcm9tDQo+
ID4gcnR3LW5leHQuDQo+IA0KPiBUaGlzIGxpbWl0YXRpb24gaXMgZXhpc3Rpbmcgc2luY2UgaW5p
dGlhbCBkcml2ZXIuDQo+IA0KPiBUbyByZWFkIGEgcmFuZ2Ugb2YgbGFyZ2UgcmVnaXN0ZXJzIGFy
ZWEsIGZvciBleGFtcGxlLCB3ZSBuZWVkIHRvDQo+IGEgcmFuZ2UgdmlhIHdyaXRlIG9wZXJhdGlv
biBhbmQgc3RvcmUgYXMgYSBwcml2YXRlIGRhdGEsIGFuZA0KPiB0aGVuIHVzZSByZWFkIG9wZXJh
dGlvbiB3aXRoIHByaXZhdGUgZGF0YSB0byByZWFkIHJlZ2lzdGVycy4NCj4gDQo+IFRoZSBsaW1p
dGF0aW9uIGlzIGJlY2F1c2UgdGhlIHByaXZhdGUgZGF0YSBpcyBzdGF0aWMgdmFyaWFibGUuDQo+
IEEgcG9zc2libGUgc29sdXRpb24gaXMgdG8gZHVwbGljYXRlIHN0YXRpYyB2YXJpYWJsZSBpbnRv
IHJ0d2Rldi4NCj4gTm90IHN1cmUgaWYgaXQgaXMgd29ydGggdG8gYWRqdXN0IGNvZGVzIGZvciBk
ZWJ1ZyBwdXJwb3NlIG9ubHkuDQo+IA0KPiBBbm90aGVyIGVhc2llciBzb2x1dGlvbiBpcyB0byBh
dm9pZCBjcmVhdGluZyBkZWJ1Z2ZzIGZvciBzZWNvbmQNCj4gYWRhcHRlci4gSG93IGRvIHlvdSB0
aGluaz8NCj4gDQoNClRoaW5rIGEgbGl0dGxlIGJpdCBmdXJ0aGVyLiBJIHdpbGwgdHJ5IHRvIGR1
cGxpY2F0ZSBzdGF0aWMgdmFyaWFibGVzDQp0byBzdXBwb3J0IG11bHRpcGxlIGFkYXB0ZXJzLiAN
Cg0KDQo=

