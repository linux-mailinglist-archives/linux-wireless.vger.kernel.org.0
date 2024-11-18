Return-Path: <linux-wireless+bounces-15434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6959D07E7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 03:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD24281DCD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0122907;
	Mon, 18 Nov 2024 02:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LMsQYh32"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE29360
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 02:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896973; cv=none; b=Mz0bb+Dt1oJXwEMQLRYscAinFhB1wYeeyPoKiO5bZt7Z2izNejtWJd3a+P3PPKA50KwTllCeyrBwyM2T+SF0xvBDeCldN+3f+k+fHH4OHOYfIdDA8WRErFHL6xD2K6ns35F+hZlICWatLtcH2B2E3YFCvOlFiYLcKLKzM2wv550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896973; c=relaxed/simple;
	bh=DGx2leH0Ma2c1f+Ctub4LbxlzxbqlXXjKrG1EiJ1Z0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDZaqa7G6AapGNVdlufPcGtrtLbaCf5rJbRJW7EYrsUdOGiNh3H3W/dKn1y6kjiewaAwP9AMfvR7TTu0HshzC4X0TLPs/KFm12voL569KcrHGRwguZhF2DYNwCg3vBqQ4+8/owo1iyIKEDoaXpY8ZouINiJOTzG8dIcdP/towdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LMsQYh32; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI2SuuP64172738, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731896936; bh=DGx2leH0Ma2c1f+Ctub4LbxlzxbqlXXjKrG1EiJ1Z0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LMsQYh32Vq8dceYYMR0FoDTLvBnbL1Jm7IJCAwRvHsW5NirEFevL0J3Rt7o6ITYO0
	 LfsLLmMvv9GFHLCL6mm8KJPqaArd09VEV9D+dWtHa0VSLcLu/yj56ziE98It6oImQv
	 YW9PpxXfdaXtSfdcnxYrfnEP/JkrYYbaKFawRR6oBYa+FlRx4965Wj+F31oNZArH88
	 /FeIncSv6ponSgSd6zD4bO1FsH5TNzeqBUDx3Li20zYOVK3y3jA7Ze6DopGz5ZR/EP
	 wo9qCvc2AaslktNlkShKp2viAxx+Tz5DupiEbh4vQAoNxSkCww6jabOtdYIMkIsFDG
	 qS/U52V/AC3PQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI2SuuP64172738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:28:56 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 10:28:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Nov 2024 10:28:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 18 Nov 2024 10:28:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Ezra Buehler <ezra@easyb.ch>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Johannes Berg
	<johannes.berg@intel.com>,
        Reto Schneider
	<reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
Thread-Topic: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8192CU
 (RTL8188CUS)
Thread-Index: AQHbMhgkhIbKCL7Vg0q1gMIzeijdmLKtXP+AgA8BdtA=
Date: Mon, 18 Nov 2024 02:28:55 +0000
Message-ID: <c169783108de47f5a303153bd8c7d158@realtek.com>
References: <20241108195511.1338147-1-ezra@easyb.ch>
 <ae457b1c-82a6-41b2-a001-be0a2b2389c9@gmail.com>
In-Reply-To: <ae457b1c-82a6-41b2-a001-be0a2b2389c9@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
OC8xMS8yMDI0IDIxOjU1LCBFenJhIEJ1ZWhsZXIgd3JvdGU6DQo+ID4gRnJvbTogRXpyYSBCdWVo
bGVyIDxlenJhLmJ1ZWhsZXJAaHVzcXZhcm5hZ3JvdXAuY29tPg0KPiA+DQo+ID4gVGhpcyBoYXMg
YmVlbiB0ZXN0ZWQgb24gdGhlIEFUOTFTQU05RzI1LWJhc2VkIEdBUkRFTkEgc21hcnQgR2F0ZXdh
eQ0KPiA+IHdoaWNoIHVzZXMgYW4gUlRMODE4OENVUyAocHJvZHVjdCBJRCAweDgxNzYpLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogRXpyYSBCdWVobGVyIDxlenJhLmJ1ZWhsZXJAaHVzcXZhcm5h
Z3JvdXAuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gTm90ZSB0aGF0IEkgd2FzIG5vdCBhYmxlIHRv
IGZpZ3VyZSBvdXQgaG93IG1hbnkgY2xpZW50cyB0aGUgUlRMODE5MkNVDQo+ID4gYW5kIHNpbWls
YXIgY2FuIGFjdHVhbGx5IGhhbmRsZSwgMTI3IGlzIGEgd2lsZCBndWVzcy4NCj4gPg0KPiANCj4g
SSBsb29rZWQgaW50byB0aGF0IG9uY2UgYW5kIGZvdW5kIHRoYXQgdGhlIG9sZCA4MTkyY3UgYW5k
IDg3MjNhdQ0KPiBkcml2ZXJzIGhhdmUgYSBsaW1pdCBvZiAzMiBtYWNpZHMuDQo+IA0KPiBydGw4
eHh4dV9maWxsX3R4ZGVzY192MSgpIGFuZCBydGw4eHh4dV91cGRhdGVfcmF0ZV9tYXNrKCkgc2hv
dWxkDQo+IGZpbGwgdGhlIG1hY2lkIGZvciBBUCBtb2RlIHRvIHdvcmsgd2VsbC4gT3RoZXJ3aXNl
IHRoZSBmaXJtd2FyZQ0KPiB3aWxsIG5vdCB1c2UgdGhlIHJpZ2h0IFRYIHJhdGVzIGZvciBlYWNo
IGNvbm5lY3RlZCBjbGllbnQuIEl0IGdvZXMNCj4gaW4gdGhlIGxvd2VzdCA1IGJpdHMgb2YgdHhf
ZGVzYy0+dHhkdzEgYW5kIGgyYy5yYW1hc2suYXJnLg0KPiANCj4gSSB0cmllZCBBUCBtb2RlIGlu
IEp1bHkgMjAyMyBhbmQgZm91bmQgdGhhdCB0aGUgVFggc3BlZWQgd2FzIGxlc3MNCj4gdGhhbiAx
MCBtZWdhYml0cy9zZWNvbmQuIEluIHN0YXRpb24gbW9kZSBpdCB3YXMgYXQgbGVhc3QgNDAuDQo+
IEkgZGlkbid0IGludmVzdGlnYXRlIG1vcmUuIEhvdyBpcyB0aGUgc3BlZWQgZm9yIHlvdT8NCg0K
SSBhbHNvIHdhbnQgdG8ga25vdyB0aGUgdGVzdCByZXN1bHQuIFBsZWFzZSBtZW50aW9uIHRoYXQg
aW4gY29tbWl0DQptZXNzYWdlIGFzIHdlbGwuIA0KDQo+IA0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvODE5MmMuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvODE5MmMuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsOHh4eHUvODE5MmMuYw0KPiA+IGluZGV4IDBhYmIxYjA5MmJjMjAuLjcy
OTE4ZmU2MjFmYTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydGw4eHh4dS84MTkyYy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydGw4eHh4dS84MTkyYy5jDQo+ID4gQEAgLTY0NCw2ICs2NDQsOCBAQCBzdHJ1Y3QgcnRsOHh4
eHVfZmlsZW9wcyBydGw4MTkyY3VfZm9wcyA9IHsNCj4gPiAgICAgICAucnhfYWdnX2J1Zl9zaXpl
ID0gMTYwMDAsDQo+ID4gICAgICAgLnR4X2Rlc2Nfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgcnRsOHh4
eHVfdHhkZXNjMzIpLA0KPiA+ICAgICAgIC5yeF9kZXNjX3NpemUgPSBzaXplb2Yoc3RydWN0IHJ0
bDh4eHh1X3J4ZGVzYzE2KSwNCj4gPiArICAgICAuc3VwcG9ydHNfYXAgPSAxLA0KPiA+ICsgICAg
IC5tYXhfbWFjaWRfbnVtID0gMTI4LA0KDQpBcyBCaXR0ZXJibHVlIG1lbnRpb25lZCwgdGhpcyBz
aG91bGQgYmUgMzIuIA0KDQo+ID4gICAgICAgLm1heF9zZWNfY2FtX251bSA9IDMyLA0KPiA+ICAg
ICAgIC5hZGRhXzF0X2luaXQgPSAweDBiMWIyNWEwLA0KPiA+ICAgICAgIC5hZGRhXzF0X3BhdGhf
b24gPSAweDBiZGIyNWEwLA0KPiA+IC0tDQo+ID4gMi40My4wDQoNCg==

