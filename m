Return-Path: <linux-wireless+bounces-25886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F9B0E7B7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 02:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8CE1C84B1C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40422CCDB;
	Wed, 23 Jul 2025 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="c4tz05by"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA90EAE7
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231984; cv=none; b=TOlUHTARXPAIwKfWusDM67CMW328gerjgP/g5keFZ/A65t5mlpMxUUfXI0sLpS9U3gwU1jJkdZeDVqdeCpG7edYSk+BuRcefVHSCABQcF/cU7pjvZQKEPUfscr7fds+a1e2+WChy/GuPT/+yScKevVtVutgNhwfVVDg10msZKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231984; c=relaxed/simple;
	bh=CZ7Og0kIh2tl2Cbmg4j3XRSoyo8CSV6M8allIEBUXs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PSeZ06JAirqITcMttaVFnrgnpFdSOHQlAwbn8CqUp3N1aWu4h0qjkFuWg0LG+Ic8k2MtADG12WlNnGkfMkN9lapLk11Sz313K+XTVqRuBz6KkZnKyDspTtwGV0WcKnz4wdwVTChq6XXBoqCfhI+YgpA4vdvK4t3BMXh2jomE1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=c4tz05by; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56N0qsnT71978433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753231974; bh=CZ7Og0kIh2tl2Cbmg4j3XRSoyo8CSV6M8allIEBUXs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=c4tz05bykTMF1IflRZcesy66TEKavRcdFJHwPon05h9w0I8u5qlhSf+DOnOgsjYha
	 IYKbE9MqofUS2nRRPyuqYci48PpctNbVPmZ8DzOR+CkfKO1TUEtdentiU3nV7DEvh6
	 BTqyOyM72w/0Gl+gL9Xz50zpQ7AFIfxywP/MhSdpJ3UN6oV3V4hAQBo+PpI48c5ghZ
	 ujALCmdfxM3gkIlvC16R64gz78zrdnP/U1MVnNe4SR7w5wwitg8DBSNqqf9lvC1oHo
	 ULyNCYEuJL81saqtS7QAtm4XmjMVtw/f192Lp0/C8WCsqFyjWhASFrQMq7b90qChaZ
	 zUBPX1Itex9qw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56N0qsnT71978433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 08:52:54 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 08:52:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Jul 2025 08:52:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 23 Jul 2025 08:52:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path' 
Thread-Topic: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path' 
Thread-Index: AQHb+wy3xJJYRq7Qhky2ZR9b8r3WqLQ+3/XA
Date: Wed, 23 Jul 2025 00:52:53 +0000
Message-ID: <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
In-Reply-To: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
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

UGlvdHIgT25pc3pjenVrIDxwaW90ci5vbmlzemN6dWtAZ21haWwuY29tPiB3cm90ZToNCg0KWy4u
Ll0NCg0KPiANCj4gV29ya2luZzogSFQgUlggTUNTIGluZGV4ZXM6IDAtMTUNCj4gTm9uLXdvcmtp
bmc6IEhUIFJYIE1DUyBpbmRleGVzOiAwLTcNCj4gDQo+IElzbuKAmXQgdGhhdCA4LTE1IGFyZSBm
b3IgMngybWltbz8NCj4gU28gbWF5YmUgLSBieSBzb21lIHJlYXNvbiAtIGh3IHNvbWV0aW1lcyBy
ZXBvcnRzIHN1cHBvcnQgZm9yIG9ubHkgMXggbWltbyBidXQgcmVjZWl2ZXMgZnJvbSBhaXIgMngg
bWltbw0KPiAoMiBzdHJlYW1zKSBhbmQgdGhhdHMgd2h5IEkgc2VlIGhlbGwgb2YgInVuc3VwcG9y
dGVkIHJmIHBhdGgiICBlcnJvcnMgZnJvbSBkcml2ZXI/DQoNCkkgdGhpbmsgeW91ciBwb2ludCBp
cyBjb3JyZWN0IHRoYXQgZmlybXdhcmUgcmVwb3J0cyBpbmNvcnJlY3QgdmFsdWUgc29tZWhvdy4g
DQpXaXRoIGJlbG93IGNoYW5nZXMsIHdlIGNhbiBjaGVjayB0aGlzOg0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KaW5kZXggZmEwZWQzOWNiMTk5Li4zMzYzNDU4
YTllYTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21h
aW4uYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCkBA
IC05OTYsNiArOTk2LDkgQEAgc3RhdGljIHZvaWQgcnR3X2h3X2NvbmZpZ19yZl9hbnRfbnVtKHN0
cnVjdCBydHdfZGV2ICpydHdkZXYsIHU4IGh3X2FudF9udW0pDQogICAgICAgICAgICAgICAgaGFs
LT5yZl9wYXRoX251bSA9IDE7DQogICAgICAgICAgICAgICAgaWYgKCFjaGlwLT5maXhfcmZfcGh5
X251bSkNCiAgICAgICAgICAgICAgICAgICAgICAgIGhhbC0+cmZfcGh5X251bSA9IGhhbC0+cmZf
cGF0aF9udW07DQorICAgICAgICAgICAgICAgcHJpbnRrKCIlczolZCBoYWwtPnJmX3BoeV9udW09
JWQgaGFsLT5yZl9wYXRoX251bT0lZCBod19hbnRfbnVtPSVkXG4iLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgX19mdW5jX18sIF9fTElORV9fLCBoYWwtPnJmX3BoeV9udW0sIGhhbC0+cmZfcGF0
aF9udW0sIGh3X2FudF9udW0pOw0KKw0KICAgICAgICAgICAgICAgIGhhbC0+YW50ZW5uYV90eCA9
IEJCX1BBVEhfQTsNCiAgICAgICAgICAgICAgICBoYWwtPmFudGVubmFfcnggPSBCQl9QQVRIX0E7
DQogICAgICAgICAgICAgICAgYnJlYWs7DQpAQCAtMTg3NCw2ICsxODc3LDggQEAgc3RhdGljIGlu
dCBydHdfY2hpcF9wYXJhbWV0ZXJfc2V0dXAoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCiAgICAg
ICAgfQ0KICAgICAgICBoYWwtPnJmX3BoeV9udW0gPSBjaGlwLT5maXhfcmZfcGh5X251bSA/IGNo
aXAtPmZpeF9yZl9waHlfbnVtIDoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgaGFsLT5yZl9w
YXRoX251bTsNCisgICAgICAgcHJpbnRrKCIlczolZCBoYWwtPnJmX3BoeV9udW09JWQgaGFsLT5y
Zl9wYXRoX251bT0lZFxuIiwNCisgICAgICAgICAgICAgICBfX2Z1bmNfXywgX19MSU5FX18sIGhh
bC0+cmZfcGh5X251bSwgaGFsLT5yZl9wYXRoX251bSk7DQoNCiAgICAgICAgZWZ1c2UtPnBoeXNp
Y2FsX3NpemUgPSBjaGlwLT5waHlfZWZ1c2Vfc2l6ZTsNCiAgICAgICAgZWZ1c2UtPmxvZ2ljYWxf
c2l6ZSA9IGNoaXAtPmxvZ19lZnVzZV9zaXplOw0KDQoNCklmIHdlIGZvdW5kIGZpcm13YXJlIHJl
cG9ydHMgaW5jb3JyZWN0IHZhbHVlcywgbGV0J3MgcHJpbnQgb3V0IHRoZSByZXBvcnRlZA0KdmFs
dWVzIGJ5IHRoaXMgYmVsb3cgdG8gc2VlIGlmIHdlIGNhbiBoYXZlIHVzZWZ1bCBjbHVlcy4gDQoN
CkBAIC0xOTQ4LDYgKzE5NTMsOSBAQCBzdGF0aWMgaW50IHJ0d19kdW1wX2h3X2ZlYXR1cmUoc3Ry
dWN0IHJ0d19kZXYgKnJ0d2RldikNCiAgICAgICAgZm9yIChpID0gMDsgaSA8IEhXX0ZFQVRVUkVf
TEVOOyBpKyspDQogICAgICAgICAgICAgICAgaHdfZmVhdHVyZVtpXSA9IHJ0d19yZWFkOChydHdk
ZXYsIFJFR19DMkhFVlQgKyAyICsgaSk7DQoNCisgICAgICAgcHJpbnRrKCIlczolZCBod19mZWF0
dXJlID0gJSpwaFxuIiwNCisgICAgICAgICAgICAgICBfX2Z1bmNfXywgX19MSU5FX18sIEhXX0ZF
QVRVUkVfTEVOLCBod19mZWF0dXJlKTsNCisNCiAgICAgICAgcnR3X3dyaXRlOChydHdkZXYsIFJF
R19DMkhFVlQsIDApOw0KDQogICAgICAgIGJ3ID0gR0VUX0VGVVNFX0hXX0NBUF9CVyhod19mZWF0
dXJlKTsNCg0KDQoNCg0K

