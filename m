Return-Path: <linux-wireless+bounces-11057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97865949EA8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 05:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5B41F2560D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151841DFCB;
	Wed,  7 Aug 2024 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GNR3CKY3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C91A269
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002607; cv=none; b=WCdeDLtiEjFuKeHwycXDTJG4n/duDUeTUys6c1mnvb5QIBXolECk59M/tSEE5ApvTOIggyeq1OhKJZ1o+8zEBaSFw1WQtu+pbZpZsoDkdNpi32KTo4z0xkxykpDEJrBgZYM7agzkruqMy2T5QfaS4q7mLQNkG2irU2204RE/kyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002607; c=relaxed/simple;
	bh=g4sAesE44ptlZzahUThH/LjQLGO2JDZYjvw5crL57PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UEHBzI0QS/wzxH9Z1HdHLJq0u9GPsCqBgFQH2BthL2hSvHwLiBEf2Hwbm10vDi69hi0uLeRq2eRPj6VSJWMNEOhYD0OY9zvZPAmeGennGt1m46gTYYf4YH80nqvutX34nEmz2GTuz9cz7q19J7R/neSJDQvgysAxJcnUiGjchs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GNR3CKY3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4773nv6D31928708, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723002597; bh=g4sAesE44ptlZzahUThH/LjQLGO2JDZYjvw5crL57PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GNR3CKY39bBWPBHl4+OE9l5aQZ+U/RlKzS/RGQc9V2Dlt24x/CYC6SoC0+uSTUv/p
	 PTqHhZGzVssI+SbBn7H83yaFDBRNGsfmj4hKRPRNs34guYXOWcRgNXjpnodD6jegvZ
	 +pvCb7NTfWocTygLDM6OH6fsyjbrDdFflPkJ6pnfVI8gJ6res/s+VigE9v9klVOEbX
	 OuxGMWv/Vkvm5fjlHi00MQa5fNvxEjiCSIwac83WVpm7Hct5/yBlKcGL6GybgDgiY/
	 PXaYioefqkb/XM7l+I/+KnBLyVs1lBAlY4E/8gmYHL83sqfVy2XKEfGTQtkhpIgKRG
	 7oB4oZLmOHmAA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4773nv6D31928708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 11:49:57 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 11:49:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Aug 2024 11:49:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 7 Aug 2024 11:49:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Peter Robinson <pbrobinson@gmail.com>, Fiona Klute <fiona.klute@gmx.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Crash when rmmod the rtw88_8723cs driver
Thread-Topic: Crash when rmmod the rtw88_8723cs driver
Thread-Index: AQHa5/mGuDMTKUQ1DESGncrxUJNzObIbKOQQ
Date: Wed, 7 Aug 2024 03:49:56 +0000
Message-ID: <910f590eea414eb985a4000536e21800@realtek.com>
References: <CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com>
In-Reply-To: <CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com>
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

SGkgUGV0ZXIsDQoNCj4gDQo+ICMgcm1tb2QgcnR3ODhfODcyM2NzIHJ0dzg4Xzg3MDNiIHJ0dzg4
Xzg3MjN4IHJ0dzg4X3NkaW8gcnR3ODhfY29yZQ0KPiBbIDM2OTguMDY3MzU0XSB3bGFuMDogZGVh
dXRoZW50aWNhdGluZyBmcm9tIGFhOmY1OmZkOjYwOjRjOmE4IGJ5IGxvY2FsDQo+IGNob2ljZSAo
UmVhc29uOiAzPURFQVVUSF9MRUFWSU5HKQ0KPiBbIDM2OTguMzAwOTM3XSAtLS0tLS0tLS0tLS1b
IGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAzNjk4LjMwNTk4N10gSGF2ZSBwZW5kaW5nIGFj
ayBmcmFtZXMhDQoNCkkgdGhpbmsgdGhhdCBpcyBiZWNhdXNlIFRYIHNrYiBpc24ndCBhY2tlZCB0
byBtYWM4MDIxMS4gUGxlYXNlIGFwcGx5IGJlbG93IA0KY2hhbmdlcyB0byBzZWUgaWYgaXQgY2Fu
IGZpeCB0aGUgcHJvYmxlbS4NCg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9zZGlvLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3NkaW8uYw0KaW5kZXggNzYzYWE4MjEyYTRiLi43YjFlYzViYTgwZTYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3NkaW8uYw0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMNCkBAIC0xMjk3LDcgKzEyOTcsNyBAQCBz
dGF0aWMgdm9pZCBydHdfc2Rpb19kZWluaXRfdHgoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCiAg
ICAgICAgaW50IGk7DQoNCiAgICAgICAgZm9yIChpID0gMDsgaSA8IFJUS19NQVhfVFhfUVVFVUVf
TlVNOyBpKyspDQotICAgICAgICAgICAgICAgc2tiX3F1ZXVlX3B1cmdlKCZydHdzZGlvLT50eF9x
dWV1ZVtpXSk7DQorICAgICAgICAgICAgICAgaWVlZTgwMjExX3B1cmdlX3R4X3F1ZXVlKHJ0d2Rl
di0+aHcsICZydHdzZGlvLT50eF9xdWV1ZVtpXSk7DQoNCiAgICAgICAgZmx1c2hfd29ya3F1ZXVl
KHJ0d3NkaW8tPnR4d3EpOw0KICAgICAgICBkZXN0cm95X3dvcmtxdWV1ZShydHdzZGlvLT50eHdx
KTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5j
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYw0KaW5kZXggOTE0NWMx
MWEwNjNlLi5lNmIyNDQxMzVjYTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L3VzYi5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3VzYi5jDQpAQCAtNDIzLDEwICs0MjMsMTEgQEAgc3RhdGljIHZvaWQgcnR3X3VzYl90eF9o
YW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCg0KIHN0YXRpYyB2b2lkIHJ0d191c2Jf
dHhfcXVldWVfcHVyZ2Uoc3RydWN0IHJ0d191c2IgKnJ0d3VzYikNCiB7DQorICAgICAgIHN0cnVj
dCBydHdfZGV2ICpydHdkZXYgPSBydHd1c2ItPnJ0d2RldjsNCiAgICAgICAgaW50IGk7DQoNCiAg
ICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocnR3dXNiLT50eF9xdWV1ZSk7IGkrKykN
Ci0gICAgICAgICAgICAgICBza2JfcXVldWVfcHVyZ2UoJnJ0d3VzYi0+dHhfcXVldWVbaV0pOw0K
KyAgICAgICAgICAgICAgIGllZWU4MDIxMV9wdXJnZV90eF9xdWV1ZShydHdkZXYtPmh3LCAmcnR3
dXNiLT50eF9xdWV1ZVtpXSk7DQogfQ0KDQogc3RhdGljIHZvaWQgcnR3X3VzYl93cml0ZV9wb3J0
X2NvbXBsZXRlKHN0cnVjdCB1cmIgKnVyYikNCmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9tYWM4
MDIxMS5oIGIvaW5jbHVkZS9uZXQvbWFjODAyMTEuaA0KaW5kZXggMGEwNGVhZjUzNDNjLi5mMTE4
NDRmMGM4MGYgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL25ldC9tYWM4MDIxMS5oDQorKysgYi9pbmNs
dWRlL25ldC9tYWM4MDIxMS5oDQpAQCAtMzE4MCw2ICszMTgwLDE3IEBAIGllZWU4MDIxMV9nZXRf
YWx0X3JldHJ5X3JhdGUoY29uc3Qgc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQogICovDQogdm9p
ZCBpZWVlODAyMTFfZnJlZV90eHNrYihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IHNr
X2J1ZmYgKnNrYik7DQoNCisvKioNCisgKiBpZWVlODAyMTFfcHVyZ2VfdHhfcXVldWUgLSBwdXJn
ZSBUWCBza2IgcXVldWUNCisgKiBAaHc6IHRoZSBoYXJkd2FyZQ0KKyAqIEBza2JzOiB0aGUgc2ti
cw0KKyAqDQorICogRnJlZSBhIHNldCBvZiB0cmFuc21pdCBza2JzLiBVc2UgdGhpcyBmdW5jdGlv
biB3aGVuIGRldmljZSBpcyBnb2luZyB0byBzdG9wDQorICogYnV0IHNvbWUgdHJhbnNtaXQgc2ti
cyB3aXRob3V0IFRYIHN0YXR1cyBhcmUgc3RpbGwgcXVldWVkLg0KKyAqLw0KK3ZvaWQgaWVlZTgw
MjExX3B1cmdlX3R4X3F1ZXVlKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmZfaGVhZCAqc2ticyk7DQorDQogLyoqDQog
ICogRE9DOiBIYXJkd2FyZSBjcnlwdG8gYWNjZWxlcmF0aW9uDQogICoNCmRpZmYgLS1naXQgYS9u
ZXQvbWFjODAyMTEvc3RhdHVzLmMgYi9uZXQvbWFjODAyMTEvc3RhdHVzLmMNCmluZGV4IGRkOGY4
NTdhMWZiYy4uZDFjZjk4N2RlMTNiIDEwMDY0NA0KLS0tIGEvbmV0L21hYzgwMjExL3N0YXR1cy5j
DQorKysgYi9uZXQvbWFjODAyMTEvc3RhdHVzLmMNCkBAIC0xMzAxLDMgKzEzMDEsNCBAQCB2b2lk
IGllZWU4MDIxMV9wdXJnZV90eF9xdWV1ZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywNCiAgICAg
ICAgd2hpbGUgKChza2IgPSBfX3NrYl9kZXF1ZXVlKHNrYnMpKSkNCiAgICAgICAgICAgICAgICBp
ZWVlODAyMTFfZnJlZV90eHNrYihodywgc2tiKTsNCiB9DQorRVhQT1JUX1NZTUJPTChpZWVlODAy
MTFfcHVyZ2VfdHhfcXVldWUpOw0KDQoNCg==

