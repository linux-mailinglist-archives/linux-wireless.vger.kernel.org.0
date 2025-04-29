Return-Path: <linux-wireless+bounces-22160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A7A9FEB5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 03:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A93ABA55
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB835947;
	Tue, 29 Apr 2025 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="lUt7UG9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94C70813
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888621; cv=none; b=rigl+4E7llIJG3FrCIlsU7batR23CRy09ZHcGcDSWnpJdC3fm6YV/mOltRb6NWqk0ZmZmkWEHJPvf949za8opiezsJTZwO3h2ZbrfcHYlSETU/5o/0sGxVXndLHnuhcqM5ei/PSiKf5bPEuZcsT83e//mRKi/31gCtLTwEKDl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888621; c=relaxed/simple;
	bh=A9HOU/6uWbi8j4G2F9oaL/WCYO/xCIRDH+BkUJ0hNOQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=osvwU+oKFvJ//Of3P3ydhnGFYi/bD+ZH5xlLT28MG6bNjBJxOUsk4Il7NShnBcpI+Fs2u+MRlKlYkfiQyGyLipe9jqu9/hJ65tS02J+U4Hn+Gn66aPmD59+JPtSZAipj3r7HwhyDC63fcgbjSROYNX6BlSIbm1A0whmG1dSbgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=lUt7UG9/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T13WCT03779900, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745888612; bh=A9HOU/6uWbi8j4G2F9oaL/WCYO/xCIRDH+BkUJ0hNOQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lUt7UG9/uGEv9hV/bdYoMQ58FoS3IVtM3SubLQAZjWylW5GT6BDbglCIkwko105bh
	 Ow+0oSf4t77v1pRtwciO7F3tLzN5UzHE1PCuSxQiwUBItIfJ2YntabPOYk8PJPj8YE
	 PG6vhMiurHPeRlSr1NGiA/mUFH4NNJ6f7h8dQLoA+AVnlhw3GcIr7sjoF7dgx16Rt2
	 Lrjilcl8h1Odjz/p7zpTZwCx57GidEwG0ZOBKZTbOKMMnBiUfH6cJea610yhhn8bT7
	 GdM3r0mgVbTsGsANTtCOhJvRLytlisnzGRstzM1cFGu0Z1EB7fyemO8f3KbJeUFrKJ
	 Zst/YP+Lsw52w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T13WCT03779900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 09:03:32 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 09:03:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 09:03:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 09:03:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw88: Fix RX aggregation settings for RTL8723DS
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw88: Fix RX aggregation settings
 for RTL8723DS
Thread-Index: AQHbuIQ+oGMfiSQ/xkabnAYQhdq7nbO5yTHA
Date: Tue, 29 Apr 2025 01:03:32 +0000
Message-ID: <0e9badc047ee4bbcb4256a0bcfd1c611@realtek.com>
References: <24dacc36-cfc2-475a-8bc5-aad04cd97aa3@gmail.com>
In-Reply-To: <24dacc36-cfc2-475a-8bc5-aad04cd97aa3@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVc2Ug
dGhlIHNhbWUgUlggYWdncmVnYXRpb24gc2l6ZSBhbmQgdGltZW91dCB1c2VkIGJ5IHRoZSBvdXQt
b2YtdHJlZQ0KPiBSVEw4NzIzRFMgZHJpdmVyLiBBbHNvIHNldCBteXN0ZXJ5IGJpdCAzMSBvZiBS
RUdfUlhETUFfQUdHX1BHX1RILiBUaGlzDQo+IGltcHJvdmVzIHRoZSBSWCBzcGVlZCBmcm9tIH40
NCBNYnBzIHRvIH42NyBNYnBzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9zZGlvLmMgfCAxMiArKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMNCj4gaW5kZXggYzU3ZjY4M2Q5YWY4Li42ZjYz
ZmQ1ZGI2NjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvc2Rpby5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rp
by5jDQo+IEBAIC02NzcsMTIgKzY3NywyMCBAQCBzdGF0aWMgdm9pZCBydHdfc2Rpb19lbmFibGVf
cnhfYWdncmVnYXRpb24oc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4gIHsNCj4gICAgICAgICB1
OCBzaXplLCB0aW1lb3V0Ow0KPiANCj4gLSAgICAgICBpZiAocnR3X2NoaXBfd2NwdV8xMW4ocnR3
ZGV2KSkgew0KDQpPcmlnaW5hbGx5IHRoaXMgb25seSBhZmZlY3RzIDExbiBjaGlwcywgYnV0IG5v
dyBpdCBhZmZlY3RzIGFsbCBjaGlwcyBieQ0KZGVmYXVsdCBjYXNlLiBJcyB0aGF0IGluIHlvdXIg
ZXhwZWN0YXRpb24/IA0KDQpBbmQgaGF2ZSB5b3UgdGVzdGVkIGNoaXBzIG90aGVyIHRoYW4gUlRM
ODcyM0RTIHlvdSBtZW50aW9uZWQgaW4gY29tbWl0DQptZXNzYWdlLiBJZiBzbywgcGxlYXNlIGFk
ZCB0aGVtIHRvIGNvbW1pdCBtZXNzYWdlLiANCg0KPiArICAgICAgIHN3aXRjaCAocnR3ZGV2LT5j
aGlwLT5pZCkgew0KPiArICAgICAgIGNhc2UgUlRXX0NISVBfVFlQRV84NzAzQjoNCj4gICAgICAg
ICAgICAgICAgIHNpemUgPSAweDY7DQo+ICAgICAgICAgICAgICAgICB0aW1lb3V0ID0gMHg2Ow0K
PiAtICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICBj
YXNlIFJUV19DSElQX1RZUEVfODcyM0Q6DQo+ICsgICAgICAgICAgICAgICBzaXplID0gMHhhOw0K
PiArICAgICAgICAgICAgICAgdGltZW91dCA9IDB4MzsNCj4gKyAgICAgICAgICAgICAgIHJ0d193
cml0ZThfc2V0KHJ0d2RldiwgUkVHX1JYRE1BX0FHR19QR19USCArIDMsIEJJVCg3KSk7DQo+ICsg
ICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgICAg
ICAgc2l6ZSA9IDB4ZmY7DQo+ICAgICAgICAgICAgICAgICB0aW1lb3V0ID0gMHgxOw0KPiArICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICAvKiBNYWtlIHRo
ZSBmaXJtd2FyZSBob25vciB0aGUgc2l6ZSBsaW1pdCBjb25maWd1cmVkIGJlbG93ICovDQo+IC0t
DQo+IDIuNDkuMA0KDQo=

