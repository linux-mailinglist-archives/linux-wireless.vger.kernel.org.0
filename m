Return-Path: <linux-wireless+bounces-11469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D59529D7
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9051C2120F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDB0179954;
	Thu, 15 Aug 2024 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KoYhqug6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74815E5D4
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706796; cv=none; b=p4arRTwD9TtgmEJ/zg1Ziu8aeA1G1C66+GpwMTImOLGecw+ZAn3LYc1jqFkks7u299S1v+Z47dt8j94+hHjHPt3b3cTYw34wUOAXSb9utLcSPbIdSRKQ25PQ4KciqaVeMCpunXpuML6/rY1/D/5o0dktZhMhQkM7U/nsSIuenoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706796; c=relaxed/simple;
	bh=dB7YvWgrdXFkBzbHSyZXZOzmHxvNQ/F1fFJVgBGoEP4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P64o528MHrWkWHdoIlGKIeMaNgpfoN6B1XL85ILG9ABqu3qMM/OQ9ZEMHSQX/xXc7uVV/Ep1LitEv8z2jJecu5omixiAH451OhtLtEOduxBtQcfdegy5GkUG332UqZtRairaH9LR1Q0O/njOm+Bkoq6FVuJvHseWzYjergPAXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KoYhqug6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F7QTPN03737348, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723706789; bh=dB7YvWgrdXFkBzbHSyZXZOzmHxvNQ/F1fFJVgBGoEP4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KoYhqug6xRpMBbo2kLOYeabQpbqybgDwzuQ7Db61DZBngbJLYpEITn53F0kBz0cpH
	 CXVOwYYKQ3+lfkZq4tbVX4/sYvJNYJEnIOBozriDGiPA2RLGhPzOpHTVlKsF3Deaj3
	 wds5qrZlbn0g5XYpPOSFXN60upeyK6/otPUoH/0Fz1h7g9H2C7e2dE9PYeetBVG9DJ
	 ZMajXpShmrSw2fzaY9AxhRvOdqrrBj6Pe73Oe2IOAQbcYXaPyXMI8fQZ2F+Z6j/P45
	 IF5oL2CVL5y91P9CcqAdUsFXD0CZ9ZIeS3L4+4VKvESxtSVpSQX+pLArDnxss+tKT/
	 HBrbJmvplpHyA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F7QTPN03737348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:26:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:26:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:26:30 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:26:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 14/20] wifi: rtw88: 8821a: Regularly ask for BT info updates
Thread-Topic: [PATCH 14/20] wifi: rtw88: 8821a: Regularly ask for BT info
 updates
Thread-Index: AQHa7DIPL/QzCeCo9EyvsByxCySIzrIn7xFQ
Date: Thu, 15 Aug 2024 07:26:30 +0000
Message-ID: <477a1603b5cd454aa82f186bc88b73e3@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <bd23d618-3f56-4729-ba23-8c14e9873ef9@gmail.com>
In-Reply-To: <bd23d618-3f56-4729-ba23-8c14e9873ef9@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UlRMODgyMUFVIGZpcm13YXJlIHNlbmRzIEMySF9CVF9JTkZPIGJ5IGl0c2VsZiB3aGVuIGJsdWV0
b290aA0KPiBoZWFkcGhvbmVzIGFyZSBjb25uZWN0ZWQsIGJ1dCBub3Qgd2hlbiB0aGV5IGFyZSBk
aXNjb25uZWN0ZWQuIFRoaXMgbGVhZHMNCj4gdG8gdGhlIGNvZXhpc3RlbmNlIGNvZGUgc3RpbGwg
dXNpbmcgdGhlIEEyRFAgYWxnb3JpdGhtIGxvbmcgYWZ0ZXIgdGhlDQo+IGhlYWRwaG9uZXMgYXJl
IGRpc2Nvbm5lY3RlZCwgd2hpY2ggbWVhbnMgdGhlIHdpZmkgc3BlZWRzIGFyZSBtdWNoIGxvd2Vy
DQo+IHRoYW4gdGhleSBzaG91bGQgYmUuIFdvcmsgYXJvdW5kIHRoaXMgYnkgYXNraW5nIGZvciB1
cGRhdGVzIGV2ZXJ5IHR3bw0KPiBzZWNvbmRzIGlmIHRoZSBjaGlwIGlzIFJUTDg4MjFBVS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvY29leC5j
IHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9jb2V4LmggfCAx
ICsNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jIHwgMyArKysN
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9jb2V4LmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2NvZXguYw0KPiBpbmRleCAzOWZi
YzVlZjgyZjguLjkxZTIxYmRmYjU2OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9jb2V4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9jb2V4LmMNCj4gQEAgLTQ0Niw3ICs0NDYsNyBAQCBzdGF0aWMgdm9pZCBydHdf
Y29leF9jaGVja19yZmsoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4gICAgICAgICB9DQo+ICB9
DQo+IA0KPiAtc3RhdGljIHZvaWQgcnR3X2NvZXhfcXVlcnlfYnRfaW5mbyhzdHJ1Y3QgcnR3X2Rl
diAqcnR3ZGV2KQ0KPiArdm9pZCBydHdfY29leF9xdWVyeV9idF9pbmZvKHN0cnVjdCBydHdfZGV2
ICpydHdkZXYpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IHJ0d19jb2V4ICpjb2V4ID0gJnJ0d2Rl
di0+Y29leDsNCj4gICAgICAgICBzdHJ1Y3QgcnR3X2NvZXhfc3RhdCAqY29leF9zdGF0ID0gJmNv
ZXgtPnN0YXQ7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L2NvZXguaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvY29leC5oDQo+
IGluZGV4IDU3Y2YyOWRhOWVhNC4uYjY0MDBlODdlNzhkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2NvZXguaA0KPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2NvZXguaA0KPiBAQCAtMzg0LDYgKzM4NCw3IEBAIHUzMiBy
dHdfY29leF9yZWFkX2luZGlyZWN0X3JlZyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1MTYgYWRk
cik7DQo+ICB2b2lkIHJ0d19jb2V4X3dyaXRlX2luZGlyZWN0X3JlZyhzdHJ1Y3QgcnR3X2RldiAq
cnR3ZGV2LCB1MTYgYWRkciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMy
IG1hc2ssIHUzMiB2YWwpOw0KPiAgdm9pZCBydHdfY29leF93cml0ZV9zY2JkKHN0cnVjdCBydHdf
ZGV2ICpydHdkZXYsIHUxNiBiaXRwb3MsIGJvb2wgc2V0KTsNCj4gK3ZvaWQgcnR3X2NvZXhfcXVl
cnlfYnRfaW5mbyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KTsNCj4gDQo+ICB2b2lkIHJ0d19jb2V4
X2J0X3JlbGlua193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7DQo+ICB2b2lkIHJ0d19j
b2V4X2J0X3JlZW5hYmxlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4gaW5kZXggNjJkOWFiYzA0YTM0
Li42OTk4NzBjYTFhOWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvbWFpbi5jDQo+IEBAIC0yNjEsNiArMjYxLDkgQEAgc3RhdGljIHZvaWQgcnR3X3dhdGNoX2Rv
Z193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gICAgICAgICBydHdfY29leF93bF9z
dGF0dXNfY2hlY2socnR3ZGV2KTsNCj4gICAgICAgICBydHdfY29leF9xdWVyeV9idF9oaWRfbGlz
dChydHdkZXYpOw0KPiANCj4gKyAgICAgICBpZiAocnR3ZGV2LT5jaGlwLT5pZCA9PSBSVFdfQ0hJ
UF9UWVBFXzg4MjFBICYmIHJ0d2Rldi0+ZWZ1c2UuYnRjb2V4KQ0KPiArICAgICAgICAgICAgICAg
cnR3X2NvZXhfcXVlcnlfYnRfaW5mbyhydHdkZXYpOw0KPiArDQoNCk1vdmUgdG8gYW4gaW5kaXZp
ZHVhbCBmdW5jdGlvbiBzdWNoIGFzIHJ0d19jb2V4X2FjdGl2ZV9xdWVyeV9idF9pbmZvKCkgKG1h
eWJlIGlubGluZSBmdW5jdGlvbiksDQphbmQgYWRkIGEgbGl0dGxlIGJpdCBjb21tZW50cyB0byBk
ZXNjcmliZSBob3cgd2UgbmVlZCB0aGlzLiANCg0KPiAgICAgICAgIHJ0d19waHlfZHluYW1pY19t
ZWNoYW5pc20ocnR3ZGV2KTsNCj4gDQo+ICAgICAgICAgcnR3X2hjaV9keW5hbWljX3J4X2FnZyhy
dHdkZXYsDQo+IC0tDQo+IDIuNDYuMA0KDQo=

