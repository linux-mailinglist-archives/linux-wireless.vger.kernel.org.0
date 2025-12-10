Return-Path: <linux-wireless+bounces-29628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03373CB178A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 01:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECA473009774
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 00:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7FF13FEE;
	Wed, 10 Dec 2025 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RviNe3Eq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1A322A
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765325866; cv=none; b=fyddBe+mQh45exlcsciI4Y67dfn0dCk0GAweX/SW2wOTbeZ8Gii0cSLs04N98NBBPx2gq5cT5lA4aoDLtkfbeZ7fB68hf3FzZgsw6klVvGSFzDTdZnogIDrsHGlLMjRAxXI7cVh73e6qBBzky3d4hpS7D7kv6IrtsKQrCc6XE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765325866; c=relaxed/simple;
	bh=1NWBKIJN1yh9WBDSLi9UQT0mpowbM44ADr+RD2VDjxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JsZBe93MkVVJcsjrYiQKuPtFqn+14TgAESa+UnM/tmRp7ZZlKlvW1R3E9srWE4qkZp0iZmIaTFM1JfR9pTkn+tRvMfJuB0Db96euOANqoB9XkiYfhhcXHx6LGhAJuOGs3U/3q12JDmypSJ6AJmfqyVFqwsm26bGGsL6NiJ7lAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RviNe3Eq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BA0HaaA63100539, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765325856; bh=1NWBKIJN1yh9WBDSLi9UQT0mpowbM44ADr+RD2VDjxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RviNe3Eq/DHFq89bsUTsdWqTw2AhcYHVDDMXdH8h8Flf18i8dtMhp2J8dtNhWcKO5
	 7FieKWitWl5JNXj+6x5OtKX7IHRfh7qM9645O40AKzSSGJHvHiAurtiwvQDU8hm0If
	 dEtxpq46lUGIfw6OAme2AfXWHcQW0zHSybavBT8Gm6X/hVs2B+OCLpiZkjkMwtnM5v
	 JLTnp/ZGgC5gdguqh0vXeejcm7DtGVvi43knz2Z4dXRnmbebc/36EBMftI1awwqJIl
	 5ZUvEUogXAEtQSKM0trnnMAGglhZDaEDY898EVbdxjo7lUedIPyvMFj++9KmYMAfdI
	 AToFKMPikPanA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BA0HaaA63100539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 08:17:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 10 Dec 2025 08:17:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Wed, 10 Dec 2025 08:17:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Marco Crivellari <marco.crivellari@suse.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Topic: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Index: AQHcZt66JkU/0qBLKkWq0rXfVDO7QLUW53QQgAGo4oCAAXYo8A==
Date: Wed, 10 Dec 2025 00:17:36 +0000
Message-ID: <eaef2ed2c7814a5a8fcbea90cce88ea8@realtek.com>
References: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com>
 <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com>
 <CAAofZF4Z=O=q96RaTUKFpXiLGEYU84JB+oqfWtTc2njHGgC2Ww@mail.gmail.com>
In-Reply-To: <CAAofZF4Z=O=q96RaTUKFpXiLGEYU84JB+oqfWtTc2njHGgC2Ww@mail.gmail.com>
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

TWFyY28gQ3JpdmVsbGFyaSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4gd3JvdGU6DQo+IFNl
bnQ6IFR1ZXNkYXksIERlY2VtYmVyIDksIDIwMjUgNTo1NyBQTQ0KPiBydHc4OU9uIE1vbiwgRGVj
IDgsIDIwMjUgYXQgMTo0MOKAr0FNIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3
cm90ZToNCj4gPiBIaSBNYXJjbywNCj4gPg0KPiA+IFdpbGwgeW91IHNlbmQgYSBwYXRjaCB0byBw
b2ludCBvdXQgV1FfUEVSQ1BVIGV4cGxpY2l0bHk/DQo+ID4NCj4gPiA+ICsgICAgICAgcnR3dXNi
LT5yeHdxID0gYWxsb2Nfd29ya3F1ZXVlKCJydHc4OF91c2I6IHJ4IHdxIiwgV1FfQkgsIDApOw0K
PiA+ID4gICAgICAgICBpZiAoIXJ0d3VzYi0+cnh3cSkgew0KPiA+ID4gICAgICAgICAgICAgICAg
IHJ0d19lcnIocnR3ZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBSWCB3b3JrIHF1ZXVlXG4iKTsNCj4g
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+IEhpLA0KPiANCj4gVGhl
IHYxIGlzIGluZGVlZCBjb3JyZWN0LCBzb3JyeSBmb3IgdGhhdDogV1FfQkggc2hvdWxkIGJlIHBl
ci1jcHUNCj4gYmVjYXVzZSBpdCBpcyBleGVjdXRlZCBpbiBzb2Z0aXJxIGNvbnRleHQuDQo+IA0K
PiBTaG91bGQgSSBzZW5kIGEgcGF0Y2ggcHJlZml4ZWQgd2l0aCBbQlVHXSBpbiBvcmRlciB0byBm
aXggaXQgb3IgdGhlIHYxDQo+IGNvdWxkIGJlIHVzZWQgYW5kIHdlJ3JlIG9rPw0KDQpJIHRoaW5r
IHYxIGlzIG9rLCBzbyBJIHJlLW9wZW4gdjEgWzFdLCBhbmQgcGxhbiB0byBtZXJnZSB0aGlzIGlu
IC1uZXh0IGN5Y2xlLg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2xpbnV4LXdpcmVsZXNzL3BhdGNoLzIwMjUxMTEzMTYwNjA1LjM4MTc3Ny0zLW1hcmNvLmNyaXZl
bGxhcmlAc3VzZS5jb20vDQoNCj4gDQo+IEkgbm90aWNlZCBhbHNvIGluIDYuMTggInJ0dzg5X3Vz
Yl9pbml0X3J4IiBpcyBhbGxvY2F0aW5nIGEgd29ya3F1ZXVlDQo+IGFuZCBpcyBtaXNzaW5nIFdR
X1BFUkNQVS4NCg0KUGxlYXNlIHByZXBhcmUgYW5vdGhlciBwYXRjaCBmb3IgdGhpcy4NCg0KDQo=

