Return-Path: <linux-wireless+bounces-15285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5639C7F56
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 01:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B42814E2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 00:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9462905;
	Thu, 14 Nov 2024 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nPXurQ3Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F317C2
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543706; cv=none; b=g7vJG956rc6j9DejNiwttEf2j4ZVq5gAdPbkBbP9met0aCT0rRC5IUwUJHQDOlgUOkY3sbZioOqe2AoI+4CP28c7nH6Y5XToOO3yez6jixQRYKLx71EOE2LxRpXmmoE3Ksq/4G+VrNstXsdv2n48GMdTR5YsNz3MYtYcOfKSe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543706; c=relaxed/simple;
	bh=qG9FbJY6Ka2OImKxt7a+p05MZCKxzCZdQM6ahtlFqeU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YsIjTO7w3floWQ6W3favVffm2hqdEaCkJrUYtlSyMZX90VQn6VyjwqJ1vrocKaJrb7AJouMdaS+p74/KTL1Z6ts+C0ETEWWLdqiq3hls1GBcXwC0YsX2LrO2A9TWBgbsP9qW/dhH9HUWMkV6TxS0sO4/ndMKTee7O1qNoLC179E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nPXurQ3Z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AE0LcuY62076525, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731543698; bh=qG9FbJY6Ka2OImKxt7a+p05MZCKxzCZdQM6ahtlFqeU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nPXurQ3ZvI9TJLvIqOEqqNCxEqTcZVZIOg647S0n9CrrezCJiU5yTleCjKTp3tpN8
	 PEluKU1vHXh6tdsCHarOdEgB1FbQP7025jzsvd027EClYB6rlOePHH3w9GdE4VbIJG
	 inZsMQx2feS/VHuqz1zvfiLXqEHQnRQVdUP8+hhN9hiV1auZkEWfPx6RsZWwCjF0Kb
	 X7B/J/TfwPpcD5qcOMgkY+naihCRQqwEgHC7n9ydRZ/nk/XeLmpu8dfhLjaJ8g/PJG
	 GqVEdvPT/ExWUtpZ6/0FWrcGMfT9vLOI7prfLBW+n3VQEvrSuW9UbjpzA2ckRTI5QL
	 pROjgulME8pVQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AE0LcuY62076525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 08:21:38 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 08:21:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Nov 2024 08:21:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 14 Nov 2024 08:21:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw88: usb: Enable RX aggregation for 8821au/8812au
Thread-Topic: [PATCH 2/2] wifi: rtw88: usb: Enable RX aggregation for
 8821au/8812au
Thread-Index: AQHbMW7qXR5j+TCs/UazpoOrAIx+7LKsq3CAgAi5FgCAAI0VgA==
Date: Thu, 14 Nov 2024 00:21:38 +0000
Message-ID: <f6df24d12a3144e1b0b1496cb5c45176@realtek.com>
References: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
 <c7f9a5c0-a90f-4ebe-b7a0-401d300bfa13@gmail.com>
 <dbba24025d024b31948dc23cd0c2f772@realtek.com>
 <f9223971-a679-42ec-b0df-44f60a93a10f@gmail.com>
In-Reply-To: <f9223971-a679-42ec-b0df-44f60a93a10f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
OC8xMS8yMDI0IDA0OjQwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4NCj4gPj4gVVNCIFJYIGFn
Z3JlZ2F0aW9uIGltcHJvdmVzIHRoZSBSWCBzcGVlZCBvbiBjZXJ0YWluIEFSTSBzeXN0ZW1zLCBs
aWtlDQo+ID4+IHRoZSBOYW5vUGkgTkVPIENvcmUyLiBXaXRoIFJUTDg4MTFBVSwgYmVmb3JlOiAz
MCBNYnBzLCBhZnRlcjogMjI0IE1icHMuDQo+ID4+DQo+ID4+IFRoZSBvdXQtb2YtdHJlZSBkcml2
ZXIgdXNlcyBhZ2dyZWdhdGlvbiBzaXplIG9mIDcgaW4gVVNCIDMgbW9kZSwgYnV0DQo+ID4+IHRo
YXQgZG9lc24ndCB3b3JrIGhlcmUuIHJ0dzg4IGFkdmVydGlzZXMgc3VwcG9ydCBmb3IgcmVjZWl2
aW5nIEFNU0RVDQo+ID4+IGluIEFNUERVLCBzbyB0aGUgQVAgc2VuZHMgbGFyZ2VyIGZyYW1lcywg
dXAgdG8gfjUxMDAgYnl0ZXMuIFdpdGggYSBzaXplDQo+ID4+IG9mIDcgUlRMODgxMkFVIGZyZXF1
ZW50bHkgdHJpZXMgdG8gYWdncmVnYXRlIG1vcmUgZnJhbWVzIHRoYW4gd2lsbCBmaXQNCj4gPj4g
aW4gMzI3NjggYnl0ZXMuIFVzZSBhIHNpemUgb2YgNiBpbnN0ZWFkLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4g
Pj4gLS0tDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jIHwg
MzAgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5z
ZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC91c2IuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
dXNiLmMNCj4gPj4gaW5kZXggNzUyYmNhMDViOWFmLi45MTcyYWY2MzUwMGIgMTAwNjQ0DQo+ID4+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMNCj4gPj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYw0KPiA+PiBAQCAtNzkw
LDYgKzc5MCwzMiBAQCBzdGF0aWMgdm9pZCBydHdfdXNiX2R5bmFtaWNfcnhfYWdnX3YxKHN0cnVj
dCBydHdfZGV2ICpydHdkZXYsIGJvb2wgZW5hYmxlKQ0KPiA+PiAgICAgICAgIHJ0d193cml0ZTE2
KHJ0d2RldiwgUkVHX1JYRE1BX0FHR19QR19USCwgdmFsMTYpOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+
PiArc3RhdGljIHZvaWQgcnR3X3VzYl9keW5hbWljX3J4X2FnZ192MihzdHJ1Y3QgcnR3X2RldiAq
cnR3ZGV2LCBib29sIGVuYWJsZSkNCj4gPj4gK3sNCj4gPj4gKyAgICAgICBzdHJ1Y3QgcnR3X3Vz
YiAqcnR3dXNiID0gcnR3X2dldF91c2JfcHJpdihydHdkZXYpOw0KPiA+PiArICAgICAgIHU4IHNp
emUsIHRpbWVvdXQ7DQo+ID4+ICsgICAgICAgdTE2IHZhbDE2Ow0KPiA+PiArDQo+ID4NCj4gPiBI
b3cgYWJvdXQgYSBzaG9ydGN1dD8NCj4gPg0KPiA+IGlmICghZW5hYmxlKSB7DQo+ID4gICAgICAg
c2l6ZSA9IDB4MDsNCj4gPiAgICAgICB0aW1lb3V0ID0gMHgxOw0KPiA+DQo+ID4gICAgICAgZ290
byByeF9hZ2c7DQo+ID4gfQ0KPiA+DQo+ID4+ICsgICAgICAgaWYgKHJ0d3VzYi0+dWRldi0+c3Bl
ZWQgPT0gVVNCX1NQRUVEX1NVUEVSKSB7DQo+ID4+ICsgICAgICAgICAgICAgICBzaXplID0gMHg2
Ow0KPiA+PiArICAgICAgICAgICAgICAgdGltZW91dCA9IDB4MWE7DQo+ID4+ICsgICAgICAgfSBl
bHNlIHsNCj4gPj4gKyAgICAgICAgICAgICAgIHNpemUgPSAweDU7DQo+ID4+ICsgICAgICAgICAg
ICAgICB0aW1lb3V0ID0gMHgyMDsNCj4gPj4gKyAgICAgICB9DQo+ID4+ICsNCj4gPj4gKyAgICAg
ICBpZiAoIWVuYWJsZSkgew0KPiA+PiArICAgICAgICAgICAgICAgc2l6ZSA9IDB4MDsNCj4gPj4g
KyAgICAgICAgICAgICAgIHRpbWVvdXQgPSAweDE7DQo+ID4+ICsgICAgICAgfQ0KPiA+PiArDQo+
ID4NCj4gPiByeF9hZ2c6DQo+ID4NCj4gPj4gKyAgICAgICB2YWwxNiA9IHUxNl9lbmNvZGVfYml0
cyhzaXplLCBCSVRfUlhETUFfQUdHX1BHX1RIKSB8DQo+ID4+ICsgICAgICAgICAgICAgICB1MTZf
ZW5jb2RlX2JpdHModGltZW91dCwgQklUX0RNQV9BR0dfVE9fVjEpOw0KPiA+PiArDQo+ID4+ICsg
ICAgICAgcnR3X3dyaXRlMTYocnR3ZGV2LCBSRUdfUlhETUFfQUdHX1BHX1RILCB2YWwxNik7DQo+
ID4+ICsgICAgICAgcnR3X3dyaXRlOF9zZXQocnR3ZGV2LCBSRUdfVFhETUFfUFFfTUFQLCBCSVRf
UlhETUFfQUdHX0VOKTsNCj4gPj4gK30NCj4gDQo+IEhtbSwgSSBkb24ndCBsaWtlIGl0Lg0KDQpI
b25lc3RseSwgSSBkb24ndCBsaWtlIGl0IHNvIG11Y2guIA0KDQo+IFdoYXQgYWJvdXQgdGhpcz8N
Cj4gDQo+ICAgICAgICAgaWYgKCFlbmFibGUpIHsNCj4gICAgICAgICAgICAgICAgIHNpemUgPSAw
eDA7DQo+ICAgICAgICAgICAgICAgICB0aW1lb3V0ID0gMHgxOw0KPiAgICAgICAgIH0gZWxzZSBp
ZiAocnR3dXNiLT51ZGV2LT5zcGVlZCA9PSBVU0JfU1BFRURfU1VQRVIpIHsNCj4gICAgICAgICAg
ICAgICAgIHNpemUgPSAweDY7DQo+ICAgICAgICAgICAgICAgICB0aW1lb3V0ID0gMHgxYTsNCj4g
ICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgc2l6ZSA9IDB4NTsNCj4gICAgICAg
ICAgICAgICAgIHRpbWVvdXQgPSAweDIwOw0KPiAgICAgICAgIH0NCg0KSSB0aG91Z2h0IGFib3V0
IHRoaXMgdG9vLCBidXQgYSBmbGF3IGlzIGZpcnN0IGNvbmRpdGlvbiBpcyBmb3IgIWVuYWJsZQ0K
YW5kIGxhdGVyIHR3byBjb25kaXRpb25zIGFyZSBmb3IgZW5hYmxlLiANCg0KSSB0aGluayB0aGUg
bG9naWMgYmVsb3cgaXMgY2xlYXIsIGJ1dCBtb3JlIGluZGVudCB0aG91Z2guIA0KDQogICAgICAg
IGlmICghZW5hYmxlKSB7DQogICAgICAgICAgICAgICAgc2l6ZSA9IDB4MDsNCiAgICAgICAgICAg
ICAgICB0aW1lb3V0ID0gMHgxOw0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgIGlm
IChydHd1c2ItPnVkZXYtPnNwZWVkID09IFVTQl9TUEVFRF9TVVBFUikgew0KICAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZSA9IDB4NjsNCiAgICAgICAgICAgICAgICAgICAgICAgIHRpbWVvdXQg
PSAweDFhOw0KICAgICAgICAgICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgICAgICAg
ICBzaXplID0gMHg1Ow0KICAgICAgICAgICAgICAgICAgICAgICAgdGltZW91dCA9IDB4MjA7DQog
ICAgICAgICAgICAgICAgfQ0KICAgICAgICB9DQoNCk1pbmUsIHlvdXJzIGFuZCBteSBsYXN0IHBy
b3Bvc2FsIGFyZSBmaW5lIHRvIG1lLiBZb3UgY2FuIGRlY2lkZSB0byB0YWtlDQpvbmUgb2YgdGhl
bS4gDQoNCg0K

