Return-Path: <linux-wireless+bounces-15126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC19C1443
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 03:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E951F21F93
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E914A90;
	Fri,  8 Nov 2024 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qvLhB6Z/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8F29408
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033663; cv=none; b=GJbWy6sUTJUrJrSN3SDvFMg+IFVNvKsjFZb6+UeOEvHUch1cyGgB+Lzv83EXboq+B6JABT8qu85X59xI8hBIDgviIaqcs+7RNVD3fwCCcML2I4S2yobh+5YGgVy8g6wikKkmZ8/HClDuagNHGIKFlZvKw1fRs0yOnucXFqpMz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033663; c=relaxed/simple;
	bh=CKMmdNr1LMF/oGVWJtJCB9OpXqRvrC63vOPoJjp9BuA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6y6qIDIguvkjQcZ7NUmQTvLbdk3XSa1UlRRQeTAcBWk05uKJSkjA+jvYhsG3PZLfp+rnMuuiVrr977/tZFsdPM/FaHQWQAAiQ9sqrGIca79tW16UmsxMk2MBmIqHvNIu5gbQ/ak7jj5WL/ge+jG/RSUwaZUnbvQpw1VuvTM+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qvLhB6Z/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A82evEL31254019, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731033657; bh=CKMmdNr1LMF/oGVWJtJCB9OpXqRvrC63vOPoJjp9BuA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qvLhB6Z/beCG8jEXkQwNuoDnoA8QpsQDOywJUf9CFz01Buth/s29NOsTZQZedijLr
	 x3Hd6E9aiVBRZkG347oMJL70erMFq8UdxZSw/MxgfvdZwaD1pnusjG7QFpRmrGOUJ/
	 zqR/eRikmTreWvGVHqmtDzqUn2MSxy9Z62LMXS+lrsuBZ4EQdH2JvnvOSwcO5gKm2v
	 kUMc4Xxsi7OfsFbJnNkwqnS1BMVI8Q+odX3gl/Zk2LRpIFKUCeuqGl14deGMmdATex
	 1+9+/7j8x6Ul/7aecnbQVJL0+YJci1fKxWP27jPwSJ5iABXZipHW1uEcSAuXgNL7XG
	 35K6jGUiyM/3A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A82evEL31254019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:40:57 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 10:40:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 10:40:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 10:40:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw88: usb: Enable RX aggregation for 8821au/8812au
Thread-Topic: [PATCH 2/2] wifi: rtw88: usb: Enable RX aggregation for
 8821au/8812au
Thread-Index: AQHbMW7qXR5j+TCs/UazpoOrAIx+7LKsq3CA
Date: Fri, 8 Nov 2024 02:40:56 +0000
Message-ID: <dbba24025d024b31948dc23cd0c2f772@realtek.com>
References: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
 <c7f9a5c0-a90f-4ebe-b7a0-401d300bfa13@gmail.com>
In-Reply-To: <c7f9a5c0-a90f-4ebe-b7a0-401d300bfa13@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPj4gDQo+
IFVTQiBSWCBhZ2dyZWdhdGlvbiBpbXByb3ZlcyB0aGUgUlggc3BlZWQgb24gY2VydGFpbiBBUk0g
c3lzdGVtcywgbGlrZQ0KPiB0aGUgTmFub1BpIE5FTyBDb3JlMi4gV2l0aCBSVEw4ODExQVUsIGJl
Zm9yZTogMzAgTWJwcywgYWZ0ZXI6IDIyNCBNYnBzLg0KPiANCj4gVGhlIG91dC1vZi10cmVlIGRy
aXZlciB1c2VzIGFnZ3JlZ2F0aW9uIHNpemUgb2YgNyBpbiBVU0IgMyBtb2RlLCBidXQNCj4gdGhh
dCBkb2Vzbid0IHdvcmsgaGVyZS4gcnR3ODggYWR2ZXJ0aXNlcyBzdXBwb3J0IGZvciByZWNlaXZp
bmcgQU1TRFUNCj4gaW4gQU1QRFUsIHNvIHRoZSBBUCBzZW5kcyBsYXJnZXIgZnJhbWVzLCB1cCB0
byB+NTEwMCBieXRlcy4gV2l0aCBhIHNpemUNCj4gb2YgNyBSVEw4ODEyQVUgZnJlcXVlbnRseSB0
cmllcyB0byBhZ2dyZWdhdGUgbW9yZSBmcmFtZXMgdGhhbiB3aWxsIGZpdA0KPiBpbiAzMjc2OCBi
eXRlcy4gVXNlIGEgc2l6ZSBvZiA2IGluc3RlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0
ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jIHwgMzAgKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jDQo+IGluZGV4IDc1MmJjYTA1YjlhZi4u
OTE3MmFmNjM1MDBiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3VzYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
dXNiLmMNCj4gQEAgLTc5MCw2ICs3OTAsMzIgQEAgc3RhdGljIHZvaWQgcnR3X3VzYl9keW5hbWlj
X3J4X2FnZ192MShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCBib29sIGVuYWJsZSkNCj4gICAgICAg
ICBydHdfd3JpdGUxNihydHdkZXYsIFJFR19SWERNQV9BR0dfUEdfVEgsIHZhbDE2KTsNCj4gIH0N
Cj4gDQo+ICtzdGF0aWMgdm9pZCBydHdfdXNiX2R5bmFtaWNfcnhfYWdnX3YyKHN0cnVjdCBydHdf
ZGV2ICpydHdkZXYsIGJvb2wgZW5hYmxlKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBydHdfdXNi
ICpydHd1c2IgPSBydHdfZ2V0X3VzYl9wcml2KHJ0d2Rldik7DQo+ICsgICAgICAgdTggc2l6ZSwg
dGltZW91dDsNCj4gKyAgICAgICB1MTYgdmFsMTY7DQo+ICsNCg0KSG93IGFib3V0IGEgc2hvcnRj
dXQ/DQoNCmlmICghZW5hYmxlKSB7DQoJc2l6ZSA9IDB4MDsNCgl0aW1lb3V0ID0gMHgxOw0KDQoJ
Z290byByeF9hZ2c7DQp9DQoNCj4gKyAgICAgICBpZiAocnR3dXNiLT51ZGV2LT5zcGVlZCA9PSBV
U0JfU1BFRURfU1VQRVIpIHsNCj4gKyAgICAgICAgICAgICAgIHNpemUgPSAweDY7DQo+ICsgICAg
ICAgICAgICAgICB0aW1lb3V0ID0gMHgxYTsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiArICAgICAg
ICAgICAgICAgc2l6ZSA9IDB4NTsNCj4gKyAgICAgICAgICAgICAgIHRpbWVvdXQgPSAweDIwOw0K
PiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIGlmICghZW5hYmxlKSB7DQo+ICsgICAgICAgICAg
ICAgICBzaXplID0gMHgwOw0KPiArICAgICAgICAgICAgICAgdGltZW91dCA9IDB4MTsNCj4gKyAg
ICAgICB9DQo+ICsNCg0KcnhfYWdnOg0KDQo+ICsgICAgICAgdmFsMTYgPSB1MTZfZW5jb2RlX2Jp
dHMoc2l6ZSwgQklUX1JYRE1BX0FHR19QR19USCkgfA0KPiArICAgICAgICAgICAgICAgdTE2X2Vu
Y29kZV9iaXRzKHRpbWVvdXQsIEJJVF9ETUFfQUdHX1RPX1YxKTsNCj4gKw0KPiArICAgICAgIHJ0
d193cml0ZTE2KHJ0d2RldiwgUkVHX1JYRE1BX0FHR19QR19USCwgdmFsMTYpOw0KPiArICAgICAg
IHJ0d193cml0ZThfc2V0KHJ0d2RldiwgUkVHX1RYRE1BX1BRX01BUCwgQklUX1JYRE1BX0FHR19F
Tik7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIHJ0d191c2JfZHluYW1pY19yeF9hZ2coc3Ry
dWN0IHJ0d19kZXYgKnJ0d2RldiwgYm9vbCBlbmFibGUpDQo+ICB7DQo+ICAgICAgICAgc3dpdGNo
IChydHdkZXYtPmNoaXAtPmlkKSB7DQo+IEBAIC03OTgsNiArODI0LDEwIEBAIHN0YXRpYyB2b2lk
IHJ0d191c2JfZHluYW1pY19yeF9hZ2coc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgYm9vbCBlbmFi
bGUpDQo+ICAgICAgICAgY2FzZSBSVFdfQ0hJUF9UWVBFXzg4MjFDOg0KPiAgICAgICAgICAgICAg
ICAgcnR3X3VzYl9keW5hbWljX3J4X2FnZ192MShydHdkZXYsIGVuYWJsZSk7DQo+ICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gKyAgICAgICBjYXNlIFJUV19DSElQX1RZUEVfODgyMUE6DQo+ICsg
ICAgICAgY2FzZSBSVFdfQ0hJUF9UWVBFXzg4MTJBOg0KPiArICAgICAgICAgICAgICAgcnR3X3Vz
Yl9keW5hbWljX3J4X2FnZ192MihydHdkZXYsIGVuYWJsZSk7DQo+ICsgICAgICAgICAgICAgICBi
cmVhazsNCj4gICAgICAgICBjYXNlIFJUV19DSElQX1RZUEVfODcyM0Q6DQo+ICAgICAgICAgICAg
ICAgICAvKiBEb2Vzbid0IGxpa2UgYWdncmVnYXRpb24uICovDQo+ICAgICAgICAgICAgICAgICBi
cmVhazsNCj4gLS0NCj4gMi40Ny4wDQoNCg==

