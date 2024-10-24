Return-Path: <linux-wireless+bounces-14441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF69AD921
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 03:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A8EB22458
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 01:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA36FD53C;
	Thu, 24 Oct 2024 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OgHAbOSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABA9474
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732628; cv=none; b=ermKEKeZV3Ia8DhBL/SrbXIP7yDs6/k8D7Xm6BIcxPg0VmjcbXt0fJx0vj/yRyxZMnNJ+rBN1ALBP32I0u5H9o4nVSR5Pr9D1KxY+5SGwgGb6IIlvF/Z2FBmXzKb5MVhijalD7qVUikG1oprgjpVQj6SrxEzoeNfRnQh66HRMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732628; c=relaxed/simple;
	bh=oNnRFEakQIAf3KH53pOWjx3uHlifdA2O4bkQzgROR0g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtuqZMdXXacDMyT7IMozp9FYzr3TpFgr6TqWZIGQ2gInEjy9u0m/4jFqoIYrbHQfONVnfaC/XuDAwjiR13aAoAKLTMCyO1eNIgSPafLygFl51KzE2FJ9oNBWbTDo3+2wnVQirUqE2VjPAHNUUZ6ISn0y+5LMQ2H7A/UB33lxHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OgHAbOSk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49O1H1faC2402137, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729732621; bh=oNnRFEakQIAf3KH53pOWjx3uHlifdA2O4bkQzgROR0g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OgHAbOSkqp0Df6kA9i3yWggOhB0sTQnV4i/YI6HpuuW0/PVXHekSCNH/uJ9Gcg+wr
	 QRQnkyaORgpEWq65anZkSFsfCxlRhVx85Y6N32H2hhbYb4weuWeAI8vQ9dX/Ts5U6I
	 y/UJ2TsZVtb2eeqW5Des3g5wJ4zGPkBqx/lox7icLObcQR5WilN5s7z1Ln7QQOWmbj
	 4zBO1vDcQbs+V1cyl4zAFy9IlMfa1tSaJBIOEHAvhUH6TSrrVhm1y/qKVmc6BxGJBG
	 X9xvceN1HsANE9+HHoLTCrdWVU6hj7bgFFrmZYtPry3fdeuOeJGuMi/pUvePqa96i0
	 6xvkOfbwDqSNg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49O1H1faC2402137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 09:17:01 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:17:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Oct 2024 09:17:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 24 Oct 2024 09:17:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Report the signal strength only if it's known
Thread-Topic: [PATCH] wifi: rtw88: Report the signal strength only if it's
 known
Thread-Index: AQHbJKazdJZwN9XI30e2tNZEQzE0M7KTicpwgABCOoCAAU8rsA==
Date: Thu, 24 Oct 2024 01:17:00 +0000
Message-ID: <c267b5bd26804dcb8c3f6af93b4efc7a@realtek.com>
References: <f7e1e448-2c9b-498f-b8b1-a14dd967d7d3@gmail.com>
 <6d378ad2796f42d88fe80461b8618694@realtek.com>
 <016475e4-3d9f-4bbc-b6dd-bfdb1733d2e7@gmail.com>
In-Reply-To: <016475e4-3d9f-4bbc-b6dd-bfdb1733d2e7@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
My8xMC8yMDI0IDA0OjU3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9yeC5jIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9yeC5jDQo+ID4+IGluZGV4IDFkZTkzZmM5ZWZlOS4uOTBmYzhhNWZh
ODllIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3J4LmMNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9yeC5j
DQo+ID4+IEBAIC0yMzQsMTAgKzIzNCwxNCBAQCBzdGF0aWMgdm9pZCBydHdfcnhfZmlsbF9yeF9z
dGF0dXMoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwNCj4gPj4gICAgICAgICBlbHNlDQo+ID4+ICAg
ICAgICAgICAgICAgICByeF9zdGF0dXMtPmJ3ID0gUkFURV9JTkZPX0JXXzIwOw0KPiA+Pg0KPiA+
PiAtICAgICAgIHJ4X3N0YXR1cy0+c2lnbmFsID0gcGt0X3N0YXQtPnNpZ25hbF9wb3dlcjsNCj4g
Pj4gLSAgICAgICBmb3IgKHBhdGggPSAwOyBwYXRoIDwgcnR3ZGV2LT5oYWwucmZfcGF0aF9udW07
IHBhdGgrKykgew0KPiA+PiAtICAgICAgICAgICAgICAgcnhfc3RhdHVzLT5jaGFpbnMgfD0gQklU
KHBhdGgpOw0KPiA+PiAtICAgICAgICAgICAgICAgcnhfc3RhdHVzLT5jaGFpbl9zaWduYWxbcGF0
aF0gPSBwa3Rfc3RhdC0+cnhfcG93ZXJbcGF0aF07DQo+ID4+ICsgICAgICAgaWYgKHBrdF9zdGF0
LT5waHlfc3RhdHVzKSB7DQo+ID4NCj4gPiBXaGVuIG9ubHkgcGt0X3N0YXQtPnBoeV9zdGF0dXMg
aXMgc2V0LCBkcml2ZXIgY2FsbHMgcnR3ZGV2LT5jaGlwLT5vcHMtPnF1ZXJ5X3BoeV9zdGF0dXMo
KQ0KPiA+IHRvIGdldCBQSFkgc3RhdHVzLiBIYXZlIHlvdSByZXZpZXdlZCBhbGwgcGxhY2VzIGFj
Y2Vzc2luZyBQSFkgZmllbGRzDQo+ID4gYWxzbyBjaGVjayBwa3Rfc3RhdC0+cGh5X3N0YXR1cz8N
Cj4gPg0KPiANCj4gWWVzLCBJIHRoaW5rIHRoaXMgd2FzIHRoZSBvbmx5IHBsYWNlIHRoYXQgZGlk
bid0IGNoZWNrIHBrdF9zdGF0LT5waHlfc3RhdHVzLg0KPiANCg0KR3JlYXQhIFRoYW5rcyBmb3Ig
dGhlIGNvbmZpcm1hdGlvbi4gDQoNCg==

