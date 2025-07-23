Return-Path: <linux-wireless+bounces-25913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8BFB0EC55
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112903A4E98
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D3272E61;
	Wed, 23 Jul 2025 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JL2bZK55"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBB2777F7
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257013; cv=none; b=k7qDbA9MvhYYv2Ev7cU7H5QeKuOhOQnTS0wgNqn8zyDQlL4QvRw4qCtdiTJoHlWcuTaoRsHRs4ziykjwkXguaNvJdiMsR+PGEh+6VEBUePtRxtO8bKwUtJslI8056U/fzYEcAVpgM2TV2Ar+fdP43x8FIn1J6HL5wkrcf6buB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257013; c=relaxed/simple;
	bh=4HPzODXpnBioFyN4qRgTervnQer8V3wC7keYdB7ek5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qMF74wf4lcm/knKZRwMWnRoDQn18Jr2QCQYtJ5k0RDdyLwLKC1TyZjpn9Sy/vkqO8lojnbVbvaucc61V++ZXQk/Y+2UMC1v3fsvoOW1KTDtZgZqY35I96VdXUKq4DmNXGWnOxJ+/+sC7gb9xNPWP95nQrZ/NJ6lNgADZLr42VRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JL2bZK55; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56N7o28H12565485, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753257003; bh=4HPzODXpnBioFyN4qRgTervnQer8V3wC7keYdB7ek5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JL2bZK55eZnZSHWtFIGfcUZacnEz58G5Yvzs1P5qa0DRuNSLsf2FSN4Y0Bs1JpFpl
	 DFyFntLn30lT/tcVf7Sde91qZD5B1LZS0yhrljldPFQuXClxCCMuqPr34Toun6olMF
	 cVI4zEQdCZn774OvYSh9Ri0qHTyDEIsNiyeSMX2GzFTpkN3BeQkevV1TXi0t1d5scu
	 GOfmruHKQusKyf2yVEe6KLxd5Mk9lQFGdJ+to9qdx+YwX7VHBvjLHeVk4zvF6KiVkI
	 tgZrmno1EhCfqB2jBaMGVPCG+NXO04/YVSXlfiwre95Me6MT1dlxcYclsWteDRwYF8
	 /+8T31edlh2Rg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56N7o28H12565485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 15:50:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 15:50:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Jul 2025 15:50:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 23 Jul 2025 15:50:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path'
Thread-Topic: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
Thread-Index: AQHb+wy3xJJYRq7Qhky2ZR9b8r3WqLQ+3/XA///saYCAAIk6oA==
Date: Wed, 23 Jul 2025 07:50:01 +0000
Message-ID: <b29df36b838049a088d8298220078134@realtek.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
In-Reply-To: <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
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

UGlvdHIgT25pc3pjenVrIDxwaW90ci5vbmlzemN6dWtAZ21haWwuY29tPiB3cm90ZToNCj4gPiBX
aWFkb21vxZvEhyBuYXBpc2FuYSBwcnpleiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4gdyBkbml1IDIzIGxpcCAyMDI1LCBvIGdvZHouIDAyOjUyOg0KPiA+DQo+ID4gUGlvdHIgT25p
c3pjenVrIDxwaW90ci5vbmlzemN6dWtAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFsuLi5d
DQo+ID4NCj4gPj4NCj4gPj4gV29ya2luZzogSFQgUlggTUNTIGluZGV4ZXM6IDAtMTUNCj4gPj4g
Tm9uLXdvcmtpbmc6IEhUIFJYIE1DUyBpbmRleGVzOiAwLTcNCj4gPj4NCj4gPj4gSXNu4oCZdCB0
aGF0IDgtMTUgYXJlIGZvciAyeDJtaW1vPw0KPiA+PiBTbyBtYXliZSAtIGJ5IHNvbWUgcmVhc29u
IC0gaHcgc29tZXRpbWVzIHJlcG9ydHMgc3VwcG9ydCBmb3Igb25seSAxeCBtaW1vIGJ1dCByZWNl
aXZlcyBmcm9tIGFpciAyeCBtaW1vDQo+ID4+ICgyIHN0cmVhbXMpIGFuZCB0aGF0cyB3aHkgSSBz
ZWUgaGVsbCBvZiAidW5zdXBwb3J0ZWQgcmYgcGF0aCIgIGVycm9ycyBmcm9tIGRyaXZlcj8NCj4g
Pg0KPiA+IEkgdGhpbmsgeW91ciBwb2ludCBpcyBjb3JyZWN0IHRoYXQgZmlybXdhcmUgcmVwb3J0
cyBpbmNvcnJlY3QgdmFsdWUgc29tZWhvdy4NCj4gPiBXaXRoIGJlbG93IGNoYW5nZXMsIHdlIGNh
biBjaGVjayB0aGlzOg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODgvbWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9tYWluLmMNCj4gPiBpbmRleCBmYTBlZDM5Y2IxOTkuLjMzNjM0NThhOWVhMSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi4NCj4gDQo+IA0KPiDi
gKbigKYuDQo+IA0KPiANCj4gcGxzIGZpbmQgZG1lc2cgZnJvbToNCj4gDQo+IG5vbi13b3JraW5n
IHN0YXRlOiBodHRwczovL3Rlcm1iaW4uY29tLzh4NDINCj4gd29ya2luZyBzdGF0ZTogaHR0cHM6
Ly90ZXJtYmluLmNvbS9iODA0DQoNClRoZSBkbXNnIGZpbmQgDQpub24td29ya2luZyBzdGF0ZToN
CiAgIHJ0dzg4OiBydHdfY2hpcF9wYXJhbWV0ZXJfc2V0dXA6MTg3MiBoYWwtPnJmX3BoeV9udW09
MSBoYWwtPnJmX3BhdGhfbnVtPTENCndvcmtpbmcgc3RhdGU6DQogICBydHc4ODogcnR3X2NoaXBf
cGFyYW1ldGVyX3NldHVwOjE4NzIgaGFsLT5yZl9waHlfbnVtPTIgaGFsLT5yZl9wYXRoX251bT0y
DQoNClRoZXkgd2VyZSBpbmR1Y2VkIGZyb20gcmVnaXN0ZXIgDQogICNkZWZpbmUgUkVHX1NZU19D
RkcxCQkweDAwRjANCg0KUGxlYXNlIGFwcGx5IGJlbG93IGNoYW5nZSBhbmQgc2hhcmUgdGhlIHdv
cmtpbmcvbm9uLXdvcmtpbmcgc2F0ZXMuDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvbWFpbi5jDQppbmRleCBmYTBlZDM5Y2IxOTkuLjk1ZGVjZjkwYTQzZCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQorKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KQEAgLTE4NjEsNiArMTg2NCw4
IEBAIHN0YXRpYyBpbnQgcnR3X2NoaXBfcGFyYW1ldGVyX3NldHVwKHN0cnVjdCBydHdfZGV2ICpy
dHdkZXYpDQogICAgICAgIGhhbC0+Y2hpcF92ZXJzaW9uID0gcnR3X3JlYWQzMihydHdkZXYsIFJF
R19TWVNfQ0ZHMSk7DQogICAgICAgIGhhbC0+Y3V0X3ZlcnNpb24gPSBCSVRfR0VUX0NISVBfVkVS
KGhhbC0+Y2hpcF92ZXJzaW9uKTsNCiAgICAgICAgaGFsLT5tcF9jaGlwID0gKGhhbC0+Y2hpcF92
ZXJzaW9uICYgQklUX1JUTF9JRCkgPyAwIDogMTsNCisgICAgICAgcHJpbnRrKCJydHc4ODogJXM6
JWQgaGFsLT5jaGlwX3ZlcnNpb249MHgleFxuIiwNCisgICAgICAgICAgICAgICBfX2Z1bmNfXywg
X19MSU5FX18sIGhhbC0+Y2hpcF92ZXJzaW9uKTsNCiAgICAgICAgaWYgKGhhbC0+Y2hpcF92ZXJz
aW9uICYgQklUX1JGX1RZUEVfSUQpIHsNCiAgICAgICAgICAgICAgICBoYWwtPnJmX3R5cGUgPSBS
Rl8yVDJSOw0KICAgICAgICAgICAgICAgIGhhbC0+cmZfcGF0aF9udW0gPSAyOw0KDQoNCg0K

