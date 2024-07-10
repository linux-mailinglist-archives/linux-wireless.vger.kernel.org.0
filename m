Return-Path: <linux-wireless+bounces-10139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC192C7AB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 02:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3B71F239FC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 00:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFFA5F;
	Wed, 10 Jul 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AA22ONUp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5AA32
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571731; cv=none; b=KlgcNnpnd4a6A4tko1St2tU9STlMD6BO7AUKv600HtqG3XUv67ta0kgcHB+lWlNqjoLHmb1yqF1VSz/0Tddd8QtL62QJlGDvBoz5euGuE2JKUn6YdCrAFsVGixsQKIVylgTCb+A6szQUHMZBwvaRLl0k/4F6VOigTfs/K9dPbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571731; c=relaxed/simple;
	bh=PH2aHRkDUZxhjdcdkSdJnPti9z5f3MIX+f+g0/bloLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MsqIKO5yVvCdwRBM4a0d9IXAATKaKYv1YJn4BiHew8aMgOi7Jn3padTw+r6zsEQ+mFMcX5VYj1CrCLUXvyM9xqnhLLDlxQlHYwvCl76FqBCG2APOR3NF+SCgsXmz6VwJJdAPq/efTyj9rz/uFaRM0Nu+9tu3/mtogaiwYXZ5/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AA22ONUp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46A0ZBBT01369107, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720571711; bh=PH2aHRkDUZxhjdcdkSdJnPti9z5f3MIX+f+g0/bloLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AA22ONUpPYprkgoS/q9PLozq5NCAesPtHu4udL9Qt7CdUmLPUMN3JfL/mynF/pD/p
	 2cEVWBHGPXECQQgADArXx7kL6V5MbvBZN3PsdgU4JwbzKdmeAWXsaEgaev2hG/woJ2
	 6qSNNOXzPkAYAWSqOYfWLbwrWlKKqmi5o4kE1oYnsWfbCLMUPPng3fTIgVhvDD/AbI
	 +Yzh9cF/IPhuFyi3k1ZaMQh/nwqxCd4+MLKVPoTpD4svz0JF05qdWwxA9AmVFaTJpL
	 i3YuD6D+UEFofgKZGW1PpyIcfehNeNSFupZtOBSB5GhnezD6XjX5jX4wCCuhQJu5z+
	 PfKTr8koc7iOg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46A0ZBBT01369107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 08:35:11 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 08:35:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jul 2024 08:35:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 10 Jul 2024 08:35:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
Thread-Topic: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
Thread-Index: AQHazyw5zmbg866JN0qvS/PnzliO+bHsjRUA//+yX4CAAVWigIAAKP8AgAFlWSA=
Date: Wed, 10 Jul 2024 00:35:12 +0000
Message-ID: <be1a5fb9d18c46df8b8008eb483957a7@realtek.com>
References: <2378105e-041a-4973-937f-e3efdc9ce0e8@gmail.com>
 <a60a7a6d0ab04b3ab1690a2c473b8e69@realtek.com>
 <3f2900e7-9a98-4bc9-bc0d-631dd9de7da0@gmail.com>
 <57eec7c0f23b40059840086066ed74be@realtek.com>
 <d75cd47e-2619-4bb5-857d-0814e1c2cd1a@gmail.com>
In-Reply-To: <d75cd47e-2619-4bb5-857d-0814e1c2cd1a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
OS8wNy8yMDI0IDAzOjU1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAwOC8wNy8yMDI0IDEy
OjE5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4gQEAgLTg5Niw2ICs5NzIsMTQgQEAgaW50
IHJ0d191c2JfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmludGYsIGNvbnN0IHN0cnVjdCB1
c2JfZGV2aWNlX2lkICppZCkNCj4gPj4+PiAgICAgICAgICAgICAgICAgZ290byBlcnJfZGVzdHJv
eV9yeHdxOw0KPiA+Pj4+ICAgICAgICAgfQ0KPiA+Pj4+DQo+ID4+Pj4gKyAgICAgICByZXQgPSBy
dHdfdXNiX3N3aXRjaF9tb2RlKHJ0d2Rldik7DQo+ID4+Pj4gKyAgICAgICBpZiAocmV0KSB7DQo+
ID4+Pj4gKyAgICAgICAgICAgICAgIC8qIE5vdCBhIGZhaWwsIGJ1dCB3ZSBkbyBuZWVkIHRvIHNr
aXAgcnR3X3JlZ2lzdGVyX2h3LiAqLw0KPiA+Pj4+ICsgICAgICAgICAgICAgICBydHdfaW5mbyhy
dHdkZXYsICJzd2l0Y2hpbmcgdG8gVVNCIDMgbW9kZVxuIik7DQo+ID4+Pg0KPiA+Pj4gQWxsIGxv
Z3MgaW4gdGhpcyBwYXRjaGVzIHNob3VsZCBiZSBydHdfZGJnKCksIGJlY2F1c2UgdGhlc2UgbWVz
c2FnZXMgYXJlIG5vdA0KPiA+Pj4gaW1wb3J0YW50IHRvIHVzZXJzLg0KPiA+Pj4NCj4gPj4NCj4g
Pj4gT2theSwgSSB3aWxsIGFkZCBSVFdfREJHX1VTQiB0byBlbnVtIHJ0d19kZWJ1Z19tYXNrLg0K
PiA+Pg0KPiA+Pj4NCj4gPj4+PiArICAgICAgICAgICAgICAgcmV0ID0gMDsNCj4gPg0KPiA+IEkg
bWlzc2VkIHRoaXMgcG9pbnQgInJldCA9IDAiIHRoYXQgcnR3X3VzYl9kaXNjb25uZWN0KCkgd2ls
bCBiZSBjYWxsZWQgd2hlbg0KPiA+IFVTQiBkaXNjb25uZWN0LiBDYW4ndCB3ZSBqdXN0IHJldHVy
biBhbiBlcnJvciBjb2RlPyBhbnkgbmVnYXRpdmUgZWZmZWN0Pw0KPiA+DQo+ID4gTXkgcG9pbnQg
aXMgdG8gYXZvaWQgY2FsbGluZyBydHdfdXNiX2Rpc2Nvbm5lY3QoKSBmb3IgdGhlIGNhc2Ugb2Yg
c3dpdGNoaW5nDQo+ID4gVVNCIDMsIGJlY2F1c2UgYWxsIHN0dWZmcyBoYXZlIGJlZW4gZnJlZWQg
YnkgZm9sbG93aW5nIGVycm9yIGhhbmRsZXMuDQo+ID4NCj4gDQo+IElmIHdlIHJldHVybiBhbiBl
cnJvciBjb2RlIGluc3RlYWQgb2YgMCwgaXQgc3RpbGwgc3dpdGNoZXMNCj4gdG8gVVNCIDMsIGJ1
dCB3ZSBnZXQgYW4gZXJyb3IgbWVzc2FnZToNCj4gDQo+IEp1bCAwOSAxMzo0Nzo1NCBpZGVhcGFk
MiBrZXJuZWw6IHJ0d184ODEyYXUgMS00OjEuMDogcHJvYmUgd2l0aCBkcml2ZXIgcnR3Xzg4MTJh
dSBmYWlsZWQgd2l0aCBlcnJvciAxDQo+IA0KDQpHb3QgaXQuIExldCdzIHRha2UgeW91ciBtZXRo
b2QuDQoNCg0K

