Return-Path: <linux-wireless+bounces-24509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C007EAE937E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAD73B4E18
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04761898F8;
	Thu, 26 Jun 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="acYyXAlM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8A1865EE;
	Thu, 26 Jun 2025 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899001; cv=none; b=Mj2U7FMidZv6PwUR9GgPBGJx/rrZeOj2IiBe8e3wXXtzypX7nQ7zy+XUdwpeHBNu+4qyYEH/nYhldJ6KUNGy9xDXnzerjz81ZTFqA+MGH+Z6qSZdtmcWR4jBRkrc5uOIxKNkyOtpAz850qUVI77TtbW0SBvNtWr/ERjJAkMx4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899001; c=relaxed/simple;
	bh=Bo5FHloweNSokzn5EvfAU3Bo7mFb8ssXwg8f72Dyfv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sy2+N9RmxSWts6RtS7fN/UsHmmlBK6tNeeDqxDcDSMLF/YXnfpe3DGyHL1WdDtbeAG9XouZo+xKx9rXbhui4wo5zMYSIUTbmz76FmRzwVk/Mu/sRvGDrKtiu/aY/PC7zzVecPlyWEaKR1egD7VdvhpyhH65KXHICXiFCFvzuVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=acYyXAlM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55Q0nsWkB2166693, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750898994; bh=Bo5FHloweNSokzn5EvfAU3Bo7mFb8ssXwg8f72Dyfv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=acYyXAlMb6rn9N+HwbVv3Lwb3EXFO7ycIuQB9fsI7jggKPd6TeDjhqXild9HzHErU
	 7DEf4wEqVqzEqLHNYsmk+j6toBBdGSj62N+/QM1XF30cY9sxKqR75iQGvj6Gy6uVbw
	 ipj4ef7kAc+pVvy5aPCXQIas1F1UDF8s3cIVfviEE11zHIIq7mOGrqilfIUx1zLeeK
	 b7u78jGJXDS66lVzCZaUZQDkrjW6gwzHXWkhKCiz0pMY45vgXqBRnTTqY2AVGMAMxD
	 eb5vGbwDbOTiXnvRCMUGm+o8WItPkXbOFgr24LeuG9vXvbZGEWYf99Pfc5+rtUbKkZ
	 sjtvZZjbSbf9A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55Q0nsWkB2166693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 08:49:54 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 08:50:10 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 26 Jun 2025 08:50:10 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Thu, 26 Jun 2025 08:50:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bitterblue
 Smith <rtl8821cerfe2@gmail.com>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Thread-Topic: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Thread-Index: AQHb5d0W/5wnIWjHA0qqxnL0mtReEbQTgt4AgAA+LQCAAFWlgA==
Date: Thu, 26 Jun 2025 00:50:09 +0000
Message-ID: <e19a2b92ff384ac8987f4bedd63bcd91@realtek.com>
References: <20250625142541.44795-1-yakoyoku@gmail.com>
 <bde434a6-68b8-4c5f-8ec0-6c41dd1b6558@gmail.com>
 <13830882.uLZWGnKmhe@tx3000mach.io>
In-Reply-To: <13830882.uLZWGnKmhe@tx3000mach.io>
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

TWFydGluIFJvZHJpZ3VleiBSZWJvcmVkbyA8eWFrb3lva3VAZ21haWwuY29tPiB3cm90ZToNCj4g
T24gV2VkbmVzZGF5IDI1IEp1bmUgMjAyNSAxMzowMTowNCBBcmdlbnRpbmEgU3RhbmRhcmQgVGlt
ZSBCaXR0ZXJibHVlIFNtaXRoDQo+IHdyb3RlOg0KPiA+IE9uIDI1LzA2LzIwMjUgMTc6MjUsIE1h
cnRpbiBSb2RyaWd1ZXogUmVib3JlZG8gd3JvdGU6DQo+ID4gWy4uLl0NCj4gPj4gQXMgb2Ygbm93
IG9ubHkgcnRsODE5MmV4IGRldmljZXMgaGF2ZSB0aGVpciBQMlBfQ0xJRU5UIGFuZCBQMlBfR08g
d2lwaHkNCj4gPj4gaW50ZXJmYWNlIG1vZGVzIGVuc3VyZWQgYmVjYXVzZSB0aG9zZSBhcmUgdGhl
IG9ubHkgb25lcyBJIGNhbiB0ZXN0IG9uDQo+ID4+IG15IHJ0bDgxOTJldSBjYXJkLiBUaGUgcmVz
dCBvZiBjaGlwcyBoYXZlIHRoZW0gc2V0IGZyb20gd2hhdCBJJ3ZlIHNlZW4NCj4gPj4gaW4gYSBj
dXJzb3J5IEludGVybmV0IHNlYXJjaCwgdGhleSBtaWdodCBvciBtaWdodCBub3Qgd29yay4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFJvZHJpZ3VleiBSZWJvcmVkbyA8eWFrb3lv
a3VAZ21haWwuY29tPg0KPiA+DQo+ID4gU28uLi4gZG9lcyBpdCB3b3JrIHdpdGggeW91ciBjaGlw
PyBIb3cgZG8gd2UgdGVzdD8NCj4gDQo+IFlvdSBjYW4gdGVzdCB0aGlzIGZlYXR1cmUgd2l0aCBH
Tk9NRSBOZXR3b3JrIERpc3BsYXlzLCB0aGF0J3MgdGhlIG9ubHkNCj4gdXNlcnNwYWNlIGFwcGxp
Y2F0aW9uIEkgY2FuIHRoaW5rIG9mLiBLREUgZG9lc24ndCBvZmZlciBhbnl0aGluZyB5ZXQgYW5k
DQo+IHRoZXJlJ3Mgbm8gb3RoZXIgc29mdHdhcmUgb3V0IHRoZXJlIHRoYXQgdXNlcyBXaUZpIFAy
UCwgbm90IGV2ZW4gZm9yIHNpbXBsZQ0KPiBmaWxlIHRyYW5zZmVycy4gTWF5YmUgdXRpbHMgY291
bGQgYmUgd3JpdHRlbiBsaWtlIHdoYXQgd2FzIGRvbmUgZm9yIEJsdWV6IGFuZA0KPiBiZSBwYXJ0
IG9mIGEga25vd24gcGFja2FnZSBsaWtlIE5ldHdvcmtNYW5hZ2VyIG9yIGEgdGhpbmcgYnkgdGhl
bXNlbHZlcy4NCj4gDQo+IFdpdGggcmVzcGVjdCB0byBteSBjYXNlIEkgc2F5IGl0J3MgbGlzdGVk
IGJ5IHdwYV9jbGkgYW5kIGl0IGdldHMgZGV0ZWN0ZWQgYnkNCj4gTmV0d29yayBEaXNwbGF5cywg
YnV0IEkgY2Fubm90IGRvIGFueXRoaW5nIGZ1cnRoZXIgdGhhbiB0aGF0Lg0KDQpJZiB5b3UgaGF2
ZSB0d28gUEMsIHVzZSAncDJwX2ZpbmQnIGFuZCAncDJwX2Nvbm5lY3QnIGNvbW1hbmRzIHRvIG1h
a2UNCmEgcDJwIGNvbm5lY3Rpb24uIA0KDQo+IEJlY2F1c2UgSSBkb24ndA0KPiBrbm93IGhvdyB0
byB1c2Ugd3BhJ3MgdXRpbGl0eSBwcm9wZXJseSBhbmQgd2hpbGUgSSB0cnkgdG8gc2hhcmUgbXkg
c2NyZWVuIG9yDQo+IHNlZSBhbm90aGVyIG9uZSwgSSBnZXQgbm8gZGljZSB0aGVyZS4gDQoNCldp
RmkgRGlzcGxheSwgd2hpY2ggaXMgYSBwcm90b2NvbCBvdmVyIFdpRmkgUDJQLCBpcyB1c2VkIHRv
IHNoYXJlIHNjcmVlbi4NCklJUkMgaXQgdXNlcyBSVFNQIHByb3RvY29sIHRvIGhhbmRzaGFrZSBS
VFAgZm9yIHN0cmVhbWluZy4gV2l0aG91dCBhIHV0aWxpdHkNCihJIGRvbid0IHJlbWVtYmVyIHRo
YXQgdGhvdWdoKSwgaXQgaXMgbm90IHBvc3NpYmxlIHRvIHNldHVwIGEgc3RyZWFtaW5nDQpzZXNz
aW9uLg0KDQo+IE1heWJlIHRoaXMgaXMgZHVlIHRvIGFuIGluY29tcGF0aWJpbGl0eQ0KPiB3aXRo
IG15IFNhbXN1bmcgbW9iaWxlIG9yIHRoYXQgZm9yIHByb3BlciBQMlAgc3VwcG9ydCBtb3JlIGZ1
bmN0aW9uYWxpdGllcw0KPiBuZWVkIHRvIGJlIGFkZGVkIHRvIHJ0bDh4eHh1LCBJIGNhbiBzYXkg
dGhhdCBhcyBvZiBub3cuDQoNCkkgdGhpbmsgd2hhdCB3ZSBjYW4gZG8gaW4gYSBQQyBpcyB0byBz
ZXR1cCBhIFAyUCBjb25uZWN0aW9uICh3aXRoIGFuIGFuZHJvaWQNCnBob25lIGlzIHBvc3NpYmxl
KSwgYW5kIHRlc3QgcGluZyBvciB0cmFuc2ZlciBhIGZpbGUgdmlhIEZUUCBhbmQgc28gb24uIA0K
DQo=

