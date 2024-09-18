Return-Path: <linux-wireless+bounces-12932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E597B790
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 08:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77311F236DC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 06:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9976339A0;
	Wed, 18 Sep 2024 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ojfcGqSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C11B85D8;
	Wed, 18 Sep 2024 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726639361; cv=none; b=iceGDwrRs0l+ydZOL6jDJD9+nVRQuwExZd7ED/6WcYXgbtsaBEsceHuXd8mxd8onaka0+dKcMkkbisja64oTumZ0RmDOCWE9BrWQfj6nCy7SkI6433a6aBkeYuG4wBYlzD/wExGB8PCSQt2x6RgTC0mxBXFRovEVhphwr+fej2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726639361; c=relaxed/simple;
	bh=SBR/YWUb/gqRQGNR+uOQR+FlN/79Sq3jlCSoHkCDFA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyCwlJmghJpkLltLFtMvcmq5aEoVNPeIzDKigwGsIvMivyLcZQfoUAbk8H7tG4Lb9fy2O+rSPbu0JNIVbbutu6YBCa9KjyPYCA6KdIUtyEJFMHAGcvXmz/mJIKU9s+hIjRn2G4z2N13mLw+1GNAesfpWeCbpPBmi8QyvzktnRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ojfcGqSS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48I62UxU41665549, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726639350; bh=SBR/YWUb/gqRQGNR+uOQR+FlN/79Sq3jlCSoHkCDFA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ojfcGqSSlVmickYwWtPgs1uOrcFEQ/q+Pyxm0uqQxFFuT+gYICf+U0J29zif6dl7/
	 L5ALjCag89hjC1bLTgqNpwNp5LD84Lkp9mlb+vI05qqN5lZyrOgERVI7KIsRNnJOv8
	 lkDb5KkSLFoC8/WKZ7xWZC7jSMWxAY2yqz0OblNSMqX49EBwCx8EAlUeqLBBqVrQDY
	 jtXwWwnp6ZMLeUk2CQMtbD9TB8XxpfraIN5eoWXE9sQvMRuT1IPKZLx8u5oqRoK14S
	 1jnvHdsktVfZCWruJa3IC8kQSxQIrIdY2984is8FwlbrFM6cu5amXdP2TLyKdxK0IQ
	 soKaWYv3iDwxg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48I62UxU41665549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:02:30 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 14:02:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 18 Sep 2024 14:02:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 18 Sep 2024 14:02:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2VsIFdlacOfZW5iYWNo?= <mweissenbach@ignaz.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Topic: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Index: AQHbCMemb6H6HxFviUGmiPt2/8qxPLJdDI+A
Date: Wed, 18 Sep 2024 06:02:29 +0000
Message-ID: <f755bbeb5bbb479f9142bf223e71102c@realtek.com>
References: <20240917055730.Horde.pVyI-XF1MRA_zUQ5BDJZ4lC@ignaz.org>
In-Reply-To: <20240917055730.Horde.pVyI-XF1MRA_zUQ5BDJZ4lC@ignaz.org>
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

TWFyY2VsIFdlacOfZW5iYWNoIDxtd2Vpc3NlbmJhY2hAaWduYXoub3JnPiB3cm90ZToNCj4gDQo+
IEhpIHRoZXJlLA0KPiANCj4gaSB1cGdyYWRlZCBteSBBcmNobGludXggdGVzdGluZyBzZXR1cCBm
cm9tIDYuMTAuOSB0byA2LjExIGFuZCBub3RpY2VkIHRoYXQgbXkgd2lmaSBpcyBubyBsb25nZXIg
d29ya2luZy4NCg0KQ2hlY2tpbmcgdGhlIGNvbW1pdHMgYmV0d2VlbiA2LjEwLjkgYW5kIDYuMTEs
IEkgZmVlbCB0aGUgY2F1c2UgaXMNCiAgMWZkNGIzZmU1MmVmICgid2lmaTogcnR3ODk6IHBjaTog
c3VwcG9ydCAzNi1iaXQgUENJIERNQSBhZGRyZXNzIikNCg0KU2VlbWluZ2x5IHRoZXJlIGlzIDM2
LWJpdCBQQ0kgRE1BIGludGVyb3BlcmFiaWxpdHkgb24gUlRMODg1MkJFLg0KQ291bGQgeW91IHBs
ZWFzZSB0cnkgYmVsb3cgdG8gY29tbWVudCBvdXQgdGhlIGZ1bmN0aW9uPyANCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jDQppbmRleCAwMmFmZWIzYWNjZTQuLjAzOWZj
MzI5YzZmNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
cGNpLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMNCkBA
IC0zMDYxLDcgKzMwNjEsNyBAQCBzdGF0aWMgaW50IHJ0dzg5X3BjaV9zZXR1cF9tYXBwaW5nKHN0
cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCiAgICAgICAgICAgICAgICBnb3RvIGVycjsNCiAgICAg
ICAgfQ0KDQotICAgICAgIHJldCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBkZXYtPmRl
diwgRE1BX0JJVF9NQVNLKDM2KSk7DQorICAgICAgIHJldCA9IC0xOy8vZG1hX3NldF9tYXNrX2Fu
ZF9jb2hlcmVudCgmcGRldi0+ZGV2LCBETUFfQklUX01BU0soMzYpKTsNCiAgICAgICAgaWYgKCFy
ZXQpIHsNCiAgICAgICAgICAgICAgICBydHdwY2ktPmVuYWJsZV9kYWMgPSB0cnVlOw0KICAgICAg
ICAgICAgICAgIHJ0dzg5X3BjaV9jZmdfZGFjKHJ0d2Rldik7DQoNCg0KSWYgdGhpcyBoZWxwcywg
cGxlYXNlIHByb3ZpZGUgeW91ciBETUkgaW5mbyBieSAnc3VkbyBkbWlkZWNvZGUnLiBJIHdpbGwg
YnVpbGQNCmEgcXVpcmsgdGFibGUgZm9yIGl0IHNpbmNlIEkgZG9uJ3Qga25vdyB3aGF0IHRoZSBl
eGFjdCBzZXR0aW5ncyBhZmZlY3QgdGhpcy4NCg0KDQo=

