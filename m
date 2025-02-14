Return-Path: <linux-wireless+bounces-18951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD434A35270
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 01:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C51888AA0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD432173;
	Fri, 14 Feb 2025 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uMF+eO/1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5121FDA
	for <linux-wireless@vger.kernel.org>; Fri, 14 Feb 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739491792; cv=none; b=I8jDvNeam9ztOuMldKp0PSYCyv9zv63ejpUDjcJ9jkxXIsD+zF3PNNlJIzOZgqWoWqAUZckmkFoVO8Yk6gmbEypH6OFHrVvCuqUGBO9MR2yaJ7MDe0ZwZA/v/plENoG1ZOD+izsVz7iAkymCrsj0TzVdTXzocqEOMH8+w5ftnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739491792; c=relaxed/simple;
	bh=m75tXaKsZ42wLDh8vzAJegI9qwkNlAgDFnwjnXEy5+o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NF32iDUwZnwTw1NBWZzBwRFevTf2NuYRHNfN3aIAAR6CTcDKm0J5DQdkGEsJTUOr1EAHiUb5PwQMLL8wi5FJGaeUKniaxPy5Thgb3QVvyB7dH1zEtPPYoeDwJ7SKYd6z2z3NT6FHXrmRy/M/4xtNEgZpGO13mjNPfXwpi6L38G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uMF+eO/1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51E09h9iA1839275, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739491783; bh=m75tXaKsZ42wLDh8vzAJegI9qwkNlAgDFnwjnXEy5+o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uMF+eO/15APXqxQOTtKAGCTX2VfIxe8nk4OOfTFCXeGh17TkicK/rb1kEiXDhudmt
	 4tsaW1N+Am3s6H/EdEDgoHX/hW9g31dONl4O3iUzVInHWU9/PoRw+yreEdAG4tln/+
	 /kQQy3nS8rjZUGpbuHBv8hl7CVpkbcOxvPjVtAijFtKYSNffBFtMlV9HlWxbjUrAXb
	 NUQHyF8WQVCVgYUc3oOI1fEUgypxQLtSt4Ih18vhydJ6xugqFth/7iGk6qW6Li201B
	 d1r+a4SCUYCbiWq2dk/1zKw+IjDYkF4+8UNLHW7ECzJL61NnOR2yJP03bwK64bEMFA
	 zRnhOIvYD+juQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51E09h9iA1839275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 08:09:43 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Feb 2025 08:09:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 14 Feb 2025 08:09:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Fri, 14 Feb 2025 08:09:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Thread-Topic: [PATCH 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle
 MCS16-31
Thread-Index: AQHbfNOEmVS3jazL6EKkriyCSkzaBLNE2FnAgAAMGICAAQqZAA==
Date: Fri, 14 Feb 2025 00:09:43 +0000
Message-ID: <63a9a6352ae44ebdb8c176f6c114ce06@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <23d28222-8f83-43a8-b312-d5858cf355d8@gmail.com>
 <48e6cdc3d0a240d8b7efee2523f95807@realtek.com>
 <1d9c9889-dc63-4f2d-94f7-3f604349ab39@gmail.com>
In-Reply-To: <1d9c9889-dc63-4f2d-94f7-3f604349ab39@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
My8wMi8yMDI1IDA5OjMwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGlzIGZ1bmN0aW9uIHRy
YW5zbGF0ZXMgdGhlIHJhdGUgbnVtYmVyIHJlcG9ydGVkIGJ5IHRoZSBoYXJkd2FyZSBpbnRvDQo+
ID4+IHNvbWV0aGluZyBtYWM4MDIxMSBjYW4gdW5kZXJzdGFuZC4gSXQgd2FzIGlnbm9yaW5nIHRo
ZSAzU1MgYW5kIDRTUyBIVA0KPiA+PiByYXRlcy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4+IC0tLQ0KPiA+
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91dGlsLmMgfCAyICstDQo+ID4+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXRpbC5j
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91dGlsLmMNCj4gPj4gaW5kZXgg
ZTIyMmQzYzAxYTc3Li5iYTAyYmE3MmUxMDQgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXRpbC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXRpbC5jDQo+ID4+IEBAIC0xMDEsNyArMTAxLDcgQEAgdm9p
ZCBydHdfZGVzY190b19tY3NyYXRlKHUxNiByYXRlLCB1OCAqbWNzLCB1OCAqbnNzKQ0KPiA+PiAg
ICAgICAgICAgICAgICAgKm5zcyA9IDQ7DQo+ID4+ICAgICAgICAgICAgICAgICAqbWNzID0gcmF0
ZSAtIERFU0NfUkFURVZIVDRTU19NQ1MwOw0KPiA+PiAgICAgICAgIH0gZWxzZSBpZiAocmF0ZSA+
PSBERVNDX1JBVEVNQ1MwICYmDQo+ID4+IC0gICAgICAgICAgICAgICAgICByYXRlIDw9IERFU0Nf
UkFURU1DUzE1KSB7DQo+ID4+ICsgICAgICAgICAgICAgICAgICByYXRlIDw9IERFU0NfUkFURU1D
UzMxKSB7DQo+ID4+ICAgICAgICAgICAgICAgICAqbWNzID0gcmF0ZSAtIERFU0NfUkFURU1DUzA7
DQo+ID4NCj4gPiBTb21laG93LCB3ZSBkb24ndCBzZXQgKm5zcyBpbiB0aGlzIGNhc2UuIFRoZSBj
YWxsZXIgcnR3X2Z3X3JhX3JlcG9ydF9pdGVyKCkNCj4gPiBkb2Vzbid0IGluaXRpYWxpemUgbnNz
LCBzbyB0aGVyZSBpcyBwb3RlbnRpYWwgcHJvYmxlbS4NCj4gPg0KPiA+DQo+IA0KPiBJIGFzc3Vt
ZWQgaXQncyBub3QgbmVlZGVkIGJlY2F1c2UgdGhlIE1DUyBpbmRleCBpbXBsaWVzIHRoZSBOU1Ms
DQoNClllcywgSFQgZG9lc24ndCBuZWVkIE5TUy4NCg0KPiBidXQgSSBjYW4gYWRkIHRoYXQ6DQo+
IA0KPiAgICAgICAgICAgICAgICAgKm5zcyA9ICptY3MgLyA4ICsgMTsNCg0KU28gKm5zcyA9IDA7
DQoNClBsZWFzZSBzZWUgaG93IHJ0d19md19yYV9yZXBvcnRfaXRlcigpIHVzZXMgaXRzIGxvY2Fs
IHZhcmlhYmxlICduc3MnLg0KDQo=

