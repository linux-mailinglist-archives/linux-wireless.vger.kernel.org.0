Return-Path: <linux-wireless+bounces-25966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B72B0FE46
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D8A3B5BC3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3028399;
	Thu, 24 Jul 2025 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vFXydtUP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5262CA8
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753318341; cv=none; b=kldCQIL2zTPOU1ANH7jvq3UhtS3OySeRIDHFPmEixeZI+drYpwd2pK+Ln9HW/GrJii1prl3p7N+rjbHHqd9383H/tFHH/67yruit1L5SopoHJJq5EL/7hZpULbwl1Wy+M4E+00+Hu1Z4XtGDVK/0yA9U68qvrFMYaJ9/zyXSWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753318341; c=relaxed/simple;
	bh=jj6h5RhVVrW7hHg8/i832r0EwbuI3+f8HY4RM+ka7Jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PwUN4OUU3d5g1EJU26mHfp+TrSYQvRUOtabTGeFBvH60nA3uYPnCZd+xhQDPgxqe/8MtNi5Pz9DgORhC5DVRUSjN5BHjNNP9vN3JA7O5W9DPUdkC/x7p/F21WxDjEFHO8eVlbDuKYz3hPbNfOOhlD5aJT7zIa3zeCkP9+oELoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vFXydtUP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56O0qC7M13798627, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753318332; bh=jj6h5RhVVrW7hHg8/i832r0EwbuI3+f8HY4RM+ka7Jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vFXydtUPJl94K69kyqov0LLQCYWPgFhSaS8MJqrq+Eh2uJEEnaazKGYl8KxbnRY5e
	 a8F+hkDM5g04KZV3dgu/UiFV82CYS8LxO12QileSbs08/Qd8WrFQ4y5pB6uiqGt5mA
	 5eir+1f1scBpNMGJhfO7QbUaCfzYU09st2PzWYTl1OOYRdj0P4+mvM99H+EkXhdeCm
	 OrQBRE5eEkcLtmYpTMhajgo1vJl3CeBeB9v8teTM1vfIJBLcKzNNfASO/TIuf8vIZy
	 f8AVHrTEppbjW/t0dLD1uVO8y5zxFarTJHkkMu9bK1hrHFj1r+7Srfo5yiDYptCEGq
	 L8ChYZ/iTcbrg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56O0qC7M13798627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:52:12 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 08:52:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Jul 2025 08:52:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 24 Jul 2025 08:52:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path'
Thread-Topic: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
Thread-Index: AQHb+wy3xJJYRq7Qhky2ZR9b8r3WqLQ+3/XA///saYCAAIk6oP//fpUAgACIU6D//4PSAAAQ6kAg//+iJYCAAJdrXP//ho8A//60ZiA=
Date: Thu, 24 Jul 2025 00:52:12 +0000
Message-ID: <3a93f5580be34135a5b7f942d5b6ea44@realtek.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
 <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
 <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>
 <7dfa0377-538f-464b-b4e4-4c9daa1fb85a@gmail.com>
 <5933c3ef71914cdf83687042488800d2@realtek.com>
 <699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com>
In-Reply-To: <699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com>
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
bT4gdyBkbml1IDIzIGxpcCAyMDI1LCBvIGdvZHouIDE0OjIzOg0KPiA+DQo+ID4gVGhhbmtzIGZv
ciB0aGUgaGludHMuIEkgdGhpbmsgaXQncyB3b3J0aCB0byB0cnk6DQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiA+IGluZGV4IGZhMGVkMzljYjE5
OS4uNWVhMTNjNzc1Nzk2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9tYWluLmMNCj4gPiBAQCAtMTg2MSw2ICsxODYxLDggQEAgc3RhdGljIGludCBydHdf
Y2hpcF9wYXJhbWV0ZXJfc2V0dXAoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4gPiAgICAgICAg
aGFsLT5jaGlwX3ZlcnNpb24gPSBydHdfcmVhZDMyKHJ0d2RldiwgUkVHX1NZU19DRkcxKTsNCj4g
PiAgICAgICAgaGFsLT5jdXRfdmVyc2lvbiA9IEJJVF9HRVRfQ0hJUF9WRVIoaGFsLT5jaGlwX3Zl
cnNpb24pOw0KPiA+ICAgICAgICBoYWwtPm1wX2NoaXAgPSAoaGFsLT5jaGlwX3ZlcnNpb24gJiBC
SVRfUlRMX0lEKSA/IDAgOiAxOw0KPiA+ICsgICAgICAgcHJpbnRrKCJydHc4ODogJXM6JWQgaGFs
LT5jaGlwX3ZlcnNpb249MHgleFxuIiwNCj4gPiArICAgICAgICAgICAgICAgX19mdW5jX18sIF9f
TElORV9fLCBoYWwtPmNoaXBfdmVyc2lvbik7DQo+ID4gICAgICAgIGlmIChoYWwtPmNoaXBfdmVy
c2lvbiAmIEJJVF9SRl9UWVBFX0lEKSB7DQo+ID4gICAgICAgICAgICAgICAgaGFsLT5yZl90eXBl
ID0gUkZfMlQyUjsNCj4gPiAgICAgICAgICAgICAgICBoYWwtPnJmX3BhdGhfbnVtID0gMjsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3NkaW8uYw0KPiA+IGluZGV4IGNj
MmQ0ZmVmMzU4Ny4uNWM5ZTdjOGNkZDdlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9zZGlvLmMNCj4gPiBAQCAtMTQ0LDYgKzE0NCwxMCBAQCBzdGF0aWMg
dTMyIHJ0d19zZGlvX3RvX2lvX2FkZHJlc3Moc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgdTMyIGFk
ZHIsDQo+ID4NCj4gPiBzdGF0aWMgYm9vbCBydHdfc2Rpb191c2VfZGlyZWN0X2lvKHN0cnVjdCBy
dHdfZGV2ICpydHdkZXYsIHUzMiBhZGRyKQ0KPiA+IHsNCj4gPiArICAgICAgIGlmICghcnR3X3Nk
aW9faXNfYnVzX2FkZHIoYWRkcikgJiYNCj4gPiArICAgICAgICAgICAhdGVzdF9iaXQoUlRXX0ZM
QUdfUE9XRVJPTiwgcnR3ZGV2LT5mbGFncykpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBm
YWxzZTsNCj4gPiArDQo+ID4gICAgICAgIHJldHVybiAhcnR3X3NkaW9faXNfc2RpbzMwX3N1cHBv
cnRlZChydHdkZXYpIHx8DQo+ID4gICAgICAgICAgICAgICAgcnR3X3NkaW9faXNfYnVzX2FkZHIo
YWRkcik7DQo+ID4gfQ0KPiA+DQo+IA0KPiBXaXRoIHRoaXMgY2hhbmdlIGFsbCB3b3JrcyBvay4N
Cj4gMTUgYm9vdHMgYW5kIGFsbCAxNSB3ZXJlIHdpdGggbmljZSB3aWZpIDotKQ0KPiANCj4gIGRt
ZXNnIGZyb20gd29ya2luZyBzeXN0ZW06IGh0dHBzOi8vdGVybWJpbi5jb20vMDlhMQ0KDQpJIHNl
bnQgYSBwYXRjaCBbMV0gd2l0aCBhIGNoYW5nZSB0aGF0IGNoZWNrIFJUV19GTEFHX1BPV0VST04g
ZmxhZyBmaXJzdCwgDQpzbyB0aGluZ3Mgd2lsbCBiZSB0aGUgc2FtZSBhcyB0aGlzIGZpbmFsIHRy
eS4gU3RpbGwgd2FudCB5b3UgdGVzdCB0aGUgcGF0Y2gNCmFnYWluLCBhbmQgZ2l2ZSBtZSBhIFRl
c3RlZC1ieSB0YWcgdGhlcmUuIFRoYW5rcy4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXdpcmVsZXNzLzIwMjUwNzI0MDA0ODE1LjcwNDMtMS1wa3NoaWhAcmVhbHRlay5jb20v
VC8jdQ0KDQoNCg==

