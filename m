Return-Path: <linux-wireless+bounces-19447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0882DA45261
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1F33A37B2
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 01:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA72A1B2;
	Wed, 26 Feb 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IFPh+oDo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA64689
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534435; cv=none; b=X6K83QRcy5UARWo5Nkq/RDEeMktL6HVBPArcCC3iDQzeZ/qV0yE3fM8MMKzwr8t1pcARk+4yG+tZAkg5bHbELFQ+6nOWNMDUIzcikCWM906roW8RHtgS0FWy0pFMzDBCfx3QQ0POKAxaQxl42+Awrzh6fP5qoV94QoVG4l+2qLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534435; c=relaxed/simple;
	bh=hj3KIeFbDESE2TkGMEGaSCOsGwmKEnPHvZ1I+4cBc+w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RxES79+N0xyffp1YYd6SVeZ/P8OVkPvzrKP32j11glJdnSetE6WDxPKVnot+hUQBpERRYg0JhiGHGU79Lv4UHAcLaHeTF521btacGuS88yVhMcN/bcC6rxPSmdrpWNBs4fT06BA6Hfx/drlwvWTSLVqqDYu+Yg0Phb4fIk+zFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IFPh+oDo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51Q1l7NP12865215, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740534428; bh=hj3KIeFbDESE2TkGMEGaSCOsGwmKEnPHvZ1I+4cBc+w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IFPh+oDowUWxi9uejv3LjGmk7RGTsyQJL0zRX1/ru2Q401BPL8pyIN+1L+cgTtnre
	 5YgK3r/VDeSFl6UqbbXTSHuP+YPQiC9+J9a6KryaIzkiFxf7LO0iXICt+yXosJaiAt
	 KJaxKefry/hveVKoJ9aiWB7Q7VtVEZbiGfD3tas9EHsV2jtqouViwFuohFsL6gfSRu
	 r8uOKXghqZyQ0a0KOqRoS+O10pQAUARxTUN/JbT2vuapta4+9UUYUmbLXQ36Ga3Che
	 53/LqHhb09RjyGZUNTfeChd0BRq8xiozIJ2Fnn5yHgSSiy/9nc/PT6Xee7xa1Ur8RC
	 dEH9aniCK6vGg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51Q1l7NP12865215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 09:47:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 09:47:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 26 Feb 2025 09:47:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Wed, 26 Feb 2025 09:47:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
Thread-Topic: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
Thread-Index: AQHbgk4F7yF1CrP6lkuUlCsBtIqcQLNY2RZA
Date: Wed, 26 Feb 2025 01:47:07 +0000
Message-ID: <cc99f85cd4864077b2a53a27611e81bf@realtek.com>
References: <0c91ac77-a652-4ab4-b911-e0a2386fb863@gmail.com>
In-Reply-To: <0c91ac77-a652-4ab4-b911-e0a2386fb863@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3BjaS5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3BjaS5jDQo+IGluZGV4IDBlYWZjNGQx
MjVmOS4uOTYxNGE5ZTc1MmI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bHdpZmkvcGNpLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydGx3aWZpL3BjaS5jDQo+IEBAIC01MjAsNyArNTIwLDcgQEAgc3RhdGljIHZvaWQgX3J0bF9w
Y2lfdHhfaXNyKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBpbnQgcHJpbykNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgcnRsX3R4X2Fja3F1ZXVlKGh3LCBza2IpOw0KPiAgICAgICAgICAgICAg
ICAgfQ0KPiANCj4gLSAgICAgICAgICAgICAgIGlmICgocmluZy0+ZW50cmllcyAtIHNrYl9xdWV1
ZV9sZW4oJnJpbmctPnF1ZXVlKSkgPD0gNCkgew0KPiArICAgICAgICAgICAgICAgaWYgKChyaW5n
LT5lbnRyaWVzIC0gc2tiX3F1ZXVlX2xlbigmcmluZy0+cXVldWUpKSA+PSA0KSB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIHJ0bF9kYmcocnRscHJpdiwgQ09NUF9FUlIsIERCR19ETUVTRywN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAibW9yZSBkZXNjIGxlZnQsIHdha2Ug
c2tiX3F1ZXVlQCVkLCByaW5nLT5pZHggPSAlZCwgc2tiX3F1ZXVlX2xlbiA9DQo+IDB4JXhcbiIs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbywgcmluZy0+aWR4LA0KDQpS
ZWFkaW5nIHRoZSBjb2RlIGFib3V0IGNhbGxpbmcgaWVlZTgwMjExX3N0b3BfcXVldWUoKSBhbmQN
CmllZWU4MDIxMV93YWtlX3F1ZXVlKCkgYWdhaW4uIEl0IGxvb2tzIGxpa2UNCg0KSW4gVFggcGF0
aCAocnRsX3BjaV90eCk6DQoNCiAgICBpZiAocmVtYWluaW5nIDwgMikNCiAgICAgICAgaWVlZTgw
MjExX3N0b3BfcXVldWUoKTsNCg0KSW4gVFggY29tcGxldGlvbiBwYXRoIChfcnRsX3BjaV90eF9p
c3IpOg0KDQogICAgaWYgKHJlbWFpbmluZyA8PSA0KQ0KICAgICAgICBpZWVlODAyMTFfd2FrZV9x
dWV1ZSgpOw0KDQpJIGd1ZXNzIGl0IHVzZXMgIjw9IDQiIGluIFRYIGNvbXBsZXRpb24gcGF0aCBi
ZWNhdXNlIG9yaWdpbiBwYXRjaCBkb2Vzbid0DQp3YW50IHRvIGNhbGwgaWVlZTgwMjExX3dha2Vf
cXVldWUoKSByZWR1bmRhbnRseSwgYnV0IGxvb2tzIG5vdCBzbyByZWFzb25hYmxlLg0KVGhlIGJl
dHRlciB3YXkgbWF5IHVzZSBpZWVlODAyMTFfcXVldWVfc3RvcHBlZCgpIGluc3RlYWQuDQoNCg==

