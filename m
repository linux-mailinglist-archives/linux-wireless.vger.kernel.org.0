Return-Path: <linux-wireless+bounces-19788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC89DA4F32E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 02:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A5F188CA38
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A91738DE3;
	Wed,  5 Mar 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="N/vhsiU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C61E50B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136467; cv=none; b=NsWaYnJhpFqXNQ/NA7ovsNvj07uHKyfAYgcb0JrXCBL6CL9cSElOuTtK3mfks6tDv/E/WgBvIzPsFFW2jEj9f5MeZpVhYW4iH0dVq8B6ZUL9LnQ2SFk61IoeImAdqeUEc/d1paJFTyLxV42lovRLVuBqiJhst4+o7rvUIY41eQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136467; c=relaxed/simple;
	bh=Qo25UDrkCgktUR5jsmUVMvq8f6x1jU9FQTWm1UZ4EUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTytOGhSEJa9ng8RxLKUNjk5fvkWKW8uyJjKLkIVw59iixNWeeq43eh5ObujB5wfusOVRvoI9hdXKAucEOJ3aaAofk+rbc2Sv7Q6DQOKJvG3/CBqG2+5wgw/BZpYZPN9TEAa/o4oL9lhAK63rESIPJ6OombALwT2nTUDuBlDR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=N/vhsiU1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 525109bD4597793, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741136410; bh=Qo25UDrkCgktUR5jsmUVMvq8f6x1jU9FQTWm1UZ4EUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=N/vhsiU1R1u5Ntmqbpi+DK36ai+RIiy7U55m0yqpiJHHaT/wCE2mqpMlVeVFOzodJ
	 T48xP2B+Ke/O6GcY/s7Nyfu7pGfnkEN1EX6i15hoTcCtfk5JhObc2iPIIpHT68Oc7Z
	 Q83+c9fNLD0BG0XIvVjEqoeXbYZfXI6amfK68lcDrfO//7auxsQ9z4dC0G/KAdUMs8
	 1ZR/PWhxWyko3K7IF2QiQuZnVrdkSUSE/FHxUoQor7HcGVFvRYwqB2gWGVNuC/movs
	 06UmdqDb1vCyP45zmaYxr/RGxCbQ9uTFpjMT6AsviG3nDZM6IhmwqK+hIzIBifc9Nw
	 o61gNX6qPUu3g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 525109bD4597793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 09:00:10 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 09:00:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 5 Mar 2025 09:00:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 5 Mar 2025 09:00:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
        =?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
        Sean
 Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?=
	<Leon.Yen@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
Thread-Topic: [PATCH v2 1/6] wifi: mt76: mt7925: load the appropriate CLC data
 based on hardware type
Thread-Index: AQHbjM7UNOPbi6v4JUCOaZmi+hVXCbNip7ew//+Kx4CAAYVU4A==
Date: Wed, 5 Mar 2025 01:00:08 +0000
Message-ID: <3a874973725a4368885e3eafeea3479e@realtek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
	 <4d4e50e6b76e46d5b949701316889ee6@realtek.com>
 <c3fcef13b2c626be49cf160e53fc93fcfe8af9b8.camel@mediatek.com>
In-Reply-To: <c3fcef13b2c626be49cf160e53fc93fcfe8af9b8.camel@mediatek.com>
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

PiA+ID4gKyAgICAgICBzdHJ1Y3QgZXZ0IHsNCj4gPiA+ICsgICAgICAgICAgICAgICB1OCByc3Zb
NF07DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgICAgX19sZTE2IHRhZzsNCj4gPiA+ICsg
ICAgICAgICAgICAgICBfX2xlMTYgbGVuOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAg
IF9fbGUzMiB2ZXI7DQo+ID4gPiArICAgICAgICAgICAgICAgX19sZTMyIGFkZHI7DQo+ID4gPiAr
ICAgICAgICAgICAgICAgX19sZTMyIHZhbGlkOw0KPiA+ID4gKyAgICAgICAgICAgICAgIF9fbGUz
MiBzaXplOw0KPiA+ID4gKyAgICAgICAgICAgICAgIF9fbGUzMiBtYWdpY19udW07DQo+ID4gPiAr
ICAgICAgICAgICAgICAgX19sZTMyIHR5cGU7DQo+ID4gPiArICAgICAgICAgICAgICAgX19sZTMy
IHJzdjFbNF07DQo+ID4gPiArICAgICAgICAgICAgICAgdTggZGF0YVszMl07DQo+ID4gPiArICAg
ICAgIH0gX19wYWNrZWQgKiByZXM7DQo+ID4gDQo+ID4gbml0OiBubyBuZWVkIHNwYWNlIGJldHdl
ZW4gKiBhbmQgcmVzLCBpLmUuICJfX3BhY2tlZCAqcmVzIi4NCj4gPiANCj4gSGkgUGluZy1LZSwN
Cj4gDQo+IEkgYWxzbyB0aGluayB0aGlzIGlzIGJldHRlciwgYnV0IHRoaXMgd2FzIHN1Z2dlc3Rl
ZCB0byBtZSBieQ0KPiBzY3JpcHQvY2hlY2twYXRjaC5wbC4NCj4NCg0KY2hlY2twYXRjaCBzYXlz
ICJDSEVDSzpTUEFDSU5HOiBzcGFjZXMgcHJlZmVycmVkIGFyb3VuZCB0aGF0ICcqJyIgZm9yIHRo
aXMNCmNhc2UsIGJlY2F1c2UgaXQgdHJlYXRzIGFzIGEgYmluYXJ5IG9wZXJhdG9yLCBzbyB0aGlz
IGlzIGEgZmFsc2UgYWxhcm0uIA0KDQpCeSB0aGUgd2F5LCAiZ2l0IGdyZXAgIl9fcGFja2VkIFwq
ICIgZHJpdmVycy9uZXQvd2lyZWxlc3MvIiBjYW4gc2VlIG1hbnkNCnNpbWlsYXIgaW5zdGFuY2Vz
IEkgZ3Vlc3MgdGhleSBhcmUgYWxzbyBzdWdnZXN0ZWQgYnkgY2hlY2twYXRjaC4gDQoNCg0K

