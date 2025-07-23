Return-Path: <linux-wireless+bounces-25916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43400B0ED05
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648831755BB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A727991C;
	Wed, 23 Jul 2025 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mWYYRArp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A14278170
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258771; cv=none; b=PMVLyLLgdQEgyt4J/fxqfM452+cW6fSXnPhlNZEjrokJKIXyqKWwFxqTDB8pfjL3VsucrGJ1QcdU0Go4Y1PZgv9+93I2mk3skYQfifWBPFceCYiEkhDKyBJx6yS9WcaXevWEyeq5IWrKiWKmyEI+rauP6PcVPMBx/jDJZB+dhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258771; c=relaxed/simple;
	bh=mOtPtdJlslt0YoKZ+3JqzxSIR0FHWtg/Ui/XjbG40So=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCMlNzlsFQELXadMBPv045dQG4JhfR9hOvM6kJFKjsu+2FiBkaW6/Qc146avC0OWf6s/VfOqbGF6LJRR/b33+4Wkr2c+JENpCQ7q8oyDaNsgddJ3p1b8WUmbTFrFx68eaYMSTSR9aYzxbw01YyDwXU5O7818ybI7KOlq5xGSmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mWYYRArp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56N8JL4P02610783, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753258761; bh=mOtPtdJlslt0YoKZ+3JqzxSIR0FHWtg/Ui/XjbG40So=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mWYYRArpg3OJ7gJsQDR25zdh8FXH+lA1PdZtb2+J8q8dRe1cRUayRoLsnxTwfSVMY
	 0x3G/q0NRybNZlO43FNaR2Bl+fv5/lN3A7KWt+JRZKiPxDjoQNdWdHx4wpBLjqRxkm
	 au1kFfVv2rSSnrH6cVMYvU3QIUbrcc3RSN/k2wVDYsBd/yVotk2tuFPeryq97+Cl2q
	 2SKnUZ64d9xUXy/hWaAADCUMBGnz34AGJSmII9HCxGGMIVBA8SsOPv9gmBKvCRIgcD
	 qOyU+5g5yrxdnGq5EoKxsakRPNBBiggND9qgJ5rtK05YvKWcyzUitq47dVyHbvELno
	 +qslsuz+ahJgQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56N8JL4P02610783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 16:19:21 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 16:19:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Jul 2025 16:19:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 23 Jul 2025 16:19:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path'
Thread-Topic: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
Thread-Index: AQHb+wy3xJJYRq7Qhky2ZR9b8r3WqLQ+3/XA///saYCAAIk6oP//fpUAgACIU6A=
Date: Wed, 23 Jul 2025 08:19:20 +0000
Message-ID: <34d9c169c92540caa294095d2172b4fc@realtek.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
In-Reply-To: <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
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
bT4gdyBkbml1IDIzIGxpcCAyMDI1LCBvIGdvZHouIDA5OjUwOg0KPiA+DQo+ID4gVGhlIGRtc2cg
ZmluZA0KPiA+IG5vbi13b3JraW5nIHN0YXRlOg0KPiA+ICAgcnR3ODg6IHJ0d19jaGlwX3BhcmFt
ZXRlcl9zZXR1cDoxODcyIGhhbC0+cmZfcGh5X251bT0xIGhhbC0+cmZfcGF0aF9udW09MQ0KPiA+
IHdvcmtpbmcgc3RhdGU6DQo+ID4gICBydHc4ODogcnR3X2NoaXBfcGFyYW1ldGVyX3NldHVwOjE4
NzIgaGFsLT5yZl9waHlfbnVtPTIgaGFsLT5yZl9wYXRoX251bT0yDQo+ID4NCj4gPiBUaGV5IHdl
cmUgaW5kdWNlZCBmcm9tIHJlZ2lzdGVyDQo+ID4gICNkZWZpbmUgUkVHX1NZU19DRkcxIDB4MDBG
MA0KPiA+DQo+ID4gUGxlYXNlIGFwcGx5IGJlbG93IGNoYW5nZSBhbmQgc2hhcmUgdGhlIHdvcmtp
bmcvbm9uLXdvcmtpbmcgc2F0ZXMuDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L21haW4uYw0KPiA+IGluZGV4IGZhMGVkMzljYjE5OS4uOTVkZWNmOTBhNDNkIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4g
PiBAQCAtMTg2MSw2ICsxODY0LDggQEAgc3RhdGljIGludCBydHdfY2hpcF9wYXJhbWV0ZXJfc2V0
dXAoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4gPiAgICAgICAgaGFsLT5jaGlwX3ZlcnNpb24g
PSBydHdfcmVhZDMyKHJ0d2RldiwgUkVHX1NZU19DRkcxKTsNCj4gPiAgICAgICAgaGFsLT5jdXRf
dmVyc2lvbiA9IEJJVF9HRVRfQ0hJUF9WRVIoaGFsLT5jaGlwX3ZlcnNpb24pOw0KPiA+ICAgICAg
ICBoYWwtPm1wX2NoaXAgPSAoaGFsLT5jaGlwX3ZlcnNpb24gJiBCSVRfUlRMX0lEKSA/IDAgOiAx
Ow0KPiA+ICsgICAgICAgcHJpbnRrKCJydHc4ODogJXM6JWQgaGFsLT5jaGlwX3ZlcnNpb249MHgl
eFxuIiwNCj4gPiArICAgICAgICAgICAgICAgX19mdW5jX18sIF9fTElORV9fLCBoYWwtPmNoaXBf
dmVyc2lvbik7DQo+ID4gICAgICAgIGlmIChoYWwtPmNoaXBfdmVyc2lvbiAmIEJJVF9SRl9UWVBF
X0lEKSB7DQo+ID4gICAgICAgICAgICAgICAgaGFsLT5yZl90eXBlID0gUkZfMlQyUjsNCj4gPiAg
ICAgICAgICAgICAgICBoYWwtPnJmX3BhdGhfbnVtID0gMjsNCj4gDQo+IA0KPiBoZXJlIGl0IGlz
Og0KPiANCj4gbm9uLXdvcmtpbmc6IGh0dHBzOi8vdGVybWJpbi5jb20vN2dveg0KPiB3b3JraW5n
OiBodHRwczovL3Rlcm1iaW4uY29tL2xwc3ENCg0KTm90IHN1cmUgd2h5IGJpdCBCSVRfUkZfVFlQ
RV9JRCAoMjcpIGlzIGRpZmZlcmVudDogDQoNCndvcmtpbmcgc3RhdGU6DQogICBydHc4ODogcnR3
X2NoaXBfcGFyYW1ldGVyX3NldHVwOjE4NTkgaGFsLT5jaGlwX3ZlcnNpb249MHg0OTNkMzBlYQ0K
bm9uLXdvcmtpbmcgc3RhdGU6DQogICBydHc4ODogcnR3X2NoaXBfcGFyYW1ldGVyX3NldHVwOjE4
NTkgaGFsLT5jaGlwX3ZlcnNpb249MHgzMDMwMzBlYQ0KDQpJJ2QgdHJ5IHRvIHJlYWQgbW9yZSB0
aW1lcyB0byBzZWUgaWYgaXQgY2FuIGJlY29tZSBjb3JyZWN0Li4uDQpBbHNvLCBJIGZvcmNlIHRv
IHVzZSBjb3JyZWN0IHZhbHVlIGF0IHRoZSBsYXN0IGl0ZXJhdGlvbiB0byBzZWUgaWYgaXQNCmNh
biB3b3JrIGV2ZW4gaW5jb3JyZWN0IHZhbHVlIG9mIHJlZ2lzdGVyIDB4RjAuDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQppbmRleCBmYTBlZDM5Y2IxOTkuLjEz
NzQxOGQxMTA4ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvbWFpbi5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4u
Yw0KQEAgLTE4NTgsOSArMTg2MSwxNCBAQCBzdGF0aWMgaW50IHJ0d19jaGlwX3BhcmFtZXRlcl9z
ZXR1cChzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KICAgICAgICB9DQoNCi0gICAgICAgaGFsLT5jaGlwX3ZlcnNpb24gPSBydHdfcmVhZDMy
KHJ0d2RldiwgUkVHX1NZU19DRkcxKTsNCisgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCAyMDsg
aSsrKSB7DQorICAgICAgIGhhbC0+Y2hpcF92ZXJzaW9uID0gaSA9PSAxOSA/IDB4NDkzZDMwZWEg
OiBydHdfcmVhZDMyKHJ0d2RldiwgUkVHX1NZU19DRkcxKTsNCiAgICAgICAgaGFsLT5jdXRfdmVy
c2lvbiA9IEJJVF9HRVRfQ0hJUF9WRVIoaGFsLT5jaGlwX3ZlcnNpb24pOw0KICAgICAgICBoYWwt
Pm1wX2NoaXAgPSAoaGFsLT5jaGlwX3ZlcnNpb24gJiBCSVRfUlRMX0lEKSA/IDAgOiAxOw0KKyAg
ICAgICBwcmludGsoInJ0dzg4OiAlczolZCBoYWwtPmNoaXBfdmVyc2lvbj0weCV4XG4iLA0KKyAg
ICAgICAgICAgICAgIF9fZnVuY19fLCBfX0xJTkVfXywgaGFsLT5jaGlwX3ZlcnNpb24pOw0KKyAg
ICAgICBtZGVsYXkoMTAwKTsNCisgICAgICAgfQ0KICAgICAgICBpZiAoaGFsLT5jaGlwX3ZlcnNp
b24gJiBCSVRfUkZfVFlQRV9JRCkgew0KICAgICAgICAgICAgICAgIGhhbC0+cmZfdHlwZSA9IFJG
XzJUMlI7DQogICAgICAgICAgICAgICAgaGFsLT5yZl9wYXRoX251bSA9IDI7DQoNCg0K

