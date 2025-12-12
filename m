Return-Path: <linux-wireless+bounces-29681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F3CB7700
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C55EB3013EB6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8F85C4A;
	Fri, 12 Dec 2025 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="noXVOjck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAA883F;
	Fri, 12 Dec 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765498587; cv=none; b=U+Hog/lqikdpAy7SMgRL6oD8S4s/oatDZNFU0pDOL9ePXX7z8kX2iJi0+Itwh6T/zD0Q5R9qL0Zy3YzuJkliGAdhEJR0esLu1tTiRyChwlG+YoGHkvURmbEOPIRs31Rkw13w1eml7bZAfZKDjK3m860+lz+l6el6BLQgJOmZAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765498587; c=relaxed/simple;
	bh=WMxuKgG4jk6HzUaiJMzrCxajmsELEf8vUmNJk9jIs0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hRtzf/0ws+hVRNE4kOdkIP3/j3d3IAKhCBO46hFhXSEl1ig7B8CUAqzuDw7v5sg0G5e3/WE8h02KxvWZd3bkIZMRtM4FmFw9RKUJZrhbhlUkqmb+J0an1HoMqhZOmAE+Lxq4o/s4DorUa78XDTmkkuXZY+DHDm2ZkI2X1GQW1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=noXVOjck; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC0GJovC3201556, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765498579; bh=WMxuKgG4jk6HzUaiJMzrCxajmsELEf8vUmNJk9jIs0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=noXVOjckJmvjPRH8E0R/7JFrqJ/sVF6P0eCt1s5NaivP4pZGUKEig0OQ4mcyuw1gX
	 I6oH8tEC7sJVdsXsOMaKcr3V8NiEiX/+09sCb0DU2XyfFvN2rs4VSuJvf0s55+7Mj2
	 h+cl/4l304CSrm4q5zDuIdgl40U7WCD1hkbd+BaBRK72rz8sFXmcxhFwUzAENY73BT
	 /k0nXyo2G3AfeyBzhIIQs3IYVgz2bR/m0NkYUFCmSpQaH6Z+kbH1cu26s0tHQgg0KI
	 eLT6PaH0O5vXqU2wkRsy7m6SwuEyy6spr8tMZS/40dZ9sBnQ7P/plCkHxZzVnIU/Kc
	 FeY6xMOZOSEVQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC0GJovC3201556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 08:16:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 08:16:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 08:16:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Fri, 12 Dec 2025 08:16:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "chourasiarohit27@gmail.com" <chourasiarohit27@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gcnRsd2lmaTogZml4IHR5cG8gaW4gY29tbWVudCAocmVjaWV2ZWQg4oaSIHJlY2VpdmVkKQ==?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBydGx3aWZpOiBmaXggdHlwbyBpbiBjb21tZW50IChyZWNpZXZl?=
 =?utf-8?B?ZCDihpIgcmVjZWl2ZWQp?=
Thread-Index: AQHcarnosttdweOZjEyt8Kt5PsyTKLUdIlmA
Date: Fri, 12 Dec 2025 00:16:19 +0000
Message-ID: <22e408c8b0b54d8eaada13fbc20784ad@realtek.com>
References: <20251211161911.30611-1-chourasiarohit27@gmail.com>
In-Reply-To: <20251211161911.30611-1-chourasiarohit27@gmail.com>
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

Y2hvdXJhc2lhcm9oaXQyN0BnbWFpbC5jb20gPGNob3VyYXNpYXJvaGl0MjdAZ21haWwuY29tPiB3
cm90ZToNCj4gRnJvbTogUm9oaXQgQ2hvdXJhc2lhIDxjaG91cmFzaWFyb2hpdDI3QGdtYWlsLmNv
bT4NCg0KU3ViamVjdCBwcmVmaXggc2hvdWxkIGJlICJ3aWZpOiBydGx3aWZpOiAuLi4iLg0KSSB3
aWxsIGNoYW5nZSBpdCB0byAid2lmaTogcnRsd2lmaTogZml4IHR5cG8gb2YgJ3JlY2VpdmVkJyBp
biBjb21tZW50Ig0KZHVyaW5nIGdldHRpbmcgbWVyZ2VkLiBBbHNvLCBJIHdpbGwgYWRkIHNvbWUg
dHJpdmlhbCBjb21taXQgbWVzc2FnZXMuDQoNCiAgRml4IHR5cG8gcmVjZWl2ZWQgLT4gcmVjZWl2
ZWQgYnkgcmV2aWV3Lg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2hpdCBDaG91cmFzaWEgPGNo
b3VyYXNpYXJvaGl0MjdAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bHdpZmkvcmVnZC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGx3aWZpL3JlZ2QuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
d2lmaS9yZWdkLmMNCj4gaW5kZXggMGJjNGFmYTRmZGEzLi5mZDk2NzAwNmIzZTEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9yZWdkLmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3JlZ2QuYw0KPiBAQCAtMjA2
LDcgKzIwNiw3IEBAIHN0YXRpYyB2b2lkIF9ydGxfcmVnX2FwcGx5X2FjdGl2ZV9zY2FuX2ZsYWdz
KHN0cnVjdCB3aXBoeSAqd2lwaHksDQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICAvKg0KPiAt
ICAgICAgICAqSWYgYSBjb3VudHJ5IElFIGhhcyBiZWVuIHJlY2lldmVkIGNoZWNrIGl0cyBydWxl
IGZvciB0aGlzDQo+ICsgICAgICAgICpJZiBhIGNvdW50cnkgSUUgaGFzIGJlZW4gcmVjZWl2ZWQg
Y2hlY2sgaXRzIHJ1bGUgZm9yIHRoaXMNCj4gICAgICAgICAgKmNoYW5uZWwgZmlyc3QgYmVmb3Jl
IGVuYWJsaW5nIGFjdGl2ZSBzY2FuLiBUaGUgcGFzc2l2ZSBzY2FuDQo+ICAgICAgICAgICp3b3Vs
ZCBoYXZlIGJlZW4gZW5mb3JjZWQgYnkgdGhlIGluaXRpYWwgcHJvY2Vzc2luZyBvZiBvdXINCj4g
ICAgICAgICAgKmN1c3RvbSByZWd1bGF0b3J5IGRvbWFpbi4NCj4gLS0NCj4gMi4yNS4xDQoNCg==

