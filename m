Return-Path: <linux-wireless+bounces-25925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC4B0EE0D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE81C21578
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5CE279DC2;
	Wed, 23 Jul 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ITSjtD2z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D429408
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261649; cv=none; b=RtotgR7D5r3PPrIK6Z7W/SHdbJkqO6Cn9sXBoqjCsu1DaMm603dX9SfnTosFPoCD1TWV6xU9jTqH+m0KspGu8IOTMpfTqMmUIMmkWnWNra0PXn6Mrqpf9aLiP98BtAlFzmRK+XWLPnefabKrZfwGRLNZzch5s2N3znxMJSzFuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261649; c=relaxed/simple;
	bh=DY93irpDUm0SY1rL2TC1TFopKpHTXer9b0l2uvHV7yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qMYlaqkPd5mfKVlT8Nh1aDV3SYwHMcZBxYUNbB2fr1DkmSJX6oQsbHMvjBTGsGgPoPSmD3zJWbSseSAgADqJ9cwrl4ff9pjOB2/Z8MZb4dDE58smQaGRDEmzfxTOb8ZgpQ2X8vCluot7h5a6pXCKaB3t3LDLZBncL2/m9P5WwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ITSjtD2z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56N97IgmC2672320, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753261638; bh=DY93irpDUm0SY1rL2TC1TFopKpHTXer9b0l2uvHV7yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ITSjtD2z+x8m7pSEqOgN2IXl1CEq323pfw2p/fmGlo23mGb0y8Z3gyN4PJXj5Js+7
	 yJhxCjp1mj8ocsrJvixWwa5NmQ/vVobIEMebc5K42kyfYLQjcPlLrYCVvI+s2V5SlX
	 E2y9lOelY73XkV2ty6iCrsM3vMjw5eiWYbSWAh+sHDREWA2pLvOH4pbTZO/c5X/TY6
	 1xWv8tEwTA0wWO+nvYMThnFhKJvJphZoUepigoNOABiGpUjXHyKol2sY+rpnfCSpy1
	 R+EcizVGuEWXWhZZ0fNUBUNu1VHkHpnUiQeqLOTz5eZjbL+FretUDBoqWp0DYOVOuB
	 CWhzElLEMg9Rg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56N97IgmC2672320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 17:07:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 17:07:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Jul 2025 17:07:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 23 Jul 2025 17:07:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path'
Thread-Topic: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
Thread-Index: AQHb+wy3xJJYRq7Qhky2ZR9b8r3WqLQ+3/XA///saYCAAIk6oP//fpUAgACIU6D//4PSAAAQ6kAg
Date: Wed, 23 Jul 2025 09:07:17 +0000
Message-ID: <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
 <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
In-Reply-To: <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
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
bT4gdyBkbml1IDIzIGxpcCAyMDI1LCBvIGdvZHouIDEwOjE5Og0KPiA+DQo+ID4gd29ya2luZyBz
dGF0ZToNCj4gPiAgIHJ0dzg4OiBydHdfY2hpcF9wYXJhbWV0ZXJfc2V0dXA6MTg1OSBoYWwtPmNo
aXBfdmVyc2lvbj0weDQ5M2QzMGVhDQo+ID4gbm9uLXdvcmtpbmcgc3RhdGU6DQo+ID4gICBydHc4
ODogcnR3X2NoaXBfcGFyYW1ldGVyX3NldHVwOjE4NTkgaGFsLT5jaGlwX3ZlcnNpb249MHgzMDMw
MzBlYQ0KPiA+DQo+ID4gSSdkIHRyeSB0byByZWFkIG1vcmUgdGltZXMgdG8gc2VlIGlmIGl0IGNh
biBiZWNvbWUgY29ycmVjdC4uLg0KPiA+IEFsc28sIEkgZm9yY2UgdG8gdXNlIGNvcnJlY3QgdmFs
dWUgYXQgdGhlIGxhc3QgaXRlcmF0aW9uIHRvIHNlZSBpZiBpdA0KPiA+IGNhbiB3b3JrIGV2ZW4g
aW5jb3JyZWN0IHZhbHVlIG9mIHJlZ2lzdGVyIDB4RjAuDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiA+IGluZGV4IGZhMGVkMzljYjE5OS4uMTM3
NDE4ZDExMDhkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9tYWluLmMNCj4gPiBAQCAtMTg1OCw5ICsxODYxLDE0IEBAIHN0YXRpYyBpbnQgcnR3X2NoaXBf
cGFyYW1ldGVyX3NldHVwKHN0cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ID4gICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgaGFsLT5j
aGlwX3ZlcnNpb24gPSBydHdfcmVhZDMyKHJ0d2RldiwgUkVHX1NZU19DRkcxKTsNCj4gPiArICAg
ICAgIGZvciAoaW50IGkgPSAwOyBpIDwgMjA7IGkrKykgew0KPiA+ICsgICAgICAgaGFsLT5jaGlw
X3ZlcnNpb24gPSBpID09IDE5ID8gMHg0OTNkMzBlYSA6IHJ0d19yZWFkMzIocnR3ZGV2LCBSRUdf
U1lTX0NGRzEpOw0KPiA+ICAgICAgICBoYWwtPmN1dF92ZXJzaW9uID0gQklUX0dFVF9DSElQX1ZF
UihoYWwtPmNoaXBfdmVyc2lvbik7DQo+ID4gICAgICAgIGhhbC0+bXBfY2hpcCA9IChoYWwtPmNo
aXBfdmVyc2lvbiAmIEJJVF9SVExfSUQpID8gMCA6IDE7DQo+ID4gKyAgICAgICBwcmludGsoInJ0
dzg4OiAlczolZCBoYWwtPmNoaXBfdmVyc2lvbj0weCV4XG4iLA0KPiA+ICsgICAgICAgICAgICAg
ICBfX2Z1bmNfXywgX19MSU5FX18sIGhhbC0+Y2hpcF92ZXJzaW9uKTsNCj4gPiArICAgICAgIG1k
ZWxheSgxMDApOw0KPiA+ICsgICAgICAgfQ0KPiA+ICAgICAgICBpZiAoaGFsLT5jaGlwX3ZlcnNp
b24gJiBCSVRfUkZfVFlQRV9JRCkgew0KPiA+ICAgICAgICAgICAgICAgIGhhbC0+cmZfdHlwZSA9
IFJGXzJUMlI7DQo+ID4gICAgICAgICAgICAgICAgaGFsLT5yZl9wYXRoX251bSA9IDI7DQo+ID4N
Cj4gPg0KPiANCj4gd2VsbCAtIHdpdGggYWJvdmUgcGF0Y2ggYWxsIHN0YXJ0cyB0byB3b3JrIHdl
bGwgOi0pDQo+IDEwIGJvb3RzLCAxMCB3b3JraW5nIHdpZmkgd2l0aCBjb3JyZWN0IHNjYW5zLg0K
DQpHb29kLg0KDQo+IA0KPiBkZW1zZyBmcm9tIHdvcmtpbmcgc3lzOiBodHRwczovL3Rlcm1iaW4u
Y29tL2JoczQNCg0KVW5mb3J0dW5hdGVseSwgdGhlIGxvZyBzYWlkOg0KZmlyc3QgcmVhZDoNCiAg
cnR3ODg6IHJ0d19jaGlwX3BhcmFtZXRlcl9zZXR1cDoxODYwIGhhbC0+Y2hpcF92ZXJzaW9uPTB4
MzAzMDMwZWENCjJuZH4xOXRoIHJlYWQ6DQogIHJ0dzg4OiBydHdfY2hpcF9wYXJhbWV0ZXJfc2V0
dXA6MTg2MCBoYWwtPmNoaXBfdmVyc2lvbj0weDMwMzAzMDMwDQoNCk5vdCBzdXJlIGlmIEkgY2Fu
IHVzZSB0aGlzIHBhdHRlcm4gdG8gbWFrZSBhIHdvcmthcm91bmQuIEkgdGhpbmsgdGhlIGJldHRl
cg0Kd2F5IHdvdWxkIGJlIHRvIHVzZSBmaXJtd2FyZSByZXBvcnQgdG8gZml4IHRoaXMuIEknbGwg
dHJ5IHRvIG1ha2UgYSBwYXRjaA0KYW5kIGdldCBiYWNrIHRvIHlvdSBzb29uLg0KDQoNCg==

