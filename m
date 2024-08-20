Return-Path: <linux-wireless+bounces-11646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3811E957A84
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 02:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21EF1F2276A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 00:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554C15AF6;
	Tue, 20 Aug 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kpStQk+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30D15AC4
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114116; cv=none; b=Pmab7IhZuW8qWEG8a3Kwkdq/Im6Tc7v02Yaf+wEl4GLMvcSbgZWIaYtEulcu9LkkG0vHPW9CHQzJqcSBU8VmxVnxU8HO7UoICP0r6A0rFRSmEuNQzXTOuOlj3fydOExWO6bHY+fCr3+urS28T0c6yuv1dMuvrr96P8EuDVBXNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114116; c=relaxed/simple;
	bh=wSPxWDepXBvjpV6qbFjqFZX6mHk2AURdgXrnTuMB3Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qyhCsXR3XQIgM1lmxbIqR+OcbLsEqWHVMANB0D66YFnJEHzKFyIyJcepYajs89ZvyxTcQkyW2Z5JxO/boMMyInR3oY+6Vxdg6W7+Okb52jz0Q+7BWja+qbdj8jYh0G/UAmkf1AJ6cTxswnTrat5bUjIuMcNAhsajgy2q2ChUdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kpStQk+9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47K0YkPpA731866, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724114086; bh=wSPxWDepXBvjpV6qbFjqFZX6mHk2AURdgXrnTuMB3Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kpStQk+9EqGJNy7mL1uRP9t3FEo3m7jHb0vuUZWoZc4STFvFBQ7wjV4RdbJA4Itcq
	 WAmBnr+54VkUQy8M45p2lGxbE6cXdsHsGFewip7Jn/iNgerZbh5VacKgnnwdvHnuZF
	 uBx14CO8DCLpaEdw82ZBFR12V1omT6qotoNuXFNzBwkyraGTsu28Q1KOYq2oK3pXZi
	 5EPtzKn2uuEpta2sg/dunfrwBcWFNUAqCggdJbZzAtD+PXMtsD8e+0RvdhCy9WWv4o
	 LfsOFrk+RTR1OgPCA5Av2AyHD1lTP4sFMMDxNhjQ37AgNjGnzR3a/aksBa0FSxvvrU
	 Jpsd14aat9tVQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47K0YkPpA731866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 08:34:46 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 08:34:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Aug 2024 08:34:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 20 Aug 2024 08:34:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Topic: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Index: AQHa4UC4lZ9xsp59ME2YErnRO2fzALIO0JLQ///mdQCAAUpa0IAAPgYAgAxlZgCAEV8d8IAArrkAgAC5ygA=
Date: Tue, 20 Aug 2024 00:34:46 +0000
Message-ID: <3e2d32e473204471af1814aa2ce26bcb@realtek.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
 <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
 <d21bc7a0fac8413b9cc443288924ec7b@realtek.com>
 <91d03fa7-5af0-4ec5-a52c-c2c060e11d4d@gmail.com>
 <6d1667d2-c86f-4b80-bb32-9ba01164480b@maciej.szmigiero.name>
 <e8d3c81a47de44e1ba7df08b9de826ee@realtek.com>
 <1377b2e9-4da2-45cb-86f5-5b80fe5ab025@maciej.szmigiero.name>
In-Reply-To: <1377b2e9-4da2-45cb-86f5-5b80fe5ab025@maciej.szmigiero.name>
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

SGkgQml0dGVyYmx1ZSwNCg0KTWFjaWVqIFMuIFN6bWlnaWVybyA8bWFpbEBtYWNpZWouc3ptaWdp
ZXJvLm5hbWU+IHdyb3RlOg0KPiBJIHRlc3RlZCB0aGVzZSBwYXRjaGVzIG9uIFVTQiBSVEw4ODIx
Q1UgYW5kIGNhbiBjb25maXJtIHRoYXQgdGhlIEFQIG1vZGUgc2VlbXMgdG8NCj4gd29yayBhcyBn
b29kIHdpdGggeW91ciBwYXRjaCBbMl0gYXMgaXQgZGlkIHdpdGggdGhlIEJpdHRlcmJsdWUncyBv
bmUuDQo+IA0KPiBUaGUgb25seSBpc3N1ZSB3aXRoIGVpdGhlciB5b3VyIG9yIEJpdHRlcmJsdWUn
cyBwYXRjaGVzIGlzIHRoYXQgSSBvY2Nhc2lvbmFsbHkgZ2V0IHRoZQ0KPiBmb2xsb3dpbmcgbWVz
c2FnZXMgaW4gdGhlIGtlcm5lbCBsb2cgaW4gdGhlIEFQIG1vZGU6DQo+ID4ga2VybmVsOiBbVDEy
MzRdIHJ0d184ODIxY3UgNC0xLjI6MS4yOiBlcnJvciBiZWFjb24gdmFsaWQNCj4gPiBrZXJuZWw6
IFtUMTIzNF0gcnR3Xzg4MjFjdSA0LTEuMjoxLjI6IGZhaWxlZCB0byBkb3dubG9hZCBkcnYgcnN2
ZCBwYWdlDQo+ID4ga2VybmVsOiBbVDEyMzRdIHJ0d184ODIxY3UgNC0xLjI6MS4yOiBmYWlsZWQg
dG8gZG93bmxvYWQgYmVhY29uDQo+IA0KPiBBcm91bmQgdGhlIHRpbWUgdGhlc2UgbWVzc2FnZXMg
YXJlIGxvZ2dlZCBwaW5nIFJUVCBvZiBhIGNvbm5lY3RlZCAoYmF0dGVyeSBwb3dlcmVkKQ0KPiBT
VEEgY2xpbWJzIGludG8gbXVsdGlwbGUgc2Vjb25kcyByYW5nZSBzbyBJIGd1ZXNzIHRoZXJlIG1p
Z2h0IGJlIHNvbWV0aGluZyB3cm9uZw0KPiB3aXRoIGJlYWNvbiBEVElNIHVwZGF0ZSBoZXJlLg0K
DQpDYW4geW91IGFsc28gc2VlIHRoaXMgaW4geW91ciBzaWRlPyBJdCBzZWVtcyBsaWtlIGRvd25s
b2FkIGJlYWNvbiBmb3IgY2hhbmdlIG9mIERUSU0NCm1pZ2h0IGJlIGZhaWxlZCBvY2Nhc2lvbmFs
bHkuIA0KDQpQaW5nLUtlDQoNCg==

